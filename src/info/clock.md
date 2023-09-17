# The Tablet's Clock

The Linux kernel in the reMarkable tablet keeps track of the current time. It does this the same way any other Linux machine does it - by counting milliseconds in the background while it's running.

Most machines, *including the reMarkable tablet*, have a real-time clock, or "RTC". built into them. When the Linux kernel starts (i.e. when the machine boots), it reads the RTC to initialize the kernel clock. After that, the kernel clock's accuracy depends on the accuracy of the "interrupt" signal generated 1000 times every second which makes it increment the counter. I mention this because on some systems, the timing and handling of these "interrupts" can be affected by things like the temperature, or by how busy the system is. Over time, this can make the kernel clock "drift", and become faster or slower than real-world time.

Most systems run a program which talks to "time servers" (aka "NTP servers", since the NTP protocol is the "language" they're speaking) on the internet, and keeps the kernel clock accurate with the time in the real world. On the reMarkable tablets, this program only runs while the tablet is connected to wifi. For tablets which *never* connect to wifi, this service never runs at all, so the only "accurate" source of time is the hardware clock, and that only stays accurate while its battery is working. (Some systems have a separate battery for the hardware clock, I'm not sure how the reMarkable tablets handle this.)

### Why is the clock's accuracy important?

There are several reasons, however the most important ones have to do with the SSL process that happens when connecting to an `https://` web site. The reMarkable software makes a lot of connections to `https://` servers when talking to the reMarkable cloud, and if the clock is not accurate, the tablet won't be able to connect.

Also for me persontally, I interact with the files on the tablet enough that it bothers me if the timestamps on the files aren't correct.

## The `timedatectl` command

The reMarkable tablet has a program called `timedatectl` to *manage* most things involving the system clock, time zone, and synchronization. (The same program exists on some other Linux machines as well.)

> &#x2139;&#xFE0F; **The examples below assume that you are SSH'd into the tablet.** See the [SSH page](ssh.md) for more details.

### Check clock status

The `timedatectl status` command shows the status of the system clock.

```
root@reMarkable:~# timedatectl status
               Local time: Sat 2023-09-16 20:08:19 UTC
           Universal time: Sat 2023-09-16 20:08:19 UTC
                 RTC time: Sat 2023-09-16 20:08:19
                Time zone: Universal (UTC, +0000)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no
```

This shows you the following:

* `Local time` = the Linux kernel time, in your local timezone.

* `Universal time` = the Linux kernel time, in UTC. The Linux kernel's clock always stores UTC time. Programs which need the local time will add or subtract the appropriate number of seconds, depending on the time zone.

* `RTC time` = the time reported by the RTC.

* `Time zone` = the tablet's time zone. As you can see, mine is set to UTC, which is why the "Local time" and "Universal time" values are the same.

* `System clock synchronized` = whether the Linux kernel thinks the clock has been synchronized since booting up.

* `NTP service` = the state of the NTP service, which on this system is the `systemd-timesyncd` service. (On most of my other systems, this is the `ntpd` service.)

* `RTP in local TZ` = whether the RTC stores "Local time" or "Universal time".

### Set time zone

The reMarkable software doesn't show the time anywhere, so unless you use SSH to interact with the tablet on a regular basis, there may not be any reason to set the tablet's timezone.

However if you want/need to change the timezone

#### Find the right Time Zone code

Use `timedatectl list-timezones` to show a list of all time zone names that the tablet's OS knows about.

```
root@reMarkable:~# timedatectl list-timezones
```

This shows the list using the scaled-down version of `less` which is part of `busybox`. It supports scrolling up and down, but does not support searching within the text.

* &#x2191; moves up one line
* &#x2193; (or ENTER) moves down one line
* SPACE moves down one page
* `B` moves up a page
* `Q` exits the program

The time zones are generally named after a continent and a major city in each time zone. For example, "US Eastern" is called `America/New_York`.

Also note that `UTC` does not have any kind of "daylight saving" time, unlike `Europe/London` which does.

#### Set the time zone

Use `timedatectl set-timezone` to set the correct time zone.

```
root@reMarkable:~# timedatectl set-timezone America/New_York
root@reMarkable:~# timedatectl status
               Local time: Sat 2023-09-16 17:52:11 EDT
           Universal time: Sat 2023-09-16 21:52:11 UTC
                 RTC time: Sat 2023-09-16 21:52:12
                Time zone: America/New_York (EDT, -0400)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no
```

Use `timedatectl set-timezone UTC` to set the tablet back to UTC. Note that OS upgrades will also reset the tablet back to UTC.

### Enable or disable NTP

The `timedatectl set-ntp` command will enable or disable NTP synchronization.

* To enable NTP:

    ```
    root@reMarkable:~# timedatectl set-ntp on
    ```

* To disable NTP:

    ```
    root@reMarkable:~# timedatectl set-ntp off
    ```

## The `systemd-timesyncd` program

This program runs *while the tablet is connected to wifi*. It talks to one or more NTP servers and updates the Linux kernel clock as needed, to keep it accurate.

By default, the tablet synchronizes its clock against four NTP servers owned by google. Many Linux systems which use DHCPv4 to set an interface's IPv4 address, also have the ability to get a list of NTP servers from the DHCP server. I tried to set up my "test tablet" this way, but the scripts which are supposed to configure `systemd-timesyncd` with the NTP servers received from the DHCP server are not there ... so even if the DHCP server sends a list of NTP servers (as they do on my home network), the DHCP client on the tablet doesn't do anything with it.

Since my own tablets are only allowed to connect to my home network (my firewall has rules to prevent them from connecting to anything outside that network), I configured my tablets with the IPv4 address of my home network's NTP server, and that seems to work.

### Check clock synchronization

The `timedatectl timesync-status` command shows the status of clock *synchronization*.

```
root@reMarkable:~# timedatectl timesync-status
       Server: 192.168.4.1 (192.168.4.1)
Poll interval: 34min 8s (min: 32s; max 34min 8s)
         Leap: normal
      Version: 4
      Stratum: 2
    Reference: 81060F1E
    Precision: 2us (-19)
Root distance: 47.667ms (max: 5s)
       Offset: -1.666ms
        Delay: 5.008ms
       Jitter: 1.134ms
 Packet count: 3
    Frequency: -6.507ppm
```

The important values are ...

* `Server` = the NTP server that the tablet synchronized with

* `Poll interval` = how often the NTP service talks to the NTP server and adjusts the local clock.

* `Stratum` = a rough estimate of "how accurate" the NTP server is. As a quick explanation ...

    * A "Strata 1" NTP server will have an atomic clock attached to it, or have some other super-accurate clock.

    * A "Strata 2" NTP server synchronizes against one or more Strata 1 servers. (In my case, the NTP server *is* my home router, and it's configured to synchronize against three different Strata 1 servers.)

    * A "Strata 3" NTP server synchronizes against one or more Strata 2 servers.

    * ... and so forth.

    Note that NTP servers stay running 24/7, continuously monitor the stability and latency of the links to the NTP servers it synchronizes against, and uses a ridiculously complex algorithm to figure out how accurate it is and which of its peers (the "upstream" NTP servers that it synchronizes with) are the most accurate. The reMarkable tablet doesn't do this, it just does a one-time sync with *one* of its NTP servers every half hour, which is usually good enough to be accurate to within a few milliseconds.

* `Precision` = how accurate it thinks the system time is. In this case, it thinks the clock is accurate to within two microseconds of "real time".

### Manually set the NTP server(s)

Edit the `/etc/systemd/timesyncd.conf` file.

> The `vi`, `vim`, and `nano` text editors are installed on the tablet.

Find the line starting with "`NTP=`", un-comment it (i.e. remove the "`#`" from the beginning), and put the NTP server's IPv4 address on the line.

* Before:

    ```
    [Time]
    #NTP=
    ```

* After:

    ```
    [Time]
    NTP=192.168.4.1
    ```
Note that you *can* also use a hostname, however that makes `systemd-timesyncd` have to do a DNS query to find the IP address every time it syncs. Unless you're using a "pool" address that will change on a regular basis, you should use the IP address here.

After changing the NTP servers, you need to restart the `systemd-timesyncd` service.

```
root@reMarkable:~# systemctl restart systemd-timesyncd
```

## Manually set the system time

If your tablet never connects to wifi, or connects to a network which doesn't have (or allow) access to the outside internet, and doesn't have its own NTP server, it won't be *able* to synchronize its clock. In this case you should disable NTP and set the clock by hand.

This is how I configured my primary reMarkable tablet (which doesn't connect to any wifi networks, or to the reMarkable cloud).

```
root@reMarkable:~# timedatectl set-ntp off
root@reMarkable:~# timedatectl set-time '2023-09-16 21:35:20'
root@reMarkable:~# timedatectl status
               Local time: Sat 2023-09-16 21:35:22 UTC
           Universal time: Sat 2023-09-16 21:35:22 UTC
                 RTC time: Sat 2023-09-16 21:35:22
                Time zone: Universal (UTC, +0000)
System clock synchronized: no
              NTP service: inactive
          RTC in local TZ: no
```

Notes:

* The `timedatectl set-time` command sets both the system clock *and* the RTC.

* The `timedatectl set-time` command won't work if NTP is enabled.

    ```
    root@reMarkable:~# timedatectl set-time '2023-09-16 21:41:30'
    Failed to set time: Automatic time synchronization is enabled
    ```
