# partition_reporter.sh
*Tested in Ubuntu 16.04*

This script check the partition(s) that you specify, look for the local IP address, VPN address,hostname, and will send an email to the specified email address if the partitions are up or equal to the desired occupation.

It uses swaks for sending emails:
<code>sudo apt-get install swaks</code>

To execute the script be sure the file has execution permissions, if not:
<code>sudo chmod +x partition_reporter.sh</code>

Then:
<code>./partition_reporter.sh</code>

# check.py
*Tested in ubuntu 16.04 and Deepin 15.5

This script uses the default O.S python modules to analize the local disk usage and send and email if defined percentage is exceeded

To put it to work just type in a pc with Internet access:
  <code>sudo python check.py</code>

If there are partitions with 70% usage or more, the script will send an email to the defined email addresses


