#!/usr/bin/env perl
# EPN, Thu Aug  2 09:17:11 2018
# histo-tbl.pl
# Create a histogram given input data.
#
use warnings;
use strict;
use Getopt::Long;

my $usage;
$usage  = "perl histo-tbl.pl <esl-histplot output>";
$usage .= "\tOPTIONS:\n";
$usage .= "\t\t--skipzero: do not output bins with 0 counts\n";

my $do_skipzero = 0; # 1 to print all points, else only print points with nonzero counts
&GetOptions( "skipzero" => \$do_skipzero);
             

my %ct_H = (); # count per bin
my %fr_H = (); # fraction per bin
my %cu_H = (); # cumulative fraction per bin
my $tot_ct = 0;
my @bin_A = ();
while(my $line = <>) { 
  if($line !~ m/^&/) { 
    my @el_A = split(/\s+/, $line);
    if(scalar(@el_A) != 2) { 
      die "ERROR unable to parse $line";
    }
    my ($bin, $ct) = (@el_A);
    if((! $do_skipzero) || ($ct > 0)) { 
      $bin =~ s/\.0+//;
      $ct_H{$bin} = $ct;
      $tot_ct += $ct;
      push(@bin_A, $bin);
    }
  }
}

my $cum = 0;
printf("%-8s  %8s  %8s  %8s\n", "#bin", "count", "fraction", "cfraction");
printf("%-8s  %8s  %8s  %8s\n", "#-------", "--------", "--------", "--------");
foreach my $bin (@bin_A) { 
  $fr_H{$bin} = $ct_H{$bin} / $tot_ct;
  $cum += $fr_H{$bin};
  $cu_H{$bin} = $cum;
  printf("%8d  %8d  %8.5f  %8.5f\n", $bin, $ct_H{$bin}, $fr_H{$bin}, $cu_H{$bin});
}
