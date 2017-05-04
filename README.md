# Partition checker or Partition reporter
Tested in Ubuntu 16.04

This script check the partition(s) that you specify, look for the local IP address, VPN address,hostname, and will send an email to the specified email address if the partitions are up or equal to the desired occupation.

It uses swaks for sending emails:
<code>sudo apt-get install swaks</code>

To execute the script be sure the file has execution permissions, if not:
<code>sudo chmod +x partition_reporter.sh</code>

Then:
<code>./partition_reporter.sh</code>


