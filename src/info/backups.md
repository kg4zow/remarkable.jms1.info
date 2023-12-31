# Backing Up the Tablet

One of the first things I did was make a backup of everything stored in the tablet.

I've been using a backup script based on 'rsync' for many years. (I don't really remember *when* I started, but the fist time I documented the idea was in 2008.) Apparently the idea of using `rsync` with SSH was relatively new back then, I don't honestly remember.

&#x21D2; [old documentation](https://jms1.net/code/rsync-backup.shtml), if you're really curious

Since then, `rsync` has added the "`--link-dest`" option. This works by comparing each file which could be backed up, to a file with the same name in another directory. If the two files are identical, then instead of copying the file, it creates a "hard link" in the backup, referring to the corresponding file in that other directory. This way, if you're backing up a system on a regular basis and a file on that system never changes, the disk where you're storing the backups only contains one copy of the file, even if there are dozens or hundreds of different filenames "pointing to" the file.

I've been using `rsync` with the `--link-dest` option to make recurring backups (usually daily) of my servers, both personally and for whatever `$DAYJOB` was at the time, for many years now.


## The `rm2-backup` Script

I wrote a script to back up my tablet, whcih is essentially the same script I run on a dedicated "backup server" at work (except at work, it pulls backups from a *list* of other machines.) I removed some details which aren't necessary in this case, and added some comments so that people reading the script should be to follow along with what the script is doing.

&#x21D2; The script itself is documented in more detail on [this page](../scripts/rm2-backup.md).

The `$HOME/bin/` directory on my laptop contains a copy of the `rm2-backup` script. When I connect the tablet, if it's been a while (a few hours if I've added or updated anything, or a few days otherwise) since I last did a backup, I run the script by hand. Unless I've uploaded a batch of new ebook files, it normally takes 5-10 seconds to finish.

In this example, it had only been about 15 minutes since the last backup, so there wasn't really much that had changed.

```
$ rm2-backup
+ rsync -avzHl --link-dest=../2023-06-29T122931Z --exclude /dev --exclude /proc --exclude /run --exclude /sys root@10.11.99.1:/ /Users/jms1/backup-rm2/2023-06-29T130720Z/
receiving incremental file list
created directory /Users/jms1/backup-rm2/2023-06-29T130720Z
home/root/.bash_history
home/root/log.txt
home/root/.cache/remarkable/xochitl/telemetry/09a0a8f691b9ee6d/events/20230629-746b1474-81ad-4aca-a22d-ce6f1524ddd9
home/root/.cache/remarkable/xochitl/telemetry/0c091fbab5349230/events/20230628-92752869-9913-417b-8428-b486a1900941
home/root/.cache/remarkable/xochitl/telemetry/18b173bd76b11fe8/events/20230629-5068fd25-f944-450a-aba6-d71d50eb36df
home/root/.cache/remarkable/xochitl/telemetry/294b1efd8e146687/events/20230629-db6a17d6-4a18-41d2-bd5a-b755cd719bd1
home/root/.cache/remarkable/xochitl/telemetry/298cd0ca7547d81b/
home/root/.cache/remarkable/xochitl/telemetry/50568fd036d7eb2c/events/20230628-50289b63-74cf-414e-a0e1-4f43aa2a3f3f
home/root/.cache/remarkable/xochitl/telemetry/b5f6e098bc215a31/events/20230629-700035b4-efe3-4074-896b-6d303aeba58c
home/root/.cache/remarkable/xochitl/telemetry/d6e23be7e72320a0/events/20230628-a0725a9c-2b03-484e-83eb-e4239f590c57
home/root/.cache/remarkable/xochitl/telemetry/dcfa227bd5c7e14c/events/20230629-e7d47bd1-5eda-4b27-afcb-8f21bd0865b9
var/lib/update_engine/
var/lib/update_engine/prefs/
var/log/lastlog
var/log/wtmp
var/log/journal/0f9d28f6d9674924ae87cf7637194d00/system.journal

sent 9,902 bytes  received 331,124 bytes  97,436.00 bytes/sec
total size is 293,688,680  speedup is 861.19
```

This command took about two seconds to finish. As you can see, the total size of all files on the tablet is 293 MB, but `rsync` only had to copy 331 KB of data, because 99% of the files hadn't changed since the previous backup.
