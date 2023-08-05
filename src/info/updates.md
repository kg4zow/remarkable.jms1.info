# Updating the Firmware

## How the update process works

This section explains how the upgrade process *normally* works, for a tablet which is able to connect to the internet.

I've had mine for about a month, and have yet to actually connect it to *any* wifi network. I was able to figure this out using [remarkable-update](https://github.com/ddvk/remarkable-update) to "intercept" the process. The details of how I did this will be covered below.

### Tablet asks about updates

The tablet sends an HTTPS POST request to a reMarkable server, asking if an update is available. The body of the request is an XML block containing ...

* The current firmware version.

* The tablet's serial number (i.e. `RM110-xxx-xxxxx`), along with another machine-specific value called `machineid`.

* A language code. (Mine says "`en-US`".)

* Several other pieces of information which, to be honest, I don't know what they're for.

### Server responds

The server uses the information in the request to decide which firmware update should be installed next, and replies with an XML block containing ...

* The URL of the directory containing the firmware image.

* The filename, size, and hash (a kind of checksum) of the firmware image.

### Tablet downloads image

The tablet builds the full URL of the image from the information in the XML response, then does a normal GET request for that URL.

The image files I've seen, including the 3.5.2.1807 image I just downloaded, are on the order of 80 MB.

### Tablet processes image

The tablet's storage is partitioned into four partitions, with two of them reserved for copies of the operating system. At any given time, only one of these is marked "active", and contains the OS that the tablet should load when it boots up. Normally this will be the OS which is currently running.

* The newly downloaded image is processed, and the new OS is written to the non-active partition. (The downloaded image file *contains* the OS, with other information. The OS needs to be *extracted* from the image.)

* The "active" flag is changed to point to the partition where the OS was just written.

* A black bar is shown at the bottom of the tablet's UI, telling the user to reboot in order to use the updated firmware.

The next time the tablet reboots, it will boot using the newly selected partition, and run the new OS.

## Effects of upgrading

In addition to the newer software being available, any files which previously existed outside of the `/home/` filesystem will be gone, and will need to be created again. This means ...

### The tablet's `root` password will be changed

If you didn't set up a `/home/root/.ssh/authorized_keys` file, you will need to go into the "Settings &#x2192; Help &#x2192; Copyrights and licenses" screen and get the tablet's new root password, as you've probably done before, and then update wherever you may have saved the password.

### The tablet's SSH host keys will be re-generated

If this happens, you may see a message like this, and your client will refuse to connect.

```
$ ssh root@10.11.99.1
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ED25519 key sent by the remote host is
SHA256:oxJFqzp4eH4eI2RhqOy8AR6qIOdrhagfxvww1KKH5g0.
Please contact your system administrator.
Add correct host key in /Users/jms1/.ssh/known_hosts to get rid of this message.
Offending ED25519 key in /Users/jms1/.ssh/known_hosts:14
Host key for 10.11.99.1 has changed and you have requested strict checking.
Host key verification failed.
```

To clear this message, you need to tell your SSH client to "forget" the previously saved host key.

* For OpenSSH (standard on Linux/macOS systems), the "`ssh-keygen -R`" command does this.

    ```
    $ ssh-keygen -R 10.11.99.1
    # Host 10.11.99.1 found: line 14
    /Users/jms1/.ssh/known_hosts updated.
    Original contents retained as /Users/jms1/.ssh/known_hosts.old
    ```

* [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) apparently stores host keys in the registry, under this location:

    ```
    HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\SshHostKeys
    ```

    The only way to delete already-known host keys is to edit the registry by hand.

    I don't use windows so I can't really be any more detailed than this. You may want to do a web search for "putty forget host keys", but be careful with the results - a lot of pages talk about *user* keys, used for authentication, rather than *host* keys. If you see anything that mentions an `authorized_keys` or `.ppk` file (I *think* that's what putty calls the files where it stores user authentication keys?), you're looking at the wrong thing.

* SecureCRT - it *looks like* it stores the known hosts in a text file called `hostsmap.txt`. Find this file, open it in a text editor, remove the line with the old host key, and save it.

    You should be able to find this file in the following locations:


    * windows: in the "Application Data" folder, which is most commonly ...

        ```
        C:\Documents and Settings\%user%\Application Data\VanDyke\Known Hosts
        ```

    * macOS or Linux: no idea. OpenSSH comes with the operating system for free, so other than a brief experiment on Mac OS/X *years* ago, I've never used SecureCRT on a non-windows platform.

* If you're using some other SSH client, you'll need to figure out the mechanics of how to forget previously known host keys.

    &#x2753; If anybody can point me to documentation about how to do this for other SSH clients, or even point out any commonly used SSH clients for other operating systems, let me know and I'll add links here.

Once you've removed the old host key, the next time you SSH into the tablet you will be asked to "accept" the new host key.

```
$ ssh root@10.11.99.1
The authenticity of host '10.11.99.1 (10.11.99.1)' can't be established.
ED25519 key fingerprint is SHA256:oxJFqzp4eH4eI2RhqOy8AR6qIOdrhagfxvww1KKH5g0.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '10.11.99.1' (ED25519) to the list of known hosts.
ｒｅＭａｒｋａｂｌｅ
╺━┓┏━╸┏━┓┏━┓   ┏━┓╻ ╻┏━╸┏━┓┏━┓
┏━┛┣╸ ┣┳┛┃ ┃   ┗━┓┃ ┃┃╺┓┣━┫┣┳┛
┗━╸┗━╸╹┗╸┗━┛   ┗━┛┗━┛┗━┛╹ ╹╹┗╸
reMarkable: ~/
```

### Customizations will be gone

Things like custom templates, static screens, and other "unofficial" customizations will be gone.

If your customizations were installed using [RCU](http://www.davisr.me/projects/rcu/), the custom files themselves will still *exist* under the `/home/` filesystem, but the reMarkable software won't *know* that they exist. When you connect the tablet to RCU after upgrading, RCU will detect these "un-linked" files and offer to re-link them, which will make the reMarkable software know about them again.

Other methods of customizing the tablet may have their own mechanisms to automatically re-install themselves. If worse comes to worst, you may have to just re-load the files, and (in the case of templates) find every page which *was* using the old template, and update it to use the one you just reloaded.

## Upgrade in Steps

At first glance, it seemed to me that reMarkable was going out of their way to prevent people from being able to download firmware images for the tablets. This led to people reverse-engineering the upgrade process (like me, with the page you're reading right now) and building their own ["archives" of past software images](https://archive.org/download/rm110/), and [third party utilities](https://github.com/ddvk/remarkable-update/) to make your tablet install whatever arbitrary firmware image you might want.

I thought this was reMarkable being a "control freak" about the firmware images, but then somebody on the RCU-Develop mailing list pointed out something that I hadn't realized.

**The tablets need to be updated in "steps"**.

For example, you have to update from A&#x2192;B and *then* B&#x2192;C, you can't "jump over" B and upgrade from A&#x2192;C directly. Or for a more specific example, my tablet started 3.0.5.56 on it, and even though there's a 3.5.2 out there, reMarkable's upgrade server said I should upgrade to 3.2.3.1595.

> &#x2139;&#xFE0F; After I upgraded from `3.0.5.56` to `3.2.3.1595`, the next version it offered me was `3.5.2.1807`, so I only had to do a total of two upgrades.
>
> Not a *huge* inconvenience, plus it gave me *two* upgrade processes' worth of information to use in figuring out the details of how upgrades work.

I'm not 100% sure *why* they require that upgrades be done in "steps", however I do have an *educated guess* (based on being a software developer for 20+ years). My guess is ...

* The files stored in the tablet have a certain format, which *may or may not* change from one firmware release to another.

* Part of the firmware update process involves converting the existing data files to the format used by the new firmware.

    This is why you shouldn't "downgrade" without also doing a factory wipe, because once the data files are converted to a newer format, the older firmware might have problems reading them.

* The conversion process only knows how to convert *from* a limited number of "old versions". So in the A-B-C example above, the converter in the "C" firmware may only know how to convert B&#x2192;C, but not A&#x2192;C.

Making users upgrade "in steps" means that every user whose files are "version X", arrived there using the same "chain of format upgrades" as everybody else, so there will only be one set of "upgrade code" to have to support.
