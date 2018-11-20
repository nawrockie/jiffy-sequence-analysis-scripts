# gi|1002359362|gb|KU721767.1| --> KU721767.1
while($line = <>) { 
  chomp $line;
  if($line =~ /^gi\|\d+\|\S+\|(\S+\.\d+)\|.*/) { 
    print $1 . "\n";
  }
  else { 
    die "ERROR unable to parse $line\n";
  }
}
