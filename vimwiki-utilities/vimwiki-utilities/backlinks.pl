#! perl -w

use strict;
use warnings;

use File::Basename;
use File::HomeDir;

my (
  $homedir,
  $vimwikidir,
  @vimwiki_zett_files,
  $curr_file,
  @curr_backlinks,
  $curr_backlink,
);

$homedir = File::HomeDir->my_home;
$vimwikidir = "$homedir/vimwiki";

sub get_backlinks {
  my $filename = quotemeta($_[0]);
  my $link_search = "\\[((?!bl_)).*\\]\\($filename";

  my @output = `rg '$link_search' $vimwikidir/zett-* -l --pcre2`;

  my @trimmed_output;
  foreach (@output) {
    chomp;
    $_ =~ s/\s//;
    push @trimmed_output, $_ if $_ ne '';
  }

  return @trimmed_output;
}

@vimwiki_zett_files = <$vimwikidir/zett-*>;
foreach $curr_file (@vimwiki_zett_files) {
  my $file_basename = basename($curr_file);

  @curr_backlinks = get_backlinks($file_basename);

  my $backlinks_str = "";

  if (@curr_backlinks) {
    $backlinks_str = "backlinks:\n";
  }

  foreach $curr_backlink (@curr_backlinks) {
    my $backlink_basename = basename($curr_backlink);

    my $backlink_title = $backlink_basename;
    $backlink_title =~ s/^zett-//;
    $backlink_title =~ s/-\d\d\d\d-\d\d-\d\d-\d\d\d\d\.md//;

    $backlinks_str = "$backlinks_str- [bl_$backlink_title]($backlink_basename)\n";
  }

  open my $in, '<', $curr_file or die "Can't read current file: $!";
  my $new_filedata = "";
  my $match_occurences = 0;
  my $in_old_backlinks = 0;
  while (<$in>) {
    if ($_ eq "---\n" && !$match_occurences) {
      $match_occurences++;
      $new_filedata = "$new_filedata$_";
    } elsif ($_ eq "backlinks:\n") {
      $in_old_backlinks = 1;
      next;
    } elsif ($in_old_backlinks && $_ =~ m/^- \[/) {
      next;
    } elsif ($_ eq "---\n") {
      $new_filedata = "$new_filedata$backlinks_str$_";
    } else {
      $new_filedata = "$new_filedata$_";
    }
  }

  close $in or die $!;

  open my $out, '>', $curr_file or die "Can't write current file: $!";
  print $out $new_filedata;
  close $out or die $!;
}
