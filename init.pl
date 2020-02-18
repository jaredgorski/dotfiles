#! perl -w

use strict;

my $home = $ENV{"HOME"};

# Vim
require "./vim/init.pl";
init_vim($home);
