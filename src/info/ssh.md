# SSH Access

The reMarkable tablets are designed to allow users to *easily* access the internal software. In addition to charging the battery, the USB-C port acts like an ethernet interface when you connect it to a computer. It also runs a DHCP server, which assigns an IP address to the computer and allows the computer to access the tablet.

The tablet allows incoming SSH connections from the computer, as the `root` user. When the tablet starts for the first time, it makes up a random password for this user. You will be able to find the password in the settings screen.

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
> If you're curious, the message is comfing from the tablet's `/etc/motd` file.

### Create `.ssh/authorized_keys`

If you have an SSH key that you use on a regular basis, you can install the public key in the tablet and then use the secret key to SSH into the tablet without having to enter a password.

While I was figuring this out, I was pleasantly surprised to find that the SSH server supports `ed25519` SSH keys. (One of my normal SSH keys is an `ed25519` key.) I was also happy to find that `nano` (my preferred text editor) was also already installed. The `vi` and `vim` editors are also installed, if you're more comfortable using them.

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
