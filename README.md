# Born2BRoot
42 Curriculum (Level 1) - System administration project

## Use
The only executable file used for this project is a bash script used to extract information regarding the system: in this project this information is displayed every 10 minutes through cron and the command `$ wall`

## Description
The goal of the project was to set up a virtual machine as a web server and learn the basics of system administration. The project was developed on Debian without a GUI.  
  
### Users and groups
One of the tasks was to create a user
`# useradd user_name`  
  
create a group  
`# groupadd group_name`  
  
and add the user both to the new group and to the sudo-ers group  
`# usermod -aG group_name user_name`  

### Security
One of the tasks concerned security, more specifically the implementation of a secure password policy  
`# vim /etc/pam.d/common-password`  

and blocking ssh connections through the root user  
`# vim /etc/ssh/sshd_config`  

### Firewall and Port Forwarding
It was also needed to install UFW and keep only the port 4242 open  
`# ufw allow 4242`  

This port would have also be used for ssh connections, therefore it was needed to modify the default ssh port from 22 to 4242 (also in the sshd_config file). This would have allowed the access to the virtual machine through ssh connection  
`$ ssh -P 4242 user_name@ip_address`

### Cron
One of the last tasks was to setup a cron job to post the output of the bash script in the resources every 10 minutes. 
`# crontab -e` allowes the user to edit the cron jobs, which were specifically set as  
`@reboot sleep 60; bash ~/path_to/monitoring.sh | wall`  
`*/10 * * * * bash ~/path_to/monitoring.sh | wall`  

### Bonus
An optional task was also to install Wordpress and setup a landing page. The backend was built with MariaDB and Lighhtpd, and the whole process was done according to Wordpress guidelines (https://wordpress.org/support/category/installation/)
