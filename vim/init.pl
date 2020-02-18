#! perl -w

use strict;

use File::Copy::Recursive qw(dircopy);
use FindBin;

sub init_vim {
  my $src = "$FindBin::Bin/vim/lib/";
  dircopy($src, $_[0]) or die "Copy failed: $!";
}

1;
