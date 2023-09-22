# SSH Access

The reMarkable tablets are designed to allow users to *easily* access the internal software. In addition to charging the battery, the USB-C port acts like an ethernet interface when you connect it to a computer. It also runs a DHCP server, which assigns an IP address to the computer and allows the computer to access the tablet.

The tablet allows incoming SSH connections from the computer, as the `root` user. When the tablet starts for the first time, it makes up a random password for this user. You will be able to find the password in the settings screen.

## Creating an SSH key pair

If you don't already have an SSH key pair, you may want to think about creating one. Having a key pair allows you to authenticate to the tablet *without* having to type a password every time.

There are probably thousands of pages on the net which explain how to create a key pair, so I'm not going to go into a whole lot of detail about it. The quick version is ...

```
$ ssh-keygen -t rsa -b 2048
Generating public/private rsa key pair.
Enter file in which to save the key (/Users/jms1/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /Users/jms1/.ssh/id_rsa
Your public key has been saved in /Users/jms1/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:6HXEMxPkVDSoTHWfYXZJybczcMmzrzkkVaHYMxDt4ZA jms1@laptop.local
...
```

BE SURE TO USE A STRONG PASSPHRASE. Not just a pass*word*, but a pass*phrase*. This is because if anybody manages to steal a copy of your secret key file, this passphrase will be the only thing keeping them from being able to use it.

This will create two files. The `id_rsa` file will contain the SECRET key, encrypted using whatever passphrase you entered. This file should never be shared with anybody, or copied to any machine that you don't have physical control over.

The `id_rsa.pub` file contains your PUBLIC key. This *can* be shared with others, and in this case will be copied to the tablet. Below when it talks about a public key file, this is the file it's talking about.

## Accessing the tablet via SSH

### Configure your SSH client

The tablet's SSH server is [`dropbear`](https://github.com/mkj/dropbear), which uses the RSA algorithm for the Host Key.

The `ssh` client that comes with macOS and Linux is OpenSSH.

The RSA algorithm has been around for many years now, and there are newer algorithms out there. The idea of using RSA host keys is slowly moving towards deprecation, so the *newest* versions of OpenSSH don't support them by default, although they *can* be configured to allow it.

In order to be sure that your OpenSSH will be able to connect to the tablet, add the following to your workstation's `$HOME/.ssh/config` file.

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

### Make sure your workstation has a `10.11.99.x` IP

When the tablet is connected to a computer, the computer "sees" a USB ethernet device, with the tablet "plugged into the other end" of the ethernet wire. The tablet assigns itself `10.11.99.1/29`, and runs a DHCP server which will assign an address in the `10.11.99.(2-6)` range to the computer.

Once the cable is connected, make sure the interface was created on your workstation, and that it has an appropriate IP address. This will generally involve running a command line this:

```
(jms1@laptop) 205 $ ifconfig -a
...
en6: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
	options=6467<RXCSUM,TXCSUM,VLAN_MTU,TSO4,TSO6,CHANNEL_IO,PARTIAL_CSUM,ZEROINVERT_CSUM>
	ether 2a:ac:e7:8e:1b:ba
	inet6 fe80::1063:bf1:8d0e:a0eb%en6 prefixlen 64 secured scopeid 0x18
	inet 10.11.99.3 netmask 0xfffffff8 broadcast 10.11.99.7
	nd6 options=201<PERFORMNUD,DAD>
	media: autoselect (100baseTX <full-duplex>)
	status: active
```

### Get the root password

Once your workstation has an IP, you can find the root password in the tablet's settings screens.

* Menu &#x2192; Settings &#x2192; Help

* Tap "Copyrights and licenses"

* On the right, below "GPLv3 Compliance", near the bottom, will be a notice saying the following:

    ```
    The General Public License version 3 and the Lesser General Public
    License version 3 also requires you as an end-user to be able to access
    your device to be able to modify the copyrighted software licensed
    under these licenses running on it.

    To do so, this device acts as an USB ethernet device, and you can connect
    using the SSH protocol using the username 'root' and the password
    'xxxxxxxx'.

    The IP addresses available to connect to are listed below:

    10.11.99.1
    ```

### SSH into the tablet

Once you have the password, you can SSH into the tablet.

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
> If you're curious, the message is coming from the tablet's `/etc/motd` file.

### Create `.ssh/authorized_keys`

**If you don't have an SSH key, and didn't create one above, you can skip this section.**

If you DO have an SSH key that you use on a regular basis, you can install the public key in the tablet and then use the secret key to SSH into the tablet without having to enter a password.

> You can use the same SSH key pair to access other machines by installing the same public key on *those* machines, using the same process shown below.
>
> For what it's worth, I use my personal SSH key pair to access about thirty different machines, and I use a different SSH key pair for work which lets me access several hundred machines. (I also store my SSH secret keys on YubiKeys rather than on the computers' disks, but that's a topic for a different web page that I haven't written yet.)

While I was figuring this out, I was pleasantly surprised to find that the tablet's SSH server supports `ed25519` SSH keys. (One of my normal SSH keys is an `ed25519` key.) I was also happy to find that `nano` (my preferred text editor) was also already installed. The `vi` and `vim` editors are also installed, if you're more comfortable using them.

* Create the `$HOME/.ssh` directory

    ```
    reMarkable: ~/ mkdir ~/.ssh
    reMarkable: ~/ cd ~/.ssh
    reMarkable: ~/.ssh/ nano authorized_keys
    ```

* Copy/paste the public key lines, starting with `ssh-rsa` or `ssh-ed25519`, one key on each line, with no blank lines or comments.

* Save changes.

* Make sure the file and directory permissions are correct.

    ```
    reMarkable: ~/.ssh/ chmod -R go= .
    reMarkable: ~/.ssh/ ls -laF
    drwx------    2 root     root          4096 Jun 27 20:26 ./
    drwx------    6 root     root          4096 Jun 27 20:21 ../
    -rw-------    1 root     root          1570 Jun 27 20:26 authorized_keys
    reMarkable: ~/.ssh/
    ```

Once this is done, you will be able to SSH into the tablet using any of the secret keys which correspond to the public keys you stored in the `$HOME/.ssh/authorized_keys` file.

## Customize the shell

**This section is optional.** At least, it's optional for you, it's required for me.

A "shell" is a program which shows the user a prompt, lets them type in a command, figures out what the user typed, and *does* whatever the user entered. This could involve running some code within the shell, but in most cases this involves starting a new process. Either way, when that process finishes, the shell goes back and shows the next prompt.

I've been using computers since 1981, and Linux since 1992. I've spent a LOT of time using shells over the years, especially on Linux machines, and have come to expect the shells I use to do certain things. This includes the shell on the reMarkable tablets.

I've been using (and updating) a "`.bashrc`" file on all of my machines, including macOS workstations, since ... some time around 2003 maybe? On every machine where I use a command line on a semi-regular basis, I make it a point to install my `.bashrc` file so the shell "feels right".

This includes the reMarkable tablet.

### Install my `.bashrc` file

Like many other Linux systems, the reMarkable tablet's default shell is [GNU `bash`](https://www.gnu.org/software/bash/). The shell's location is `/bin/sh`, but it turns out `/bin/sh` is a symbolic link (a "pointer", if you will) to a copy of `bash`.

This means I can copy the same `.bashrc` file I'm using on all of my other machines, and it will have all of the features I'm used to having.

In each user's home directory *may* be a file named `.bashrc`. When `bash` starts, it reads this file and runs the commands it contains, before showing the first prompt.

The reMarkable tablet already has a `.bashrc` file in place, and I don't want to lose it, so I'm going to rename it.

```
reMarkable: ~/ mv .bashrc .bashrc.dist
```

At this point there *is* no `.bashrc` file, so I'm going to copy the file from my laptop.

```
(jms1@laptop) 17 ~ $ scp .bashrc rm2:
```

Back on the tablet, we can `source` this file to run the commands it contains, within the current shell. This is the same thing the shell does when it first starts up (when the user logs in).

```
reMarkable: ~/ source .bashrc
(root@reMarkable) 37 ~ #
```

Next we log out of the tablet and log back in, to make sure the new `.bashrc` file "does its thing" when we log in.

```
reMarkable: ~/ exit
(jms1@laptop) 18 ~ $ ssh rm2
Warning: Permanently added '10.11.99.1' (ED25519) to the list of known hosts.
ｒｅＭａｒｋａｂｌｅ
╺━┓┏━╸┏━┓┏━┓   ┏━┓╻ ╻┏━╸┏━┓┏━┓
┏━┛┣╸ ┣┳┛┃ ┃   ┗━┓┃ ┃┃╺┓┣━┫┣┳┛
┗━╸┗━╸╹┗╸┗━┛   ┗━┛┗━┛┗━┛╹ ╹╹┗╸
(root@reMarkable) 1 ~ #
```

## Change the hostname

**This section is optional.** Unless you have two or more tablets and want the command prompt to be different on each one, so you can tell which one is which (as opposed to physically looking at what colour cover is on the tablet at the other end of the wire, which I *was* doing before I changed my tablets' hostnames.)

At the moment I own two reMarkable tablets. My prompt contains the machine's hostname (so does the default reMarkable prompt), so if I give the two tablets different hostnames, the prompt will serve as a reminder of which tablet I'm working with at the moment.

> You may or may not want to do this, or you may want to change the tablet's hostname to some other name. It's up to you.

On each tablet, I did the following ...

* Find the tablet's serial number. (This is what I'm using as the hostnames on the two tablets.)

    The serial numbers are stored in a special partition on the internal [MMC](https://en.wikipedia.org/wiki/MultiMediaCard) storage. (Thanks to [RCU](http://www.davisr.me/projects/rcu/) for figuring out how to get the serial number.)

    ```
    (root@reMarkable) 1 ~ # BDEV=$( mount | awk '/\/home/{print substr($1,1,index($1,"p")-1)}' )
    (root@reMarkable) 2 ~ # SERIAL=$( dd if=${BDEV}boot1 bs=1 skip=4 count=15 2>/dev/null )
    (root@reMarkable) 3 ~ # echo $SERIAL
    RM110-313-xxxxx
    ```

* Set the hostname.

    This command tells the running Linux kernel to use the new hostname.

    ```
    (root@reMarkable) 4 ~ # hostname $SERIAL
    (root@reMarkable) 5 ~ #
    ```

    This command stores the new hostname in the file that the system reads while booting up, to set the hostname.

    ```
    (root@reMarkable) 5 ~ # echo $SERIAL > /etc/hostname
    (root@reMarkable) 6 ~ #
    ```

* Start a new shell.

    As you can see, neither one of the commands above changed the prompt. This is because `bash` reads the hostname from the kernel once when it starts up, and keeps a copy in its own memory. This is faster than reading the hostname from the kernel every time it prints a prompt, and useful because systems' hostnames *rarely* change once the machine is running.

    To make `bash` use the new hostname in the prompt, you need to start a new `bash` shell process. There are a few ways to do this.

    * Log out and log back in. (This is what I actually did while changing the hostname and writing this page.)

        ```
        (root@reMarkable) 6 ~ $ exit
        (jms1@laptop) 19 ~ $ ssh rm2
        Warning: Permanently added '10.11.99.1' (ED25519) to the list of known hosts.
        ｒｅＭａｒｋａｂｌｅ
        ╺━┓┏━╸┏━┓┏━┓   ┏━┓╻ ╻┏━╸┏━┓┏━┓
        ┏━┛┣╸ ┣┳┛┃ ┃   ┗━┓┃ ┃┃╺┓┣━┫┣┳┛
        ┗━╸┗━╸╹┗╸┗━┛   ┗━┛┗━┛┗━┛╹ ╹╹┗╸
        (root@RM110-313-xxxxx) 1 ~ $
        ```

    * Restart the current shell. (I've done this in the past on other systems, this example shows what the process *would* look like.)

        ```
        (root@reMarkable) 6 ~ $ exec $SHELL
        (root@RM110-313-xxxxx) 1 ~ $
        ```

        As you can see, the "command number" started over from 1 because it's a brand new `bash` process.

After doing this on both tablets, the other tablet looks like this when I log into it:

```
(jms1@laptop) 22 ~ $ ssh rm2
Warning: Permanently added '10.11.99.1' (ED25519) to the list of known hosts.
ｒｅＭａｒｋａｂｌｅ
╺━┓┏━╸┏━┓┏━┓   ┏━┓╻ ╻┏━╸┏━┓┏━┓
┏━┛┣╸ ┣┳┛┃ ┃   ┗━┓┃ ┃┃╺┓┣━┫┣┳┛
┗━╸┗━╸╹┗╸┗━┛   ┗━┛┗━┛┗━┛╹ ╹╹┗╸
(root@RM110-147-xxxxx) 1 ~ #
```

As you can see, the prompt contains the other tablet's serial number.
