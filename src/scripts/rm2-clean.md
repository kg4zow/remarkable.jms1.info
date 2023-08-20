# The `rm2-clean` Script

The reMarkable software was designed to synchronize all documents with their cloud service. This includes telling the cloud when things are deleted, and not *actually* deleting documents until they have also been deleted from the cloud.

If your tablet doesn't synchronize with the cloud, this means that the documents you delete will never actually be *deleted* from your tablet, and will continue to take up space. If this goes on long enough, **the tablet will eventually run out of space.**

This script will show, and can remove, these files.

## Details

The word "deleted" can mean a few different things.

* **Trash** is a special "folder" where documents are moved to when you "delete" them using the reMarkable software. This is the same idea as macOS's Trash, or windows' Recycle Bin.

    The reMarkable software will show you these files if you tap "Menu &#x2192; Trash". While it's showing the Trash folder, you will have an option to restore the file (which puts it into the "root directory", aka "My files"), a "Delete" function which *permanently* deletes a file, and an "Empty trash" function which *permanently* deletes all files in the Trash folder.

* **Deleted files** are files which have been "permanently deleted" from the Trash folder, but a record of the files' *being* deleted has not been sync'ed up to the cloud yet.

    These appear in the filesystem as one of the following:

    * For earlier firmware versions, the `UUID.metadata` file will exist, and contain the key `"deleted" : true`.

    * Later firmware versions will delete all of the normal `UUID.*` files, and instead create a `UUID.tombstone` file, whose contents are the timestamp when the trash was deleted.

    On a tablet which synchronizes with "the cloud", "permanently deleted" files are not *actually* deleted from the tablet's filesystem until after the tablet tells "the cloud" that they no longer "exist". I'm assuming this is so that the cloud doesn't sync the files back down to the tablet later on.

    The reMarkable software keeps these files around until the next time it syncs against the cloud, and *then* deletes them... which is not very helpful if the tablet *never* synchronizes against the cloud.

* **Orphans** are random files in the tablet's filesystem which are ignored by the reMarkable software. This may include files which *were* once part of a reMarkable document which no longer "exists", because the `UUID.metadata` file no longer exists.

    This can happen if the tablet shuts down in the middle of an operation, if somebody is manually tinkering with the filesystem and deletes a `.metadata` file they shouldn't have, or if there's a bug in the reMarkable software.


**For tablets which DO synchronize with the cloud**, you should use the reMarkable software as it was designed, and let the tablet "sync the deletions" with the cloud. This should cover everything *other than* orphans.

**For tables which DO NOT synchronize with the cloud**, you may want to use this script once in a while, to clean up the "permanently deleted" files *and* to clean up any Orphans which may appear.

## Using the script

### Setup

* Make sure you're able to SSH into the tablet. Ideally, you should set up an SSH key so you can SSH into the tablet without a password.

### Running the script

* Running the script with no options will list any files on the tablet in any "delete-able" state. These files will be flagged as DELETED or ORPHAN.

    ```
    $ rm2-clean
    UUID                                  Trash  Deleted  Orphan  Name
    d67b9d2c-82bf-4448-bc6f-2f8e9384dc6e  TRASH                   /Delete Me
    8141cc15-7881-40eb-9456-781dd6b0730a         DELETED          /Derp
    8d06afae-3d2b-486d-8758-1b3c1a745cdb         DELETED          /XYZ folder/
                                                          ORPHAN  this-is-an-orphan-file
    ```

    If the script doesn't print anything, it means there are no DELETED or ORPHAN files.

* The "`-a`" option will list all files on the tablet, including files which are not in any kind of "deleted" state.

    ```
    $ rm2-clean -a
    UUID                                  Trash  Deleted  Orphan  Name
    d67b9d2c-82bf-4448-bc6f-2f8e9384dc6e  TRASH                   /Delete Me
    8141cc15-7881-40eb-9456-781dd6b0730a         DELETED          /Derp
    f67c74d2-7d23-4587-95bd-7a6e8ebaed2c                          /Ebooks/
    a628e45e-e627-42ad-8f0c-049f697ec12b                          /Ebooks/Stranger in a Strange Land
    895bdd6d-1b2e-4c3c-b3c4-48030c26591c                          /Ebooks/The Art of Unix Programming
    702ef913-16a0-47b1-806e-1769f251b06b                          /Ebooks/The Cathedral & the Bazaar
    0573fd9d-277e-400c-a2da-2c2a5fce627f                          /Ebooks/Walkaway
    9e6891eb-2558-4e70-b6fc-d03b2d75614b                          /Quick sheets
    383dad70-b9db-4a04-a275-be17cfc6bc8c                          /ReMarkable 2 Info
    015deb02-0589-462a-bc98-3034d7d23628                          /Work/
    636e58a2-1561-4026-811f-df1aa7783bf3                          /Work/Daily 2023-06
    042b2cfe-af17-4056-a9c3-c46762b7170a                          /Work/Daily 2023-07
    8a4f80b1-7132-4c89-867c-7118f7d0912e                          /Work/Random Notes
    4687cc49-3e59-47b8-a1da-d5f14e6a0318                          /Work/Ticket Notes
    8d06afae-3d2b-486d-8758-1b3c1a745cdb         DELETED          /XYZ folder/
                                                          ORPHAN  this-is-an-orphan-file
    ```

### TODO

* recognize/report `UUID.tombstone` files
    * UUID in filename *was* the UUID of a documented that was emptied from the trash
    * contents is a timestamp (in `Sun Jul 30 20:16:21 2023` format)
    * replaces `"deleted"` attribute in `UUID.metadata` files
    * also document on filesystem page

* document other options
    * `-o` and `-O`
    * `-d` and `-D`
    * `-u ___`
    * `-x`
    * `-h`

- options to list *only* files in one "deleted-ish" state (i.e. orphans only, for tablets which *do* sync)
    - in Trash folder
    - deleted (same as "tombstone" files?)
    - orphans (both UUID-related and random filenames)

- Is there a quick way to tell whether or not a given tablet sync's?
    - yes, RCU does it
    - may be unsafe to delete "deleted" or "tombstone" files if so

- run with specific options to delete files in different status'es
    - `-O` and `-D` already exist, need to be documented
    - specific UUID - removes all files relating to that UUID, even if it's not in a "deleted-ish" state
    - specific filename (for orphans) - removes just the one file, if directory then removes that directory and its contents

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

&#x21D2; [Download](rm2-clean)

```perl
{{#include rm2-clean}}
```
