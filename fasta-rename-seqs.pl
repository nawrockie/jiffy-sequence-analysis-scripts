#!/usr/bin/env perl

use strict;
use warnings;

my $usage = "perl fasta_rename_seqs.pl\n\t<name file (2 tokens per line: \"oldname newname\")>\n\t<fasta file>\n";

if(scalar(@ARGV) != 2) {
  die $usage;
}

my ($name_file, $fasta_file) = (@ARGV);
open(NAMEFILE, $name_file) || die "ERROR unable to open $name_file for reading";
my $line = undef;
my %old2new_H = ();
my %new_exists_H = ();
while($line = <NAMEFILE>) {
  chomp $line;
  my @el_A = split(/\s+/, $line);
  if(scalar(@el_A) != 2) {
    die "ERROR did not read exactly two lines in name file $name_file line:\n$line\n";
  }
  my ($old_name, $new_name) = (@el_A);
  if(defined $old2new_H{$old_name}) {
    die "ERROR read old name $old_name twice in $name_file\n";
  }
  if(defined $new_exists_H{$new_name}) {
    die "ERROR read new name $new_name twice in $name_file\n";
  }
  $old2new_H{$old_name} = $new_name;
}
close(NAMEFILE);

open(FASTAFILE, $fasta_file) || die "ERROR unable to open $fasta_file for reading";
while($line = <FASTAFILE>) {
  chomp $line;
  if($line =~ /^\>(\S+)\s*(.*+)$/) {
    my ($old_name, $desc) = ($1, $2);
    my $name2print = (defined $old2new_H{$old_name}) ? $old2new_H{$old_name} : $old_name;
    my $desc2print = (defined $desc) ? $desc : "";
    print(">$name2print $desc2print\n");
  }
  else {
    print $line . "\n";
  }
}
close(FASTAFILE);

