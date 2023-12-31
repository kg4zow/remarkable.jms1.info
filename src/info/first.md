# First Impressions

Notes and impressions from the day the unit arrived, 2023-06-27.

## Physical

### Packaging

The tablet, folio, and stylus arrived in a box that was a bit smaller than I had expected. The boxes containing the folio and stylus happened to fit together and be the same size as the box containing the tablet, which I thought was a nice touch. It's obvious that they planned the packaging with the intent of selling the tablet, stylus, and folio as a bundle.

One thing I noticed is that the sticker on the tablet's box with its serial number, doesn't have the MAC address. This is important to me because I create DHCP reservations in my home network, so that devices like this will always have the same IP while I'm at home. This lets me also add DNS records on my internal network (such as "`rm2.internal.`") pointing to those IPs, to make it easier to access them over the network when I need to.

> I was able to get the MAC address by SSH'ing into the unit over the USB cable and running this command.
>
> ```
> ip link show
> ```

### reMarkable 2 Tablet

The tablet itself is *nice*. My absolute first impression when I took it out of the box was how *thin* it is.

The display is not backlit, and the contrast doesn't seem to be adjustable, which makes some of the built-in templates (particularly the "Dots S" template) hard to see when the room isn't very well-lit. The display's usable area has a "margin" of about 1cm on the top, left, and right sides, and about 2.5cm on the bottom.

The screen has a textured surface which, when combined with the plastic tip on the stylus, feels almost exactly like using a pencil to write on paper. (This is probably obvious, it's one of the biggest selling points on their web site.) There are four little rubber "dots" on the back of the tablet, which prevent the tablet from sliding around on a tabletop, or which fit into indentations on the folio if you have one.

There is a power button on the top edge, and a USB-C connector on the bottom edge, both at the far left side of the tablet. There is also a 5-pin POGO connector (little "dots") on the left edge. Internally, these "dots" have the same electrical connections as a USB port. I've seen POGO-pin connectors on other devices, including on the back of my iPad, I'm assuming that the folios with keyboards have five little pins in the correct spots to line up with these "dots" when the folio is attached.

From the reading I did online before the tablet arrived, I know that these five "dots" have the electrical connections to act as a USB port, which is used not only to connect to a keyboard folio, but also used in case you need to [recover from a "bricked" tablet](https://github.com/ddvk/remarkable2-recovery). I wouldn't be surprised if somebody were to make a 3D-printed thingy which clamps on to the tablet, positions five pins over the dots, and ... I dunno, maybe has a female USB-A or USB-c connector that a keyboard or other device can plug into?

### Stylus - "Marker Plus"

The stylus is the size and shape of a normal writing pen. It has a coating on the outside, similar to the tablet screen, which keeps it from slipping in my hand. There are no buttons on the side. There is a small indendation down the length of the stylus, which is where it contacts the tablet when connected. There's also a small indentation near the back end on the other side, with a "reMarkable" logo engraved in it.

The "back end" (away from the tip) seems to be some kind of insert. There's a small gap around the circumference where you can see some kind of metal shining through, and the "cap" which makes up the back end of the stylus has a tiny amoount of "give" to it (i.e. if you press down on it, it moves just a little bit). I'm not sure if the cap is *supposed* to move a little or not.

The stylus attaches magnetically to the right side of the tablet. There seem to be several different magnets involved, both in the stylus and on the tablet. The stylus's "hold" on the tablet is stronger or weaker based on its position and orientation. I found the strongest "hold" when the stylus is pointing "down", with the top of the stylus about 7mm from the top of the tablet. When you get the stylus *near* the right spot, it will magnetically "jump" into this position on its own.

### Folio - "Book Folio", Grey

I got the basic grey fabric folio, because (1) I don't really intend to use a keyboard with it, and (2) from the pictures on the web site, it looked like the outside surface was a coarse-grain fabric which I would be able to grip better than a smooth leather surface. I don't know about the comparison, but I was right about the texture - it is something I'll be able to hold a grip on.

The folio has a metal "bar" inside the spine, which attaches to the tablet magnetically. The magnets are the *only* thing holding the tablet into the folio, and the magnets aren't *that* strong - the tablet almost fell out of the folio twice in the first few days of using it.

The front cover folds all the way around to the back of the tablet, and forms a little round section on the left side. This makes it a bit more stable when holding the tablet with your left hand, however the tablet *can* easily fall out of the folio when you're doing this.

#### Third Party Folio

I have an [iPad cover](https://www.amazon.com/gp/product/B0B1XM1F37/) which has rubber bumpers that fully surround the top, bottom, and sides of the iPad. I have NEVER had the iPad fall out of the cover.

I ended up buying [a third-party folio](https://www.amazon.com/dp/B0BWTRPTFZ) for my reMarkable tablet. (Mine is dark blue, that's not currently listed as an option so maybe they ran out?) It has hard plastic "clips" along the left and right sides, including around the top and bottom corners on the right. I've been using it for a few weeks now, and haven't had any cases where the tablet tried to "fall out of" the folio.

The case is made of a rubberized plastic, with a texture on the outside which is *similar to* the fabric on the grey reMarkable folio. It's also "grippy" enough that it hasn't slipped in my hand while I was carrying it.

Neither folio has a feature where it puts the tablet to sleep when the cover is closed. Which makes sense - the e-ink display only consumes power while the display's contents are being changed, so there's no real harm in *not* putting the unit to sleep.

## Software

### Built-in software

Items on the screen can be selected using both the stylus and your finger.

The "main screen" is a file manager of sorts, which lets you create and navigate through a folder structure, and shows you the various objects stored in the tablet. There are a few types of objects available.

* Folder: a container that you can put other objects into. You can create folders within folders.

* Notebook: a document containing one or more pages.

* Quick sheets: single-page documents, stored in a notebook called "Quick sheets". This notebook is created automatically in the "top level" of the storage, the first time a "Quick sheet" is created. The notebooknd cannot be moved.

Tapping on a folder will open that folder and show those items on the screen.

Tapping on a notebook will open the most recently edited page within the notebook.

While a notebook page is being edited, you can tap the the "Notebook Options" icon (at the very bottom) to change...

- Under "Notebook settings", which page is used as the notebook's "cover image" in the file browser. Options are "Last page visited" or "First page".

- Which orientation (portrait or landscape) should be used when working with the notebook.

    - (later) It didn't occur to me at the time, but I'm not sure if the orientation is per-page or per-notebook. I'll have to try that and see what happens.

While a page is being edited ...

- There will be a &#x25C9; icon at the top left. Tapping this will show or hide the menu bar down the left side of the screen. (The dot within the circle will also move.)

- There will be an &#x24E7; icon at the top right. Tapping this will close the current page and return to the file browser.

### Built-in web interface

While the unit is connected to a computer via USB, you can use a browser *on that computer* to visit [`http://10.11.99.1/`](http://10.11.99.1/). (Be careful that your browser doesn't automatically convert this to "`https://`".)

This will provide a very simple interface which can be used to navigate the folder structure, and download and upload files.

PDF and EPUB files can be uploaded. This is done by navigating to the folder you want to upload into, and then dragging-and-dropping the file from a Finder window into the browser window. The process can take a few seconds to several minutes, depending on the size of the file. The UI doesn't show any kind of "working" indicator while the upload is happening.

Downloaded notebook files will be converted to PDF. If the original document was an uploaded PDF and you've added your own annotations "on top" of it, the PDF you download will have your annotations "burned into" the file, with no (easy) way to remove them if you need the *original* PDF back.

### Reading uploaded PDF/EPUB files

You can tap on them like any other file. The drawing tools are active, so you can add your own annotations "on top of" the file as you see fit. Your annotations are saved as a separate "layer" on top of the file, so *within the tablet* you can open the PDF/EPUB and edit them if needed.

You can also use a PDF as a "template" of sorts, by making a new copy of the PDF file for each notebook where you want to use it. It's not the same as using an actual template, but it does work.

## Disk layout

Random notes from the first time I SSH'd into the tablet.

```
reMarkable: ~/ df -h
Filesystem                Size      Used Available Use% Mounted on
/dev/root               257.7M    234.2M      6.0M  98% /
devtmpfs                325.3M         0    325.3M   0% /dev
tmpfs                   485.8M         0    485.8M   0% /dev/shm
tmpfs                   485.8M    644.0K    485.2M   0% /run
tmpfs                   485.8M         0    485.8M   0% /sys/fs/cgroup
tmpfs                   485.8M      8.0K    485.8M   0% /tmp
tmpfs                   485.8M         0    485.8M   0% /var/volatile
/dev/mmcblk2p1           19.9M    166.0K     19.8M   1% /var/lib/uboot
/dev/mmcblk2p4            6.6G     21.8M      6.2G   0% /home
reMarkable: ~/
```

```
reMarkable: ~/ mount
/dev/mmcblk2p2 on / type ext4 (rw,relatime)
devtmpfs on /dev type devtmpfs (rw,relatime,size=333096k,nr_inodes=83274,mode=755)
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
proc on /proc type proc (rw,relatime)
securityfs on /sys/kernel/security type securityfs (rw,nosuid,nodev,noexec,relatime)
tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev)
devpts on /dev/pts type devpts (rw,relatime,gid=5,mode=620,ptmxmode=000)
tmpfs on /run type tmpfs (rw,nosuid,nodev,mode=755)
tmpfs on /sys/fs/cgroup type tmpfs (ro,nosuid,nodev,noexec,mode=755)
cgroup2 on /sys/fs/cgroup/unified type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate)
cgroup on /sys/fs/cgroup/systemd type cgroup (rw,nosuid,nodev,noexec,relatime,xattr,name=systemd)
debugfs on /sys/kernel/debug type debugfs (rw,nosuid,nodev,noexec,relatime)
tmpfs on /tmp type tmpfs (rw,nosuid,nodev)
fusectl on /sys/fs/fuse/connections type fusectl (rw,nosuid,nodev,noexec,relatime)
configfs on /sys/kernel/config type configfs (rw,nosuid,nodev,noexec,relatime)
tmpfs on /var/volatile type tmpfs (rw,relatime)
none on /run/gadget-cfg type configfs (rw,relatime)
/dev/mmcblk2p1 on /var/lib/uboot type vfat (rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)
/dev/mmcblk2p4 on /home type ext4 (rw,relatime)
reMarkable: ~/
reMarkable: ~/ fdisk -l
Disk /dev/mmcblk2: 7456 MB, 7818182656 bytes, 15269888 sectors
238592 cylinders, 4 heads, 16 sectors/track
Units: sectors of 1 * 512 = 512 bytes

Device       Boot StartCHS    EndCHS        StartLBA     EndLBA    Sectors  Size Id Type
/dev/mmcblk2p1    32,0,1      671,3,16          2048      43007      40960 20.0M 83 Linux
/dev/mmcblk2p2    672,0,1     95,3,16          43008     595967     552960  270M 83 Linux
/dev/mmcblk2p3    96,0,1      543,3,16        595968    1148927     552960  270M 83 Linux
/dev/mmcblk2p4    544,0,1     1023,3,16      1148928   15269887   14120960 6895M 83 Linux
reMarkable: ~/
```
