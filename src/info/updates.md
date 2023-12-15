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

## Getting firmware images without updating

My own tablets don't connect to the internet at large. (They do connect to the wifi network at my house, but my firewall is configured with rules to *not* forward traffic from the tablets to the outside world. This allows me to SSH into the tablets without a USB cable, and allows my Linux server to automatically back up the tablets whenever they're connected and not sleeping.)

Because of this, I have to use [remarkable-update](https://github.com/ddvk/remarkable-update) to install firmware updates. However, that still leaves me with the problem of how to *get* the update images.

The process I use is below.

* This works with macOS and Linux, and it *might* work for windows, if the tools are avaliable for it.

* I'm using the `10.11.99.x` IPs which are normally used when the tablet is connected to the computer via USB cable. If you connect to your tablet using wifi, or if you've manually changed the tablet's DHCP server to use a different IP range, you will need to adjust some IP addresses below.

&#x2139;&#xFE0F; One of the items on my "to-do list" is to write a script which automates this process. This may or may not include *installing* the new image on a tablet, I'm not sure yet.

> &#x26A0;&#xFE0F; **The reMarkable 1 and reMarkable 2 use different images.**
>
> This is because they have different hardware. The rm2 images, for example, don't include support for the three hardware buttons on the rm1.
>
> If you own both models, you will need to do this process once for each model, and you'll need to be careful to install the correct image on each tablet.

### Identify your computer's IP address

Before we get into this, there's something that you'll need to understand.

> Computers don't have IP addresses.
>
> **Computers have interfaces, and INTERFACES have IP addresses.**
>
> Every device which talks on a network will have one or more *interfaces*. The most common examples of this are ethernet ports, wifi connections, and a weird thing called a "localhost" interface which usually has `127.0.0.1` or `::1` as its address, and doesn't connect to anything other than the machine itself.
>
> When you connect a reMarkable tablet via USB cable, the computer thinks it's a USB ethernet interface, and uses DHCP to request an IP address. The tablet runs a DHCP server on the USB cable's "network", which assigns the interface at the computer's end of the cable, an IP address in the same IP range as the tablet. Normally the tablet is `10.11.99.1`, and the computer will be assigned an address in the `10.11.99.(2-6)` range.

Identify the IP address *to which* the tablet will need to connect, in order to reach your laptop.

You can see your computer's IP addresses using a command like "`ip -4 addr show`" or "`ifconfig -a`". (For windows I *think* it's "`ipconfig /all`" maybe?) You're looking for the IP which is in the same network segment with the tablet - if you're connected via USB cable this will be in the `10.11.99.(2-6)` range.

This document will assume the IP is `10.11.99.2`, adjust below as necessary.

### Start a listener

On the computer, start a copy of either [netcat](https://sectools.org/tool/netcat/) (aka `nc`) or [ncat](https://nmap.org/ncat/), listening on a port. One or both should be available from your system's software repositories (i.e. `yum`, `dnf`, `apt`, `brew`, etc.)

For this document I'll use `nc` (because it comes with macOS) and `8000` as the port number.

```
$ nc -ln 10.11.99.2 8000 | tee 01-req.txt
```

At this point, your computer is listening for incoming network connections. Listening on the `10.11.99.x` interface means that only other devices on that network segment (i.e. the tablet) will be able to connect - if something on a wifi or other network tries to connect ro port 8000 they won't be able to.

You won't see any output right away, this is fine. When the tablet sends a request to ask for available upgrades, you will see it in this window, *and* it will be sent to the `01-req.txt` file as well.

### Configure the tablet

We need to make the tablet talk to our listener when searching for updates.

SSH into the tablet, and edit the `/usr/share/remarkable/update.conf` file.

```
# nano /usr/share/remarkable/update.conf
```

If this is the first time you've done this (since the last OS upgrade), the file will contain something like this:

```
[General]
#REMARKABLE_RELEASE_APPID={98DA7DF2-4E3E-4744-9DE6-EC931886ABAB}
#SERVER=https://updates.cloud.remarkable.engineering/service/update2
#GROUP=Prod
#PLATFORM=reMarkable2
REMARKABLE_RELEASE_VERSION=3.5.2.1807
```

Add a `SERVER=` line at the bottom which points to our listener. If you already had a `SERVER=` line which was not commented out, either comment out the existing line, or edit that line.

* Use `http://` rather than `https://`.
* Use the IP for the computer, and the port number where your listener is ... listening.
* Copy the rest of the URL from the commented-out `SERVER=` line.

When you're finished, the file should look something like this:

```
[General]
#REMARKABLE_RELEASE_APPID={98DA7DF2-4E3E-4744-9DE6-EC931886ABAB}
#SERVER=https://updates.cloud.remarkable.engineering/service/update2
#GROUP=Prod
#PLATFORM=reMarkable2
REMARKABLE_RELEASE_VERSION=3.5.2.1807
SERVER=http://10.11.99.2:8000/service/update2
```

Save your changes and exit the editor.

* For `nano`, type CONTROL-X.
* For `vi`, hit ESC then "`:wq`".

### Trigger an update attempt

* Make sure the "update-engine" service is NOT running.

    This is especially important if you've just edited the config file - if it *was* already running and you don't stop it, it won't know about your config changes and will try to talk to whatever `SERVER=` was previously configured in the file.

    ```
    systemctl stop update-engine.service
    ```

    This is the same as turning off the "automatic updates" switch in the tablet's Settings screen.

* Wait a few seconds, then start the service.

    ```
    systemctl start update-engine.service
    ```

    This is the same as turning on the "automatic updates" switch in the tablet's Settings screen.

* Tell the service to check for updates NOW.

    ```
    /usr/bin/update_engine_client -check_for_update
    ```

    You won't see anything happening, but behind the scenes the "update-engine" service will be sending a request for available updates to your listener. (The listener won't *answer* the request, but that's fine - we're not trying to actually *do* an update right now.)

* Wait 5-10 seconds, and then stop the "update-engine" service.

    ```
    systemctl stop update-engine.service
    ```

    When you stop the service, the listener on your computer should also stop by itself.

### Examine the request

**If you're curious**, you can look at the request that the tablet sent to your listener (i.e. that it *thought* it was sending to reMarkable).

```
$ cat 01-req.txt
POST /service/update2 HTTP/1.1
Host: 10.11.99.2:8000
Accept: */*
Content-Type: text/xml
Content-Length: 883

<?xml version="1.0" encoding="UTF-8"?>
<request protocol="3.0" version="3.5.2.1807" requestid="{nnnnnnnn-nnnn-nnnn-nnnn-nnnnnnnnnnnn}" sessionid="{nnnnnnnn-nnnn-nnnn-nnnn-nnnnnnnnnnnn}" updaterversion="0.4.2" installsource="ondemandupdate" ismachine="1">
    <os version="codex 3.1.266-2" platform="reMarkable2" sp="3.5.2.1807_armv7l" arch="armv7l"></os>
    <app appid="{98DA7DF2-4E3E-4744-9DE6-EC931886ABAB}" version="3.5.2.1807" track="Prod" ap="Prod" bootid="{nnnnnnnn-nnnn-nnnn-nnnn-nnnnnnnnnnnn}" oem="RM110-nnn-nnnnn" oemversion="3.1.266-2" alephversion="3.5.2.1807" machineid="nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn" lang="en-US" board="" hardware_class="" delta_okay="false" nextversion="0.0.0" brand="" client="" >
        <ping active="1"></ping>
        <updatecheck></updatecheck>
        <event eventtype="3" eventresult="2" previousversion=""></event>
    </app>
</request>
```

As you can see, there are two "parts" of the file - headers and body, separated by a blank line. The body is an XML message containing information about the tablet making the request, particularly the "current" firmware version. This is because firmware updates need to be done in "steps", as explained above.

Note that I have obscured some values in the example which could be used to identify the tablets I used as an example while writing this page.

### Extract the request body

We're going to send this request to reMarkable. In order to do this, we'll need to extract *just* the body from the request. You *can* do this by hand, but it's easier to use `sed` for this.

```
sed '1,/^\r*$/d' 01-req.txt > 02-req.txt
```

This `sed` command is ...

* `START,END d` = delete lines from `START` to `END` (inclusive)
    * START is "`1`", meaning the first line of the file
    * END is "`/^\r*$/`", meaning the first line in the file which is either empty, or contains only "`\r`" (the "carriage return" character, ASCII 13).

        This is because the request that the tablet sends uses "`\r\n`" as the line ending. Some versions of `sed` may recognize this as a line ending, but most will only recognize "`\n`" (the "newline" or "line feed" character, ASCII 10) as the line ending, so that supposedly blank line may actually contain a "`\r`" character. The pattern "`^\r*$`" matches *either* a line containing just "`\r`", or a line containing nothing at all.

    So this command will delete lines from the beginning of the file until the empty line (between the headers and the body), and then copy all other lines as-is.

**If you're curious**, you can inspect the results afterward, and see that it only contains the request body.

```
$ cat 02-req.txt
<?xml version="1.0" encoding="UTF-8"?>
<request protocol="3.0" version="3.5.2.1807" requestid="{nnnnnnnn-nnnn-nnnn-nnnn-nnnnnnnnnnnn}" sessionid="{nnnnnnnn-nnnn-nnnn-nnnn-nnnnnnnnnnnn}" updaterversion="0.4.2" installsource="ondemandupdate" ismachine="1">
    <os version="codex 3.1.266-2" platform="reMarkable2" sp="3.5.2.1807_armv7l" arch="armv7l"></os>
    <app appid="{98DA7DF2-4E3E-4744-9DE6-EC931886ABAB}" version="3.5.2.1807" track="Prod" ap="Prod" bootid="{nnnnnnnn-nnnn-nnnn-nnnn-nnnnnnnnnnnn}" oem="RM110-nnn-nnnnn" oemversion="3.1.266-2" alephversion="3.5.2.1807" machineid="nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn" lang="en-US" board="" hardware_class="" delta_okay="false" nextversion="0.0.0" brand="" client="" >
        <ping active="1"></ping>
        <updatecheck></updatecheck>
        <event eventtype="3" eventresult="2" previousversion=""></event>
    </app>
</request>
```

### Send the request to reMarkable

This will send a POST request to reMarkable, with the original message body that came from the tablet. As far as reMarkable knows, your tablet is sending the request.

 ```
curl -XPOST \
    -H 'Content-Type: text/xml' \
    -H "Content-Length: $( wc -c 02-req.txt | awk '{print $1}' )" \
    --data-binary @02-req.txt \
    https://updates.cloud.remarkable.engineering/service/update2 \
    > 03-response.txt
```

As you can see, this saves reMarkable's response in an `03-response.txt` file.

### Get the image URL

Look at the response you received from reMarkable.

```
$ cat 03-response.txt
<?xml version='1.0' encoding='UTF-8'?>
<response protocol="3.0" server="prod">
  <daystart elapsed_seconds="9791" elapsed_days="6142"/>
  <app appid="{98DA7DF2-4E3E-4744-9DE6-EC931886ABAB}" status="ok">
    <event status="ok"/>
    <updatecheck status="ok">
      <urls>
        <url codebase="https://updates-download.cloud.remarkable.engineering:443/build/reMarkable%20Device/reMarkable2/3.7.0.1930/"/>
      </urls>
      <manifest version="3.7.0.1930">
        <packages>
          <package name="3.7.0.1930_reMarkable2-XSMSQgBATy.signed" required="true" size="79221928" hash="WLN5qHEaHxC24dLF65rGGoz8Ma4="/>
        </packages>
        <actions>
          <action event="postinstall" successsaction="default" sha256="3Jl13KQIJvbdU+Z5AFagEo3Xx227lWAB2tDFbUxAil8=" DisablePayloadBackoff="true"/>
        </actions>
      </manifest>
    </updatecheck>
    <ping status="ok"/>
  </app>
</response>
```

There are two parts of this which need to be extracted:

* `<url codebase="___" />`
* `<package name="___" />`

Copy and paste these two values into a single string. The result will look like this:

```
https://updates-download.cloud.remarkable.engineering:443/build/reMarkable%20Device/reMarkable2/3.7.0.1930/3.7.0.1930_reMarkable2-XSMSQgBATy.signed
```

**This is the URL of the actual image file.**

### Download the image

Fairly self-explanatory.

**Note:** the option in this command is an "uppercase letter O", not a "digit zero".

```
$ curl -LOv https://updates-download.cloud.remarkable.engineering:443/build/reMarkable%20Device/reMarkable2/3.7.0.1930/3.7.0.1930_reMarkable2-XSMSQgBATy.signed
```

This file can then be installed on a reMarkable tablet using [RCU](http://www.davisr.me/projects/rcu/) or [remarkable-update](https://github.com/ddvk/remarkable-update).
