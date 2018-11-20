# /usr/bin/time -p output format, numbers are seconds:
# real 4.99
# user 4.56
# sys 0.19
$tot_real_secs = 0;
$tot_user_secs = 0;
$tot_sys_secs = 0;
$tot_real_ct = 0;
$tot_user_ct = 0;
$tot_sys_ct = 0;
while($line = <>) { 
  if($line =~ m/^real\s+(\d+\.\d+)/) { 
    $tot_real_secs += $1;
    $tot_real_ct++;
  }
  elsif($line =~ m/^user\s+(\d+\.\d+)/) { 
    $tot_user_secs += $1;
    $tot_user_ct++;
  }
  elsif($line =~ m/^sys\s+(\d+\.\d+)/) { 
    $tot_sys_secs += $1;
    $tot_sys_ct++;
  }
}
if(($tot_real_ct > 0) || ($tot_user_ct > 0) || ($tot_sys_ct > 0)) { 
  printf("real $tot_real_secs\n");
  printf("user $tot_user_secs\n");
  printf("sys $tot_sys_secs\n");
  printf("# $tot_real_ct real lines read\n");
  printf("# $tot_user_ct user lines read\n");
  printf("# $tot_sys_ct sys lines read\n");
}
    
