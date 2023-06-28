# First Impressions

Notes and impressions from the day the unit arrived, 2023-06-27.

## Physical

### Packaging

The tablet, folio, and stylus arrived in a box that was a bit smaller than I had expected. The boxes containing the folio and stylus happened to fit together and be the same size as the box containing the tablet, which I thought was a nice touch. It's obvious that they planned the packaging with the intent of selling the tablet, stylus, and folio as a bundle.

One thing I noticed is that the sticker on the tablet's box with its serial number, doesn't have the MAC address. This is important to me because I create DHCP reservations in my home network, so that devices like this will always have the same IP while I'm at home. This lets me also add DNS records on my internal network (such as "`rm2.internal.`") pointing to those IPs, to make it easier to access them over the network when I need to.

### reMarkable 2 Tablet

The tablet itself is pretty nice. My absolute first impression when I took it out of the box was how *thin* it is.

The display is not backlit, and the contrast doesn't seem to be adjustable, which makes some of the built-in templates (particularly the "Dots S" template) hard to see when the room isn't very well-lit. The display's usable area has a "margin" of about 1cm on the top, left, and right sides, and about 2.5cm on the bottom.

The screen has a textured surface which, when combined with the plastic tip on the stylus, feels almost exactly like using a pencil to write on paper. (This is probably obvious, it's one of the biggest selling points on their web site.) There are four little rubber "dots" on the back of the tablet, which prevent the tablet from sliding around on a tabletop, or which fit into indentations on the folio if you have one.

There is a power button on the top edge, and a USB-C connector on the bottom edge, both at the far left side of the tablet. There is also a connector with five "dots" on the left edge. Internally, these "dots" have the same electrical connections as a USB port. I've seen similar "dots" connectors on other devices, and I'm assuming that the folios with keyboards have five little pins in the correct spots to line up with these "dots" when the folio is attached.

These five "dots" have the electrical connections to act as a USB port, which is used not only to connect to a keyboard folio, but also used in case you need to [recover from a "bricked" tablet](https://github.com/ddvk/remarkable2-recovery). I wouldn't be surprised if somebody were to make a 3D-printed thingy which clamps on to the tablet, positions five pins over the dots, and ... I dunno, maybe has a female USB connector that a keyboard or other device can plug into?

### Stylus - "Marker Plus"

The stylus is the size and shape of a normal writing pen. It has a coating on the outside, similar to the tablet screen, which keeps it from slipping in my hand. There are no buttons on the side. There is a small indendation down the length of the stylus, which is where it contacts the tablet when connected. There's also a small indentation near the back end on the other side, with a "reMarkable" logo engraved in it.

The "back end" (away from the tip) seems to be some kind of insert. There's a small gap around the circumference, and the "cap" which makes up the back end of the stylus has a tiny amoount of "give" to it (i.e. if you press down on it, it moves just a little bit).

It attaches magnetically to the right side of the tablet. There seem to be several different magnets involved, in both the stylus and the tablet. The stylus's "hold" on the tablet seems to be stronger or weaker based on its position and orientation. I found the strongest "hold" when the stylus is pointing down, with the top of the stylus about 7mm from the top of the tablet. When you get the stylus near the right spot, it will magnetically "jump" into place on its own.

### Folio - "Book Folio", Grey

I got the basic grey fabric folio, because (1) I don't really intend to use a keyboard with it, and (2) from the pictures on the web site, it looked like the outside surface was a coarse-grain fabric which I would be able to grip better than a smooth leather surface. I don't know about the comparison, but I was right about the texture - it is something I'll be able to hold a grip on.

The folio has a metal "bar" inside the spine, which attaches to the tablet magnetically. I discovered by "almost accident" that the magnets are the *only* thing holding the tablet into the folio.

The front cover folds all the way around to the back of the tablet, and forms a little round section on the left side which makes it a bit more stable when holding the tablet with your left hand.

I have an [iPad cover](https://www.amazon.com/gp/product/B0B1XM1F37/) which has rubber bumpers that fully surround the top, bottom, and sides of the iPad. I have NEVER had the iPad fall out of the cover. I'm not sure yet, but I may look for a different folio, one which *securely* holds the tablet.

The folio doesn't have a feature where it puts the tablet to sleep when the cover is closed. Which makes sense - the e-ink display only consumes power while the display's contents are being changed, so there's no real harm in *not* putting the unit to sleep.

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

While a page is being edited ...

- There will be a &#x25C9; icon at the top left. Tapping this will show or hide the menu bar down the left side of the screen. (The dot within the circle will also move.)

- There will be an &#x24E7; icon at the top right. Tapping this will close the current page and return to the file browser.

### Built-in web interface

While the unit is connected to a computer via USB, you can use a browser on *that computer* to visit [`http://10.11.99.1/`](http://10.11.99.1/). (Be careful that your browser doesn't automatically convert this to "`https://`".)

This will provide a very simple interface which can be used to navigate the folder structure, and download and upload files.

Downloaded notebook files will be converted to PDF.

PDF and EPUB files can be uploaded. This is done by navigating to the folder you want to upload into, and then dragging-and-dropping the file from a Finder window into the browser window. The UI is not great, it doesn't really show much while the upload is happening.

### Reading uploaded PDF/EPUB files

You can tap on them like any other file. The drawing tools are active, so you can add your own annotations as you see fit.

## SSH Access

The tablet's SSH server is `dropbear`, which uses `ssh-rsa` for the Host Key. For newer versions of OpenSSH, you will need to manually enable this. Plus adding a specific configuration makes life easier.

Add the following to your workstation's `$HOME/.ssh/config` file.

```
########################################
# reMarkable 2

Host 10.11.99.1 rm rm2 remarkable remarkable2
    Hostname                10.11.99.1
    User                    root
    HostKeyAlgorithms       +ssh-rsa
    PubkeyAcceptedKeyTypes  +ssh-rsa
    ForwardAgent            no
    ForwardX11              no
```

When the tablet is connected to a computer, it presents as a USB ethernet device, with itself at the "other end" of the connection. The tablet assigns itself `10.11.99.1/29`, and runs a DHCP server which will assign `10.11.99.(2-6)` to the computer.

Once the cable is connected, make sure the interface was created on your workstation, and that it has an appropriate IP address.

Once your workstation has an IP, you can find the root password by ...

* Settings &#x2192; Help

* Tap "Copyrights and licenses"

* On the right, below "GPLv3 Compliance", near the bottom, will be a notice saying the following:

    ```
    The General Public License version 3 and the Lesser General Public
    License version 3 also requires you as an end-user to be able to access
    your device to be able to modify the copyrighted software licensed
    under these licenses running on it.

    To do so, this device acts as an USB ethernet device, and you can connect
    using the SSH protocol using the username 'root' and the password
    **'xxxxxxxx'**.

    The IP addresses availabel to connect to are listed below:

    10.11.99.1
    ```

Once you have the password, you can SSH into the unit.

```
(jms1@supermini) 212 $ ssh root@rm
The authenticity of host '10.11.99.1 (10.11.99.1)' can't be established.
ED25519 key fingerprint is SHA256:aLkWmgMQAF/BmQVaNyOlAz5y6pcOz5TEKM/dW/hFh5A.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '10.11.99.1' (ED25519) to the list of known hosts.
root@10.11.99.1's password:
ｒｅＭａｒｋａｂｌｅ
╺━┓┏━╸┏━┓┏━┓   ┏━┓╻ ╻┏━╸┏━┓┏━┓
┏━┛┣╸ ┣┳┛┃ ┃   ┗━┓┃ ┃┃╺┓┣━┫┣┳┛
┗━╸┗━╸╹┗╸┗━┛   ┗━┛┗━┛┗━┛╹ ╹╹┗╸
reMarkable: ~/
```

> According to [their Github repo](https://github.com/reMarkable/linux), "zero sugar" is reMarkable's name for the Linux kernel for the rM2, and "gravitas" is the kernel for the rM1. (Also, finding this answer was the first I had seen any mention of reMarkable having *any* publicly available source code.)
>
> If you're curious, the message is comfing from the tablet's `/etc/motd` file.

### Create `.ssh/authorized_keys`

This will allow you to authenticate using an SSH key. Surprisingly enough, the SSH server seems to support `ed25519` SSH keys, *and* `nano` is pre-installed.

```
reMarkable: ~/ mkdir -m 0700 .ssh
reMarkable: ~/ cd .ssh
reMarkable: ~/.ssh/ nano authorized_keys

reMarkable: ~/.ssh/ ls -laF
drwx------    2 root     root          4096 Jun 27 20:26 ./
drwx------    6 root     root          4096 Jun 27 20:21 ../
-rw-r--r--    1 root     root          1570 Jun 27 20:26 authorized_keys
reMarkable: ~/.ssh/ chmod 0600 authorized_keys
reMarkable: ~/.ssh/
```

### Initial information gathering

```
reMarkable: ~/ ip link show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: sit0@NONE: <NOARP> mtu 1480 qdisc noop qlen 1000
    link/sit 0.0.0.0 brd 0.0.0.0
3: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 70:f7:54:f0:43:89 brd ff:ff:ff:ff:ff:ff
4: usb0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 16:de:37:63:b3:0a brd ff:ff:ff:ff:ff:ff
5: usb1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 2a:ed:54:1f:30:f7 brd ff:ff:ff:ff:ff:ff
reMarkable: ~/ ip -4 a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue qlen 1000
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
5: usb1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast qlen 1000
    inet 10.11.99.1/29 brd 10.11.99.7 scope global usb1
       valid_lft forever preferred_lft forever
reMarkable: ~/
```

```
(jms1@supermini) 31 $ arp -an
? (10.11.99.1) at 2a:ed:54:1f:30:f7 on en13 ifscope [ethernet]
```

MAC addresses

* `70:f7:54:f0:43:89` = wifi
* `2a:ed:54:1f:30:f7` = `usb1` USB-C connector
* `16:de:37:63:b3:0a` = `usb0` five-pin connector on side

### Disk layout

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
