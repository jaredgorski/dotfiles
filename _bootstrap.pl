#! perl -w

######################################################################
#
# This script runs any and all uncommented bootstrap tasks defined
# within the config.df file.
#
######################################################################

use strict;

use FindBin;
use Getopt::Long;

# A nice greeting
my $greeting = << 'EOS';
              +-----------------------------------------------+
              |                                               |
              |     jaredgorski/dotfiles  --  BOOTSTRAP       |
              |                                               |
              +-----------------------------------------------+
EOS
print "\n\n$greeting\n";

# Declare global variables
my (
    $bindir,                        # this directory
    $config,                        # the config file
    $config_exists,                 # flag to denote whether config exists
    $platform_name,                 # name of the platform targeted
);

$platform_name = '';

# Get program options
GetOptions('platform=s' => \$platform_name);

if ($platform_name eq "macos") {
    $platform_name = "MACOS";
} elsif ($platform_name eq "linux") {
    $platform_name = "LINUX";
} else {
    die "\n    ! No valid platform detected. Aborting.\n\n";
}
print "\n    PLATFORM: $platform_name\n\n";

$bindir = $FindBin::Bin;

$config = "$bindir/config.df";

$config_exists = 0;

if (-e $config) {
    $config_exists = 1;
} else {
    die "\n    ! No config file found. Aborting.\n\n";
}

open my $fh, "<", $config or die "Could not open config file: $!\n";

my $bootstrap_section = 0;
my $bootstrap_prefix = '';
while (my $line = <$fh>)
{
    $line =~ s/^\s+|\s+$//g;

    next if ($line =~ m/^#/ || $line !~ m/\S/);

    if ($line =~ m/\[\Q$platform_name\E: BOOTSTRAP BEGIN\]/) {
        $bootstrap_section = 1;
        next;
    } elsif ($line =~ m/\[\Q$platform_name\E: BOOTSTRAP END\]/) {
        $bootstrap_section = 0;
        $bootstrap_prefix = '';
        next;
    };

    if ($line =~ m/\BOOTSTRAP_PREFIX:/) {
        $line =~ s/^BOOTSTRAP_PREFIX://g;
        $line =~ s/^\s+|\s+$//g;
        $bootstrap_prefix = $line;
        next;
    }

    if ($bootstrap_section && $bootstrap_prefix) {
        my $command = "$bootstrap_prefix $line";

        print "\n\n=====================================================================================\n";
        print "+ BEGIN + \t\t\"$command\"\n\n";

        unless (system("$command") == 0) {
            print "\n\n    ! Can't run bootstrap prefix on $line\n\n";
        }

        print "\n- END -   \t\t\"$command\"\n";
        print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n";
    }
}

close $fh or die "Could not close config file: $!\n";

print "\n";

print "\n    > Success.\n\n";
exit 0;
