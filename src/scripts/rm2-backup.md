# The `rm2-backup` script

This is a shell script which makes backups of the tablet's entire filesystem, under a directory on your workstation. You can control where the backups are written by changing the `BACKUP=` line near the top of the script.

Each backup will be written to a directory *within* the `BACKUPS=` directory, whose name will be the UTC timestamp when the backup started.

### Hard Links and inodes

The script creates "hard-linked" backups.

In order to understand how hard-linked backups work, you first need to understand what hard links and "inodes" are. Feel free to skip ahead if you already know this bit.

Most Unix-type filesystems (including Mac's HFS+ and APFS, as well as ext2/3/4, xfs, btrfs, zfs, and most other Linux filesystems) store different aspects of things called "files" in three different places:

* Zero or more blocks of disk space store the *contents* of the file. Obviously, the number of blocks depends on how big the file is.

* **A data structure known as an "inode"** (normally written with a lowercase "I"), which contains ...

    * A list of the disk blocks containing the file's data
    * The file's size, ownership, permissions, timestamps, and other "metadata".
    * **inodes do not contain filenames.**

* The filesystem's directory structure contains a list of filenames, along with the *inode that each name points to*.

**When two or more filenames point to the same inode, they are said to be "hard links" of each other.**

Files which are hard-linked ARE the same file, they just have different names. This is similar to how the terms "The White House" and "1600 Pennsylvania Avenue" are different names for the same building.

The important thing for *this* discussion is, because hard-linked files *are* the same file, they only use enough disk blocks to hold *one copy* of the file, even if there are thousands of names pointing to it.

> &#x2139;&#xFE0F; **Symbolic Links**
>
> A symbolic link, or "symlink", is a file whose metadata says that it's a symlink, and whose contents are a path to the file it points to. The kernel's filesystem code recognizes the symlink flag and knows to "follow" the link when accessing files and directories.
>
> A symlink is a separate file, with its own inode number and its own metadata. The "contents" of a symlink are the pathname that it points to, and the "size" of a symlink is the length of that pathname.

### How the script works

The script uses a program called `rsync`, which is used to synchronize one directory *into* another.

* When the script runs for the first time, it tells `rsync` to download everything on the tablet.

* After this, the script will tell `rsync` compare each file against the previous backup.

    * Files which *have* changed since, or which didn't exist in, the previous backup, will be downloaded.

    * Files which *have not* changed will be stored as "hard links" to the same file in the previous backup.

Doing this means that, if a certain file never changes, the backup on your workstation will only contain one copy of the file, even if there are hundreds of names (in different directories) pointing to it.

You can see this in action. The `df` command knows about hard links, and knows not to include "links to a file which has already been counted" in the totals it comes up with.

```
$ cd ~/rm2-backup/
$ du -sh *
294M	2023-06-29T042646Z
1.6M	2023-06-29T115727Z
1.5M	2023-06-29T130720Z
4.1M	2023-06-30T005227Z
 35M	2023-06-30T133813Z
2.2M	2023-06-30T204714Z
```

Other than the first directory (which was the first backup I made of the tablet), the sizes shown here for each directory are just the files which changed since the previous backup.

If you run separate `du` commands for each directory, each execution of `du` won't be aware of which files were counted by the previous execution, so it will count the files in that directory.

```
$ cd ~/rm2-backup/
$ for x in 20* ; do du -sh $x ; done
294M	2023-06-29T042646Z
294M	2023-06-29T115727Z
294M	2023-06-29T130720Z
295M	2023-06-30T005227Z
326M	2023-06-30T133813Z
326M	2023-06-30T204714Z
```

## License

This script is licensed under the MIT License.

> **The MIT License (MIT)**
>
> Copyright &copy; 2023 John Simpson
>
> Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Script

&#x21D2; [Download](rm2-backup)

```bash
#!/bin/bash
#
# rm2-backup
# John Simpson <jms1@jms1.net> 2023-06-29
#
# Back up the reMarkable 2 tablet, using rsync with the '--link-dest' option
# so each backup only "contains" the files which changed from the previous
# backup.
#
# Requirements:
#
# - SSH access to the tablet. Ideally you should have key-based authentication
#   set up, otherwise you'll have to type the tablet's password when running
#   the script.
#
# - The location where you're storing the backups should be on a UNIX-type
#   filesystem which supports "hard links" (i.e. multiple filenames pointing
#   to the same inode). This is true of most Linux filesytems, as well as the
#   macOS "HFS", "HFS+", and "APFS" filesystems.
#
# - rsync version 3.1.1 or higher. In earlier versions (such as the version
#   that Apple includes with macOS), the '--link-dest' option didn't use hard
#   links, and every backup conained a full copy of the tablet's filesystem,
#   which took longer and used a LOT more disk space.
#
# If you're using macOS and are stuck with its ancient version of rsync, you
# can install a newer/working version from Homebrew. https://brew.sh/
#
# 2023-07-17 jms1 - Add 'latest' symlink in the backup directory.
#
###############################################################################
#
# The MIT License (MIT)
#
# Copyright (C) 2023 John Simpson
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the “Software”),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#
###############################################################################

########################################
# How to access the tablet.
# - The last character should be "/".

TABLET="root@10.11.99.1:/"

########################################
# Where you plan to store the backup images.

BACKUPS="$HOME/rm2-backups/"

###############################################################################
#
# usage

function usage {
    MSG="${*:-}"

    cat <<EOF
$0 [options]

Create a time-based backup of a reMarkable or reMarkable 2 tablet.

Time-based backups are written to directories named after the time when the
backup started. The script will identify the most recent backup, and any files
which have not changed since that backup will be stored as "hard links" to the
same file in the previous backup, rather than copying and storing another copy
of the same file.

-t ___  Specify the root of the tablet's filesystem. This needs to be in a
        format that 'rsync' understands.
        Default: root@10.11.99.1:/

-b ___  Specify the directory in which the time-based backups will be written.
        Default: $HOME/rm2-backup/

-h      Show this help message.

EOF

    if [[ -n "$MSG" ]]
    then
        echo "$MSG"
        exit 1
    fi

    exit 0
}

###############################################################################
###############################################################################
###############################################################################
#
# Handle the command line

while getopts ':hb:t:' OPT
do
    case $OPT in
        h)  usage
            ;;
        b)  BACKUPS="${OPTARG}"
            ;;
        t)  TABLET="${OPTARG}"
            ;;
        *)  usage "ERROR: unknown option '-${OPTARG}'"
            ;;
    esac
done

shift $(( OPTIND - 1 ))

########################################
# Make sure the location where we're storing the backups, exists.

if [[ ! -d "$BACKUPS" ]]
then
    echo "ERROR: '$BACKUPS' does not exist or is not a directory, cannot continue"
    exit 1
fi

########################################
# Get current timestamp, used for the backup directory name.

NOW="$( date -u '+%Y-%m-%dT%H%M%SZ' )"

########################################
# Find the most recent previous backup.
# - This assumes that the timestamps all start with "2", and that the 'ls'
#   command sorts the names correctly. THIS WILL BREAK in the year 3000.

PREV="$( ls -d1 "$BACKUPS"/2* | tail -1 )"
if [[ -n "$PREV" ]]
then
    LINKPREV="--link-dest=$PREV"
else
    LINKPREV=""
fi

###############################################################################
#
# Back up the files

set -x

rsync -avzHl $LINKPREV  \
    --exclude   /dev    \
    --exclude   /proc   \
    --exclude   /run    \
    --exclude   /sys    \
    "$TABLET"         \
    "${BACKUPS%/}/$NOW/"

rm -f "${BACKUPS%/}/latest"
ln -s "$NOW" "${BACKUPS%/}/latest"
```
