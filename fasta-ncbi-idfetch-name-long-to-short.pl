#!/usr/bin/env perl
# EPN, Tue Jan  1 06:39:31 2019
use warnings;
use strict;
use Getopt::Long;

my $usage;
$usage  = "perl fasta-ncbi-idfetch-name-long-to-short.pl [options] <fasta file>\n";
$usage .= "\tOPTIONS:\n";
$usage .= "\t\t--noversion: remove version from accession.version\n";

my $do_noversion = 0; # 1 to remove version from accession.version
&GetOptions( "noversion" => \$do_noversion);

while(my $line = <>) { 
  if($line =~ /^>(\S+)(\s*.*)/) { 
    chomp $line;
    my ($name, $desc) = ($1, $2);
    if($name =~ /^gi\|\d+\|\S+\|(\S+)\.(\d+)\|.*/) { 
      $name = ($do_noversion) ? $1 : $1 . "." . $2;
    }
    elsif($name =~ /^gb\|(\S+)\.(\d+)\|$/) { 
      $name = ($do_noversion) ? $1 : $1 . "." . $2;
    }
    printf ">%s%s\n", $name, $desc;
  }
  else { 
    print $line;
  }
}
exit 0;
