#! perl -w

use strict;

use File::Copy;
use File::Find;
use File::Path qw(make_path);
use FindBin;

my $greeting = << 'EOS';
    +-------------------------------+
    |                               |
    |   jaredgorski/dotfiles        |
    |                               |
    +-------------------------------+
EOS
print "\n$greeting\n";

# Get $HOME directory
my $home = $ENV{"HOME"};
print " HOME: $home\n";

# Make archive directory for current job
my $timestamp = localtime(time);
my $archive_dir = "$home/.dotfiles_archive/$timestamp";
make_path($archive_dir) or die "Could not create archive directory: $!";
print " ARCHIVE: $archive_dir\n";
my $is_archived = 0;

# Get dotfiles directory paths from PATHS.txt
print "\n1a) Getting dotfiles directory paths from PATHS.txt\n";
my $pathsfile = "$FindBin::Bin/PATHS.txt";
open my $fh, "<", $pathsfile or die "Could not open paths file: $!\n";
chomp(my @dfdir_paths = <$fh>);
close $fh or die "Could not close paths file: $!\n";

# Get dotfiles directory paths to copy rather than link from PATHS_CP.txt and save into hashmap
print "\n1b) Getting list of dotfiles directory paths to copy rather than link from PATHS_CP.txt\n";
my $paths_cp_file = "$FindBin::Bin/PATHS_CP.txt";
open my $fh_cp, "<", $paths_cp_file or die "Could not open paths_cp file: $!\n";
chomp(my @dfdir_paths_cp = <$fh_cp>);
my %dfdir_paths_cp_hash = map { $_ => 1 } @dfdir_paths_cp;
close $fh_cp or die "Could not close paths_cp file: $!\n";

# Link or copy dotfiles to $HOME
sub link_to_home {
  my ($path)= $_;
  my $src = "$FindBin::Bin/$path";
  $path =~ m/.*\//;

  if ($') {
    print "\n    $'";

    my $dest = "$home/$'";
    
    # If destination file exists, archive it
    if (-e $dest && !-l $dest) {
      $is_archived = 1;
      my $archive_dest = "$archive_dir/$'";
      print "\n\t! File exists in \$HOME directory. Moving to archive \n\t  before linking.";
      move $dest, $archive_dest; 
    }

    if (-e $src) {
      my $path_dir = substr $&, 0, -1;
      if (exists($dfdir_paths_cp_hash{$path_dir})) {
        print "\n\t+ Copying: \n\t  $src \n\t    -> $dest\n";
        copy $src, $dest;
      } else {
        print "\n\t+ Linking: \n\t  $src \n\t    -> $dest\n";
        symlink $src, $dest;
      }
    } else {
      print STDERR "\n\tERR: \n\t  Path does not exist: \n\t    $src\n";
    }
  }
}

print "\n2) Linking/copying dotfiles to \$HOME directory\n";
find({ wanted => \&link_to_home, no_chdir => 1 }, @dfdir_paths);

if (!defined $ENV{'DOTFILES'}) {
  print "\nDOTFILES can be found at: $FindBin::Bin\n";
  print "\nTo add \$DOTFILES to a shell config, run:\n\t`echo \"\\nexport DOTFILES=$FindBin::Bin\" >> shells/{{config_filepath}}`\n\n";
} else {
  print "\n";
}

if (!$is_archived) {
  rmdir $archive_dir;
}
