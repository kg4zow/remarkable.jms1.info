# Backing Up the Tablet

**reMarkable's cloud service is a SYNC service, not a BACKUP service**. A lot of people *treat* it like a backup service, and it can be used as kind of a backup if you're careful, however ...

* If somebody or something deletes a document from the cloud, *even by accident*, that file is gone. And as soon as your tablet checks in with the cloud, the tablet will delete its copy of that document as well.

* The "somebody or something" which deletes documents from the cloud is *normally* another reMarkable tablet or app, but it could also be a malicious "hacker" who breaks into reMarkable's or Google's servers, or who gets the password for your cloud account.

* People *have* reported documents suddenly being deleted with no warning, and no way to get them back. I think I've heard about this three times over the past year and a half, and to be fair it's *possible* that these problems could all be attributed to human error, but unless I can be 100% sure, I don't recommend relying on it.

Whether you use the reMarkable cloud or not, I encourage you to make *real backups* of your documents, as `.rmdoc` files, on a regular basis. You may also want to make backups as PDF files as well, since this allows you to view or print the documents from your computer.

### File Types

Files can be backed up in a few different formats. The most common formats are:

* **PDF files** are a standard file format for presentation-ready pages. They contain directions for how to "draw" a series of pages, either on a computer screen or on a printer. Most operating systems include programs to view and print PDF files.

    If you download a reMarkable notebook as a PDF, any pen strokes you've added "on top of" the original PDF will be "burned into" the downloaded PDF. If you later upload that PDF back to the tablet, you will find that your original pen strokes are no longer edit-able.

* **RMDOC files** are what reMarkable calls "Archives". You can think of them as ZIP file containing all of the individual files from the tablet's internal filesystem which make up that document, because that's exactly what they are.

    Because they contain the *actual* files from the tablet's internal filesystem, if you uplod them back to a tablet, the original pen strokes will still be pen strokes, and will still be edit-able.

* **RMN files** are the same basic idea as RMDOC files, however they use TAR instead of ZIP as the container format. These files are used with [RCU](http://www.davisr.me/projects/rcu/), a third-party program which


## The `rm2-backup` script

One of the first things I did when I got my first reMarkable tablet was figure out how to make a backup of everything stored in the tablet. I started by copying a script I've been using to back up Linux servers for 25+ years. It saves disk space by building a series of directories whose names are timestamps of when the backup started. Files which haven't changed since the previous backup are stored as "hard links" to the same file in the previous backup.

I removed a few details which aren't necessary for backing up a tablet, and added some comments so that people reading the script should be to follow along with what the script is doing.

The script itself is documented in more detail on [this page](../scripts/rm2-backup.md).


## The `rmbackup` script

After a few people started using `rm2-backup`, somebody on reddit suggested tracking successive backups as commits in a git repo, rather than in timestamped directories. I thought this was a great idea, so I wrote an entirely new backup script which also uses `rsync` to copy the files, but without the options to create timestamped directories.

It *can* also ...

* create `.rmdoc` and/or `.rmn` files from the backed-up raw files
* download PDF files from the tablet's built-in web interface
* track the backed-up files in a git repo
* push that repo to a remote server

This is the "big brother" of `rm2-backup`, and is the one I use to back up my primary tablet every day.

&#x21D2; [Github](https://github.com/kg4zow/rm2-scripts/tree/main/rmbackup)


## The `rmweb` program

This is a backup program which uses *only* the tablets' built-in web interface. I started it as a side project, to get some experience with [Go](https://go.dev/). When the rMPP was announced and "developer mode" was explained, I realized that people whose tablets were not in "developer mode" would still need a way to make backups, so I got the program into a working state, figured out how to make "releases" on Github, and started telling people about it.

It isn't able to back up the internal files from the tablet's filesystem, but it can download `.rmdoc` and PDF files.

&#x21D2; [Github](https://github.com/kg4zow/rmweb)
