---
layout: post
title: Nifty perl script for webserver backup
category: perl
tags: backup
---

Here's a nice perl script that you could call from a cron job to back up a webserver and its SQL database:

{% highlight perl %}
# DELETE BACKUP AFTER FTP UPLOAD (0 = no, 1 = yes)
$delete_backup = 0;

# ENTER THE PATH TO THE DIRECTORY YOU WANT TO BACKUP, NO TRAILING SLASH
$homedir = '/var/chroot/home/content/94/6992894/html/newsite';

# ENTER THE PATH TO THE LOCAL DIRECTORY YOU WISH TO SAVE THE BACKUP FILE TO, NO TRAILING SLASH
# LOCAL BACKUP DIRECTORY MUST BE OUTSIDE THE HOME DIRECTORY
$backup_dest_dir = '/var/chroot/home/content/94/6992894/backup';


# BACKUP FILE NAME OPTIONS
($a,$d,$d,$day,$month,$yearoffset,$r,$u,$o) = localtime();
$year = 1900 + $yearoffset;
$month++;
$homedir_archive = "homedir_backup-$day-$month-$year.tar.gz";
$full_backup_file = "full_site_backup-$day-$month-$year.tar.gz";

# MYSQL BACKUP PARAMETERS
$dbhost = 
$dbuser = 
$dbpwd = 
$mysql_backup_file = "mysql_databases-$day-$month-$year.sql.gz";
$backup_all_databases = 'yes'; # IF SET TO NO, SPECIFY INDIVIDUAL DATABASE NAME(S) BELOW

# ENTER DATABASE NAMES TO BACKUP SEPARATED BY SPACES (ONLY IF backup_all_databases IS SET TO 'no')
$database_names = 'db1 db2 db3';

# SYSTEM COMMANDS
$cmd_mysqldump = '/usr/bin/mysqldump';
$cmd_gzip = '/usr/bin/gzip';

# ----------- DO NOT EDIT BELOW THIS LINE -----------

# CHECK TO SEE IF DIRECTORY BACKUP EXISTS
if(!-d $homedir)
{
	die "Invalid path name (directory_to_backup): $homedir";
}

# CHECK TO SEE IF LOCAL BACKUP DIRECTORY EXISTS
if(!-d $backup_dest_dir)
{
	print "\nCreating local backup directory: $backup_dest_dir\n";
	mkdir $backup_dest_dir or die "Error creating local backup directory (backup_dest_dir): $backup_dest_dir ";
}

# CURRENT DATE / TIME
($a,$d,$d,$day,$month,$yearoffset,$r,$u,$o) = localtime();
$year = 1900 + $yearoffset;

# BACKUP FILES
print "\nArchiving home directory ($homedir)\n";
$syscmd = "tar --exclude $backup_dest_dir" . "/*  -czf $backup_dest_dir/$homedir_archive -C $homedir .";
system($syscmd);

# MYSQL DATABASE BACKUP
if($backup_all_databases eq 'yes')
{
  print "\nCreating SQL dump of all databases";
  $syscmd = "$cmd_mysqldump --host=$dbhost --user=$dbuser --password=$dbpwd --add-drop-table --all-databases -c -l | $cmd_gzip > $backup_dest_dir/$mysql_backup_file";
}
elsif(!$database_names eq "")
{
  $syscmd = "$cmd_mysqldump --host=$dbhost --user=$dbuser --password=$dbpwd --add-drop-table --databases $database_names -c -l | $cmd_gzip > $backup_dest_dir/$mysql_backup_file";
}
system($syscmd);

# CREATING FULL SITE BACKUP FILE
print "\nCreating full backup archive\n";
if(-e "$backup_dest_dir/$mysql_backup_file") {
	$syscmd = "tar -czf $backup_dest_dir/$full_backup_file -C $backup_dest_dir $homedir_archive $mysql_backup_file";
}
else {
	$syscmd = "tar -C $backup_dest_dir -cvzf $backup_dest_dir/$full_backup_file $homedir_archive";
}

system($syscmd);

print "Sorted.\n";

{% endhighlight %}
