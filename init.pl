#! perl -w

use strict;

use File::Copy;
use File::Find;
use File::Path qw(make_path);
use FindBin;



# A nice greeting
my $greeting = << 'EOS';
      +-------------------------------+
      |                               |
      |       jaredgorski/dotfiles    |
      |                               |
      +-------------------------------+
EOS
print "\n$greeting\n";



# Declare variables
my (
    $home,                          # the $HOME directory
    $is_archived,                   # flag to denote whether files have been archived
    $archive_dir,                   # path to directory where archived files are stored
    $pathsfile,                     # the file containing dirs whose contents to symlink
    $pathsfile_exists,              # flag to denote whether pathsfile exists
    $pathsfile_cp,                  # the file containing dirs whose contents to copy
    $pathsfile_cp_exists,           # flag to denote whether pathsfile_cp exists
    @dfdir_paths,                   # dirs to symlink
    @dfdir_paths_cp,                # dirs to copy
);

# Initialize flags
$is_archived = 0;
$pathsfile_exists = 0;
$pathsfile_cp_exists = 0;

# Define pathsfile and pathsfile_cp filepaths
$pathsfile = "$FindBin::Bin/PATHS.txt";
$pathsfile_cp = "$FindBin::Bin/PATHS_CP.txt";

# Set pathsfile_exists flag
if (-e $pathsfile) {
    $pathsfile_exists = 1;
}

# Set pathsfile_cp_exists flag
if (-e $pathsfile_cp) {
    $pathsfile_cp_exists = 1;
}

# If no paths or paths_cp file, die
unless ($pathsfile_exists || $pathsfile_cp_exists) {
    die "\n    ! No PATHS.txt or PATHS_CP.txt file found.\n\n";
}



# Define sub to link dotfiles to $HOME
sub link_to_home {
    my ($path)= $_;
    my $src = "$FindBin::Bin/$path";

    $path =~ m/.*\//;

    if ($') {
        print "\n\n    $'";

        my $dest = "$home/$'";

        # If destination file exists, respond accordingly
        if (-e $dest && !-l $dest) {
            print "\n\t! File exists in \$HOME directory. Moving to archive \n\t  before linking.";

            my $archive_dest = "$archive_dir/$'";
            move $dest, $archive_dest; 

            # Denote that files have been archived
            $is_archived = 1;
        } elsif (-l $dest) {
            print "\n\t! Symlink already exists in \$HOME directory. Doing nothing.";

            return;
        }

        if (-e $src) {
            print "\n\t+ Linking: \n\t  $src \n\t        -> $dest\n";

            symlink $src, $dest;
        } else {
            print STDERR "\n\tERR: \n\t  Path in PATHS.txt does not exist: \n\t      $src\n";
        }
    }
}

# Define sub to copy dotfiles to $HOME
sub copy_to_home {
    my ($path)= $_;
    my $src = "$FindBin::Bin/$path";

    $path =~ m/.*\//;

    if ($') {
        print "\n\n    $'";

        my $dest = "$home/$'";

        # If destination file exists, respond accordingly
        if (-e $dest && !-l $dest) {
            print "\n\t! File exists in \$HOME directory. Moving to archive \n\t  before copying.";

            my $archive_dest = "$archive_dir/$'";
            move $dest, $archive_dest; 

            # Denote that files have been archived
            $is_archived = 1;
        } elsif (-l $dest) {
            print "\n\t! Symlink exists in \$HOME directory. Removing symlink \n\t  before copying.";

            unlink $dest;
        }

        if (-e $src) {
            print "\n\t+ Copying: \n\t  $src \n\t        -> $dest\n";

            copy $src, $dest;
        } else {
            print STDERR "\n\tERR: \n\t  Path in PATHS_CP.txt does not exist: \n\t      $src\n";
        }
    }
}



# Get and print $HOME directory
$home = $ENV{"HOME"};
print " HOME: $home\n";

# Make and print archive directory for current job
my $timestamp = localtime(time);
$archive_dir = "$home/.dotfiles_archive/$timestamp";
make_path($archive_dir) or die "Could not create archive directory: $!";
print " ARCHIVE: $archive_dir\n";

if ($pathsfile_exists) {
    # Get dotfiles directory paths from PATHS.txt
    print "\n1-ln) Getting dotfiles directory paths for symlink from PATHS.txt\n";

    open my $fh, "<", $pathsfile or die "Could not open paths file: $!\n";
    chomp(@dfdir_paths = <$fh>);
    close $fh or die "Could not close paths file: $!\n";
}

if ($pathsfile_cp_exists) {
    # Get dotfiles directory paths to copy rather than link from PATHS_CP.txt
    print "\n1-cp) Getting list of dotfiles directory paths for copy from PATHS_CP.txt\n";

    open my $fh_cp, "<", $pathsfile_cp or die "Could not open paths_cp file: $!\n";
    chomp(@dfdir_paths_cp = <$fh_cp>);
    close $fh_cp or die "Could not close paths_cp file: $!\n";
}

# If pathsfile exists, link dotfiles in PATHS.txt directories to $HOME directory
if ($pathsfile_exists) {
    print "\n2-ln) Linking dotfiles to \$HOME directory";
    find({ wanted => \&link_to_home, no_chdir => 1 }, @dfdir_paths);
    print "\n";
}

# If pathsfile_cp exists, copy dotfiles in PATHS_CP.txt directories to $HOME directory
if ($pathsfile_cp_exists) {
    print "\n\n2-cp) Copying dotfiles to \$HOME directory";
    find({ wanted => \&copy_to_home, no_chdir => 1 }, @dfdir_paths_cp);
    print "\n";
}

# If $DOTFILES env var is not defined, prompt to add export var to shell config
if (!defined $ENV{'DOTFILES'}) {
    print "\nDOTFILES can be found at: $FindBin::Bin\n";
    print "\nTo add \$DOTFILES to a shell config, run:\n\t`echo \"\\nexport DOTFILES=$FindBin::Bin\" >> {{config_filepath}}`\n";
}

# If is_archived flag is still false, remove empty archive directory for current job
if (!$is_archived) {
    rmdir $archive_dir;
}

# Add whitespace before exit
print "\n";

exit 0;
