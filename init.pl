#! perl -w

######################################################################
#
#   This script uses GNU stow to create, delete, and refresh
#   symlinks between the contents of directories listed
#   in a config file (config.df) and the target directory,
#   normally the user's $HOME directory.
#
#
#   USAGE:
#
#     -t, --target
#         Define target directory. Defaults to $HOME.
#
#     -d, --delete
#         Remove symlinks from target directory based on paths
#         in config.df.
#
#     -r, --restow
#         Remove and re-link symlinks in target directory based 
#         on paths in config.df. Helpful for pruning stale stow 
#         artifacts.
#
######################################################################

use strict;

use FindBin;
use Getopt::Long;
use Stow;

# A nice greeting
my $greeting = << 'EOS';
      +-------------------------------+
      |                               |
      |     jaredgorski/dotfiles      |
      |                               |
      +-------------------------------+
EOS
print "\n$greeting\n";

# Declare global variables
my (
    $bindir,                        # this directory
    $target,                        # the target directory
    $config,                        # the config file
    $config_exists,                 # flag to denote whether config exists
    @config_paths,                  # dirs to symlink
    $delete_flag,                   # flag to denote delete mode
    $restow_flag,                   # flag to denote restow mode
);

# Define bin directory (this directory).
# This will be used as the stow directory
# when Stow looks for "root" directories
# to recursively symlink into $target.
$bindir = $FindBin::Bin;

$config = "$bindir/config.df";

$config_exists = 0;

if (-e $config) {
    $config_exists = 1;
} else {
    die "\n    ! No config file found. Aborting.\n\n";
}

# Initialize option vars
$target       = '';
$delete_flag  = 0;
$restow_flag  = 0;

# Get program options
GetOptions('target=s' => \$target, 'delete' => \$delete_flag, 'restow' => \$restow_flag);

# Verify target directory or use $HOME if not provided
if (-e $target) {
    print "    - TARGET: $target\n";
} elsif (!$target && defined $ENV{"HOME"}) {
    $target = $ENV{"HOME"};
    print "    - TARGET: $target\n";
} else {
    die "\n    ! No target directory. Aborting.\n\n";
}

# Validate and print mode
if ($delete_flag && $restow_flag) {
    die "\n    ! Invalid: simultaneous delete and restow. Aborting.\n\n";
} elsif ($delete_flag) {
    print "\n    - MODE: delete\n";
} elsif ($restow_flag) {
    print "\n    - MODE: restow\n";
} else {
    print "\n    - MODE: default\n";
}

# Proceed with stow tasks
my $stow = new Stow( dir => $bindir, target => $target );

open my $fh, "<", $config or die "Could not open config file: $!\n";

print "\n    - PATHS:";

my $paths_section = 0;
while (my $line = <$fh>)
{
    $line =~ s/^\s+|\s+$//g;

    next if ($line =~ m/^#/);

    if ($line =~ m/\[PATHS BEGIN\]/) {
        $paths_section = 1;
        next;
    } elsif ($line =~ m/\[PATHS END\]/) {
        $paths_section = 0;
        next;
    };

    if ($paths_section) {
        print "\n\t+ $line";
        push(@config_paths, $line);
    }
}

close $fh or die "Could not close config file: $!\n";

print "\n";

if ($delete_flag) {
    $stow->plan_unstow(@config_paths);
} elsif ($restow_flag) {
    $stow->plan_unstow(@config_paths);
    $stow->plan_stow(@config_paths);
} else {
    $stow->plan_stow(@config_paths);
}

my %conflicts = $stow->get_conflicts;
$stow->process_tasks() unless %conflicts;

# Print result and exit
if (!%conflicts) {
    print "\n    > Success.\n\n";
    exit 0;
} else {
    exit 1;
}
