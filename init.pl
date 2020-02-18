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

# Create archive directory for current job
make_path($archive_dir) or die "Could not create archive directory: $!";

print " ARCHIVE: $archive_dir\n";

# Initialize flag to denote whether files have been archived
my $is_archived = 0;

# Get dotfiles directory paths from PATHS_LN.txt
print "\n1a) Getting dotfiles directory paths for symlink from PATHS_LN.txt\n";

my $paths_ln_file = "$FindBin::Bin/PATHS_LN.txt";

open my $fh_ln, "<", $paths_ln_file or die "Could not open paths_ln file: $!\n";
chomp(my @dfdir_paths_ln = <$fh_ln>);
close $fh_ln or die "Could not close paths_ln file: $!\n";

# Get dotfiles directory paths to copy rather than link from PATHS_CP.txt
print "\n1b) Getting list of dotfiles directory paths for copy from PATHS_CP.txt\n";

my $paths_cp_file = "$FindBin::Bin/PATHS_CP.txt";

open my $fh_cp, "<", $paths_cp_file or die "Could not open paths_cp file: $!\n";
chomp(my @dfdir_paths_cp = <$fh_cp>);
close $fh_cp or die "Could not close paths_cp file: $!\n";

# Link dotfiles to $HOME
sub link_to_home {
  my ($path)= $_;
  my $src = "$FindBin::Bin/$path";

  $path =~ m/.*\//;

  if ($') {
    print "\n    $'";

    my $dest = "$home/$'";
    
    # If destination file exists, archive it
    if (-e $dest && !-l $dest) {
      print "\n\t! File exists in \$HOME directory. Moving to archive \n\t  before linking.";

      my $archive_dest = "$archive_dir/$'";
      move $dest, $archive_dest; 

      # Denote that files have been archived
      $is_archived = 1;
    }

    if (-e $src) {
      print "\n\t+ Linking: \n\t  $src \n\t    -> $dest\n";

      symlink $src, $dest;
    } else {
      print STDERR "\n\tERR: \n\t  Path in PATHS_LN.txt does not exist: \n\t    $src\n";
    }
  }
}

# Copy dotfiles to $HOME
sub copy_to_home {
  my ($path)= $_;
  my $src = "$FindBin::Bin/$path";

  $path =~ m/.*\//;

  if ($') {
    print "\n    $'";

    my $dest = "$home/$'";
    
    # If destination file exists, archive it
    if (-e $dest) {
      if (-l $dest) {
        print "\n\t! Symlink exists in \$HOME directory. Removing symlink \n\t  before copying.";

        unlink $dest;
      } else {
        print "\n\t! File exists in \$HOME directory. Moving to archive \n\t  before copying.";

        my $archive_dest = "$archive_dir/$'";
        move $dest, $archive_dest; 

        # Denote that files have been archived
        $is_archived = 1;
      }
    }

    if (-e $src) {
      print "\n\t+ Copying: \n\t  $src \n\t    -> $dest\n";

      copy $src, $dest;
    } else {
      print STDERR "\n\tERR: \n\t  Path in PATHS_CP.txt does not exist: \n\t    $src\n";
    }
  }
}

# Link dotfiles in PATHS_LN.txt directories to $HOME directory
print "\n2a) Linking dotfiles to \$HOME directory\n";

find({ wanted => \&link_to_home, no_chdir => 1 }, @dfdir_paths_ln);

# Link dotfiles in PATHS_CP.txt directories to $HOME directory
print "\n2b) Copying dotfiles to \$HOME directory\n";

find({ wanted => \&copy_to_home, no_chdir => 1 }, @dfdir_paths_cp);

# If $DOTFILES is not defined, prompt to add export var to shell config
if (!defined $ENV{'DOTFILES'}) {
  print "\nDOTFILES can be found at: $FindBin::Bin\n";
  print "\nTo add \$DOTFILES to a shell config, run:\n\t`echo \"\\nexport DOTFILES=$FindBin::Bin\" >> {{config_filepath}}`\n\n";
} else {
  print "\n";
}

# If is_archived flag is still false, remove empty archive directory for current job
if (!$is_archived) {
  rmdir $archive_dir;
}
