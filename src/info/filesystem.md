# The reMarkable Tablet's Filesystem

## Document Storage

The reMarkable software presents the user with a collection of notebooks, organized into folders. The overall structure is very similar to how a computer stores files within directories.

Under the covers, notebooks and folders are actually stored as sets of files in the `/home/root/.local/share/remarkable/xochitl/` directory. Every notebook or folder has an internal ID number, formatted as a UUID. Each item has one or more files associated with it.

The files I've seen, and my *guesses* about what they're used for, are ...

### `UUID.metadata`

This file exists for every notebook or folder. If this file doesn't exist, the UUID "doesn't exist", and the reMarkable software will ignore any other files relating to that UUID.

This is a JSON file containing an object with the following keys ...

* `visibleName` - (String) The item's name, as shown in the reMarkable UI.

* `type` - (String) "`CollectionType`" for folders, "`DocumentType`" for notebooks. If other values are possible, I haven't seen them.

* `parent` - (String) The UUID of the item (folder) which "contains" this item.

    * For items in the "top level" (not in any folder) this is an empty string.

    * For items moved to the Trash, this is "`trash`".

* `deleted` - (Boolean) if `true`, the item has been deleted.

    Note that "in the trash" and "deleted" are different conditions. See the section below about deleted files for more details.

* `pinned` - (Boolean) If `true`, the item is marked as a "Favourite".

The following keys appear to be used when synchronizing files with the reMarkable Cloud. I don't use the cloud, so I don't know for sure.

* `lastModified` - (String) contains a string of digits. Appears to be a UNIX timestamp, with three extra digits that I'm assuming are milliseconds. From the name I'm guessing this records the last time the notebook's content was modified.

* `metadatamodified` - (String) same as `lastModified`, but it records the last time the notebook's metadata was modified.

* `modified` - (Boolean) I'm guesing this is a flag which tells if the item has been modified since the last time the item was sync'ed.

* `synced` - (Boolean) I'm guessing this is a flag which tells if the item has *ever* been sync'ed.

* `version` - (Integer)

This list only contains the keys I've *seen* in the files, along with my *guesses* about what they're for.

### `UUID.content`

This file exists for every notebook or folder.

This is a JSON file containing information about the item.

* For folders, this appears to be just a list of tags.

* For notebooks, this contains information about each page within the notebook, along with settings relating to the drawing tools (i.e. the current pen, stroke width, colour, and so forth).

Note that pages which have been deleted are still *listed* in this file, however it looks like the files containing the page's contents *are* deleted. I'm guessing this is so that, the next time the tablet synchronizes with the cloud, it can tell the cloud to delete its copy of that page.

### `UUID.local`

Every one of these files is exactly four bytes, containing a JSON empty object.

```
{
}
```

If I had to guess, I would say this has something to do with synchronizing with "the cloud", and these files on *my* tablets are all empty because I've never sync'ed with the cloud.

### `UUID.pagedata`

For notebooks, this appears to contain the name of the "template" used when creating new pages.

For folders, *if* the file exists, it appears to contain a bunch of newlines. No idea why.

### `UUID.epub`

For documents which were uploaded as EPUB files, this appears to be the original `.epub` file, renamed to the UUID. The tablet keeps this around so that if the user changes the formatting, it can create a new PDF.

### `UUID.epubindex`

Looks like a list of the individual files contained within an EPUB file, stored in some kind of 16-bit encoding.

```
00000000  00 00 00 1a 00 72 00 4d  00 20 00 65 00 70 00 75  |.....r.M. .e.p.u|
00000010  00 62 00 20 00 69 00 6e  00 64 00 65 00 78 00 00  |.b. .i.n.d.e.x..|
00000020  00 01 3f f0 00 00 00 00  00 00 40 5f 40 00 00 00  |..?.......@_@...|
00000030  00 00 bf f0 00 00 00 00  00 00 00 00 00 08 ff ff  |................|
00000040  ff ff 00 00 00 00 00 00  00 28 00 00 00 2a 00 4f  |.........(...*.O|
00000050  00 45 00 42 00 50 00 53  00 2f 00 68 00 74 00 6d  |.E.B.P.S./.h.t.m|
00000060  00 6c 00 2f 00 63 00 6f  00 76 00 65 00 72 00 2e  |.l./.c.o.v.e.r..|
00000070  00 68 00 74 00 6d 00 6c  00 00 00 00 00 00 00 01  |.h.t.m.l........|
00000080  00 00 00 00 00 00 00 01  00 00 00 28 00 4f 00 45  |...........(.O.E|
00000090  00 42 00 50 00 53 00 2f  00 68 00 74 00 6d 00 6c  |.B.P.S./.h.t.m.l|
000000a0  00 2f 00 70 00 72 00 30  00 31 00 2e 00 68 00 74  |./.p.r.0.1...h.t|
000000b0  00 6d 00 6c 00 00 00 01  00 00 00 29 00 00 00 01  |.m.l.......)....|
000000c0  00 00 00 03 00 00 00 2a  00 4f 00 45 00 42 00 50  |.......*.O.E.B.P|
000000d0  00 53 00 2f 00 68 00 74  00 6d 00 6c 00 2f 00 74  |.S./.h.t.m.l./.t|
000000e0  00 69 00 74 00 6c 00 65  00 2e 00 68 00 74 00 6d  |.i.t.l.e...h.t.m|
000000f0  00 6c 00 00 00 2a 00 00  00 03 00 00 00 04 00 00  |.l...*..........|
...
```

I'm *guessing* this file is generated when an EPUB file is uploaded and converted to PDF, and then just not deleted afterward?

### `UUID.pdf`

For documents which were uploaded as PDF files, this appears to be the original `.pdf` file, renamed to the UUID.

For documents which were uploaded as EPUB files, this is a copy of the ebook, converted to PDF. This PDF file is what the reMarkable software actually shows on the screen when you're "reading" an EPUB file.

### `UUID.tombstone`

**In firmware version (3.5?) and later**, the reMarkable firmware creates one of these files whenever a document is "deleted from the trash", and deletes all of the other files which made up the document. If you "empty the trash", this happens for *every* document in the trash at the time.

The file itself contains a timestamp showing when the file was deleted.

```
reMarkable: ~/ cd ~/.local/share/remarkable/xochitl/
reMarkable: ~/.local/share/remarkable/xochitl/ ls -la *.tombstone
-rw-r--r--    1 root     root            24 Jul 30 20:16 033f139e-d2c9-479f-944e-8c9ae86a3aea.tombstone
-rw-r--r--    1 root     root            24 Jul 30 20:16 7a483e59-be38-4bec-b899-d2c874ec51ab.tombstone
-rw-r--r--    1 root     root            24 Jul 30 20:16 895bdd6d-1b2e-4c3c-b3c4-48030c26591c.tombstone
-rw-r--r--    1 root     root            24 Jul 30 20:16 d67b9d2c-82bf-4448-bc6f-2f8e9384dc6e.tombstone
-rw-r--r--    1 root     root            24 Jul 30 20:16 d864c483-9115-4e0f-9168-d11e179b40f2.tombstone
-rw-r--r--    1 root     root            24 Jul 30 20:16 f1a69b0c-aec3-400a-bb37-d258cd77de49.tombstone
reMarkable: ~/.local/share/remarkable/xochitl/ cat f1a69b0c-aec3-400a-bb37-d258cd77de49.tombstone
Sun Jul 30 20:16:23 2023
```

See "[Deleted Files](#deleted-files)" below for more details.

### `UUID/` (Directory)

This directory contains `UUID.rm` files for each page. These files contain the actual pen strokes you've written on each page.

Found a [reddit post](https://www.reddit.com/r/RemarkableTablet/comments/15dc1du/comment/ju220pe) with a link to a [blog post](https://plasma.ninja/blog/devices/remarkable/binary/format/2017/12/26/reMarkable-lines-file-format.html) which details the file format. Looks like earlier verisons stored the pen strokes for all pages in a single file, while file format v3 stores each page's pen strokes in a separate file.

Note that the page's UUIDs are different from the notebook's UUID. The UUIDs for the individual pages are stored in the `UUID.content` file (see above).

### `UUID.thumbnails/` (Directory)

This directory contains thumbnail images for each page. These files use the same per-page UUIDs as the "lines files" in the `UUID/` directory.

The thumbnails are 280x374 pixel `.jpg` files.

## Deleted Files

The reMarkable UI offers a way to logically delete files by moving them to a "Trash" folder. This offers a way to "un-delete" files which may be deleted by mistake. This is similar to the "trashcan" or "recycle bin" used by many other desktop environments.

The contents of the "Trash" folder can be seen by tapping "Menu" at the top left, and selecting "Trash" near the bottom of the menu.

While viewing the Trash folder ...

* At the top right will be an "Empty trash" option. Selecting this will "permanently" remove everything in the Trash folder.

* If you long-press on an item (folder or notebook), there will be options at the top right for ...

    * Restore - this will move the item back into whatever folder it was originally deleted from.

    * Delete - this will "permanently" delete the item.

Depending on the firmware version, permanently deleting an item may or may not remove the files from the tablet's filesystem.

* Prior to (3.5?), this would add a `"deleted": true` key to the `UUID.metadata` file, which tells the desktop environment to never show the file. None of the files which make up the document were actually deleted until the next time the tablet sync's with the cloud.

    This provides a way for the tablet to tell the cloud that the document should be deleted there. If this didn't happen and the cloud has a copy of the document, the next sync would download the document from the cloud to the tablet.

* In firmware (3.5?) and later, the files *are* deleted, and a `UUID.tombstone` file is created. This also allows the tablet to tell the cloud to delete the document, but doesn't require keeping a full copy of the entire document on the tablet.

If your tablet synchronizes with "the cloud" on a regular basis, this is fine, and it's actually a good idea - if the files *were* deleted from the tablet without the cloud knowing about it, the next synchronization would "restore" the files to the tablet, which rather defeats the purpose of deleting the files in the first place.

### Tablets which do not sync

For tablets which never synchronize with "the cloud", this means that deleted items will *never* truly be removed from the tablet. At some point, the tablet's internal storage will fill up, and if you only ever use the reMarkable UI, *you're pretty much stuck*.

Some might say that reMarkable deliberately designed the tablets to *force* people to connect them to "the cloud", and that anybody who doesn't link their tablet to the cloud deserves what they get. I don't know that I would go that far, I think it's more likely that they designed the system to provide a useful set of features, and didn't spend a whole lot of time thinking about users who can't, or don't want to, use a cloud service. (The fact that they *later* added the `UUID.tombstone` files would seem to indicate that this is the case.)

Whatever the cause, the fact remains that for tablets like mine which never talk to "the cloud", items which are "deleted" are not actually deleted, and eventually the internal storage will run out.

I first noticed this when I was looking through the various `UUID.xxx` files from a backup, and found that a few sets of UUID files contained "dummy notes" I had created when the tablet first arrived and I was looking at what each of the "pens" looked like. I *knew* I had deleted these notebooks, and then later "emptied the trash" so they weren't showing up there anymore, but they were still were, taking up space on the filesystem.

I also saw this issue mentioned when I was browsing through the [awesome-reMarkable](https://github.com/reHackable/awesome-reMarkable) list, and looked at [reMarkable CLI tooling](https://github.com/cherti/remarkable-cli-tooling), which includes a Python script called `reclean.py` that deletes all files for UUIDs whose `.metadata` files say they have been deleted.

I was pleasantly surprised to find that [RCU](http://www.davisr.me/projects/rcu/) recognizes these files, and if the tablet isn't linked to a "cloud account", will offer to permanently delete them for you.

## Templates

The `/usr/share/remarkable/templates/` directory contains all of the built-in template files.

Templates are "background layers" which can be used with notebooks, to provide a "guide" for your handwriting, or to create an on-screen "form" that you can fill out. The tablet comes with templates which look like lined paper, quad-ruled graph paper, and "dot paper", as well as things like musical staves and pre-made day-planner pages.

The directory also contains a `templates.json` file, which tells the reMarkable software what templates are available, what their names are (the name shown in the reMarkable software is *not* the same as the filename in this directory), what orientation they should use (portrait or landscape), and what icon to show the user in the "template picker" screen.

The reMarkable software doesn't provide a way to add more templates, but if you SSH into the tablet you can add your own templates, and if you edit the `templates.json` file you can make the reMarkable software use your templates along with the built-in templates.

#### Notes

* &#x26A0;&#xFE0F; **Every OS upgrade will reset the contents of this directory.**

    [RCU](http://www.davisr.me/projects/rcu/) works around this by ...

    * uploading the files to `/home/root/.local/share/remarkable/templates/` (which is NOT reset by OS upgrades)
    * creating *symlinks* in the `/usr/share/remarkable/templates/` directory, pointing to the actual files in `/home/root/.local/share/remarkable/templates/`.

    It also stores an individual JSON file for each template in `/home/root/.local/share/remarkable/templates/`, containing that template's attributes, while at the same time adding that information to the global `template.json` file.

    After an OS upgrade, RCU can "re-add" your custom templates by re-creating those symlinks and adding the items from each template's JSON file back to the global `template.json` file.

* According to [a Reddit comment](https://www.reddit.com/r/RemarkableTablet/comments/14yikb6/comment/jrtlr8g) by the author of RCU ...

    > There is another way, which isn't officially supported and which very little information exists about. If you make a `templates.json` file in `~/.local/share/remarkable/templates/custom` and put your files there, they ought to persist through software updates.

    I haven't tried this myself, however I did notice that on my tablet, RCU *created* this directory but hasn't stored anything in it. *My guess* is that the author is exploring this as an easier way to store custom templates (i.e. without having to create symlinks or edit the built-in `templates.json` file).

    This now makes me want to run `strings` against the `xochitl` executable (aka "the reMarkable software") to see what other directories the software uses. Hrmmmmm...

## Splash Screens

The `/usr/share/remarkable/` directory contains the graphics files shown on the screen when the tablet is sleeping, rebooting, starting up, and so forth. Most of the filenames make it obvious what each file is used for.

* `batteryempty.png` - From the name, I'm guessing the tablet shows this screen when the battery is too low to keep working. Because e-ink screens don't consume power unless the display is *changing*, it can show this image as the last thing before doing a total shutdown, and the image will stay on the screen forever (or until the user presumably charges the battery enough for the tablet to boot again).

* `factory.png` - This is the image that was on the screen when I first took the tablet out of the box, before I powered it on.

* `overheating.png` - There is a temperature sensor inside the tablet, I guess it shows this when the tablet gets too hot?

* `poweroff.png` - This is shown when you power the tablet all the way off.

* `rebooting.png` - This is shown while the tablet is rebooting.

* `releasenotes.png` - ?

* `releaseupdates.png` - ?

* `restart-crashed.png` - I guess the tablet *can* show different images for reboots because the user requested it and reboots because of a software crash? This is a symlink to `rebooting.png`, which means the same image is used in both cases.

* `starting.png` - This is shown while the tablet is starting up.

* `suspended.png` - This is shown while the tablet is sleeping. This is the one most people seem to want to customize.

You can replace these files to change the screens shown by the tablet. Your custom files need to be `.png` files, 1404x1872, with 8-bit greyscale colour space.

#### Notes

* The directory contains more than just these graphics files. Be very careful not to delete, rename, or otherwise modify anything by accident.

* These files will be replaced with reMarkable's original files whenever the tablet's OS is upgraded. As with templates, you may want to store your custom files under `/home/root/` somewhere, and create *symlinks* in the `/usr/share/remarkable/` directory which point to your custom files.
