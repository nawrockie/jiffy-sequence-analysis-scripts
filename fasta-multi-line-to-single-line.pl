my $ctr = 0;
while($line = <>) { 
  if($line =~ m/^\>/) { 
    if($ctr != 0) { print "\n"; }
    print $line;
    $ctr++;
  }
  elsif($line =~ m/\w/) { 
    chomp $line;
    print $line;
    $ctr++;
  }
}
print "\n";
