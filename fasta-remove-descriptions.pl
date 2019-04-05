#!/usr/bin/env perl
while($line = <>) { 
  chomp $line;
  if($line =~ /^>(\S+)/) { 
    print ">" . $1 . "\n";
  }
  else { 
    print $line . "\n";
  }
}
