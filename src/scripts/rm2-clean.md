# The `rm2-clean` script

> &#x26A0;&#xFE0F; **This script is not ready yet.**
>
> Currently it works against a filesystem image, so it works on a tablet if you use `ssh` to mount the tablet's filesystem. I still need to add the code to make it SSH into a tablet, both to download the JSON files and to delete the files which need to be removed.


The reMarkable software was designed to synchronize all documents with their cloud service. This includes telling the cloud when things are deleted, and not *actually* deleting documents until they have also been deleted from the cloud.

**If your tablet doesn't synchronize with the cloud**, this means that the documents you delete will never actually be *deleted* from your tablet, and will just sit there taking up space. If you use the tablet long enough, **it will eventually run out of space.**

This script will find and removes those files.

## Details

The word "deleted" can mean a few different things.

* **Trash** is a special "folder" where documents are moved to when you "delete" them using the reMarkable software. This is the same idea as macOS's Trash, or windows' Recycle Bin.

    The reMarkable software will show you these files if you tap "Menu &#x2192; Trash". While it's showing the Trash folder, you will have an option to restore the file (which puts it into the "root directory", aka "My files"), a "Delete" function which *permanently* deletes a file, and an "Empty trash" function which *permanently* deletes all files in the Trash folder.

* **Deleted files** are files which have been "permanently deleted" from the Trash folder, but a record of the files' *being* deleted has not been sync'ed up to the cloud yet.

    On a tablet which synchronizes with "the cloud", "permanently deleted" files are not *actually* deleted from the tablet's filesystem until after the tablet tells "the cloud" that they no longer "exist". I'm assuming this is so that the cloud doesn't sync the files back down to the tablet later on.

    The reMarkable software keeps these files around until the next time it syncs against the cloud, and *then* deletes them... which is not very helpful if the tablet *never* synchronizes against the cloud.

* **Orphans** are random files in the tablet's filesystem which are ignored by the reMarkable software. This may include files which *were* once part of a reMarkable document which no longer "exists", because the `UUID.metadata` file no longer exists.

    This can happen if the tablet shuts down in the middle of an operation, if somebody is manually tinkering with the filesystem and deletes a `.metadata` file they shouldn't have, or if there's a bug in the reMarkable software.


**For tablets which DO synchronize with the cloud**, you should use the reMarkable software as it was designed, and let the tablet "sync the deletions" with the cloud. This should cover everything *other than* Orphans.

**For tables which DO NOT synchronize with the cloud**, you may want to use this script once in a while, to clean up the "permanently deleted" files *and* to clean up any Orphans which may appear.

## Using the script

- run with no options to LIST files in any "deleted-ish" state

- options to list only files in one "deleted-ish" state (i.e. orphans only, for tablets which *do* sync)
    - in Trash folder
    - deleted
    - orphans (both UUID-related and random filenames)

- is there a quick way to tell whether or not a given tablet sync's?

- run with specific options to delete files in different status'es
    - `rm` deleted files
    - `rm` orphans
    - `rm` specific UUID - removes all files relating to that UUID, even if it's not in a "deleted-ish" state
    - `rm` specific filename - removes just the one file, if directory then removes that directory and its contents

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

## The Script

&#x21D2; Download not available yet
