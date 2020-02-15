#!/bin/sh
## specify the partitions to ignore initialy set up for Filesystem|tmpfs|udev
df -H | grep -vE '^Filesystem|tmpfs|udev' | awk '{print $5 " " $1}'  | while read output;
do
  echo $output
  usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )
  partition=$(echo $output | awk '{ print $2 }' )
## Specify percentage initialy setup for 90 percent
  if [ $usep -ge 90 ]; then
  ## Provide email address  to send to email notification
    echo "Running out of space \"$partition ($usep%)\" on $(hostname) as on $(date)" |
     mail -s "Alert: Server Almost out of disk space $usep%" test@gmail.com
  fi
done
