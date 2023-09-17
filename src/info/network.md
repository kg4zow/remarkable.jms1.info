# Controlling the Network

I was under the impression that, as soon as you allow a reMarkable tablet to access any network, it would immediately start trying to talk to "the mother ship", and would upgrade itself to the latest firmware update without asking.

However, according to [this comment](https://github.com/owulveryck/goMarkableStream/issues/52#issuecomment-1636887834) ...

* Connecting the tablet to a network *does not* automatically send any information anywhere.

* The first time you connect the tablet to a network, the Settings interface starts showing an option which allows you to *select* whether you want the operating system to update itself or not.

    I don't understand why the tablet *hides* this setting until it connects to a network for the first time. I wouldn't be so uneasy about letting the tablet connect to the internet if I were able to control (or at least *see*) what it's going to do with that connection, *before* it connects to any network.

Because of this, I haven't connected my tablet to *any* network since I took it out of the box.

**Update:** I bought a used reMarkable tablet to use for experimentation, and am using this to figure out how the tablets use the network, without any risk of my personal documents being shared without my knowledge. (This other tablet only has dummy documents on it, so if something does leak it's not a huge deal.)

## Controlling Network Traffic

I picked up a used reMarkable tablet to use for experimentation. I used this to figure out how to configure my home network's router to allow it to connect to the wifi, but not allow its traffic to reach the outside world.

In order to do this, I configured my home router with ...

* A DHCPv4 reservation, meaning when the tablet connects to wifi it will always be assigned a specific IPv4 address

* Firewall rules which block the tablet from being able to talk to any IPv4 addresses outside the local network, and any IPv6 addresses other than link-local `fe80::/8` addresses.

> &#x2139;&#xFE0F; **My home network uses [MikroTik](https://mikrotik.com/) hardware**, both the primary router and the wifi access points. I'm not sure how much of what I describe below is even be *possible* with most typical consumer-level router (or "ritters", as a friend calls them).
>
> I'm willing to answer *general* questions about this (and I reserve the right to add the questions and their answers to this site, if I think it would be helpful), but please don't ask me for specific help with *your* router.

### Get the tablet's MAC address

A MAC (Media Access Control) address is the *physical* address of a network interface, such as the tablet's wifi interface. Every ethernet, wifi, or other kind of network interface is assigned a MAC address during manufacturing. At a low level, these MAC addresses are what devices on the same network segment (such as a home network) use to send packets to each other.

```
root@reMarkable:~# ip link show dev wlan0
3: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether c0:ff:ee:c0:ff:ee brd ff:ff:ff:ff:ff:ff
```

In this example, `c0:ff:ee:c0:ff:ee` is the MAC address. (Obviously I changed it for this web page.)

### Create a DHCP reservation

On my router, I did this:

```
/ip dhcp-server lease add \
    mac-address=c0:ff:ee:c0:ff:ee \
    address=192.168.4.251 \
    comment="reMarkable tablet RM110-xxx-xxxxx (bought used)"
```

After doing this, every time this tablet connects to my home wifi, it gets assigned the `192.168.4.251` IP address. This allowed me to create a DNS entry for it, and now I can SSH into it via the wifi interface, without having to plug in the USB cable.

### Restrict IPv4 traffic

I already had a list of IPv4 addresses which aren't allowed to talk to the outside world (i.e. printers, "smart switches", and other IoT devices), so I added the tablet to that list. These devices are allowed to talk to other devices on the local network, but are not allowed to talk to anythings *outside* the local network.

```
/ip firewall address-list add \
    list=restricted \
    address=192.168.4.251
```

I'm also showing the already-existing rule which prevents traffic *from* those IPs, from leaving the router through the `uplink` interface. (This is what I renamed the interface connected to the fiber equipment, and is the only interface connected to a non-local network segment).

```
/ip firewall filter add \
    chain=forward \
    src-address-list=restricted \
    out-interface=uplink \
    action=reject
```

### Restrict IPv6 traffic

> &#x2139;&#xFE0F; I am exploring a different way to handle IPv6 traffic. If things work as I expect, the tablet will be able to speak IPv6 with other devices in my home network but not be able to talk to anything outside, just as I'm doing with IPv4. If I get this working I will update this page.

I also have real IPv6 working in the house (thanks to a tunnel from [`tunnelbroker.net`](https://tunnelbroker.net/), who also routed an entire `/48` block to me over the tunnel, for free). Turns out the reMarkable tablets also speak IPv6, and will assign themselves an IPv6 address in any network for which they receive an IPv6 RA (router advertisement) message.

Even if a device (like a reMarkable tablet) isn't able to reach the internet via IPv4, it may still be able to reach it via IPv6, so we also need to block IPv6 traffic coming from the tablet. And because IPv6 devices generally self-assign their IPs, the firewall rule needs to match based on the MAC address instead of the IPv6 address. (This is one of those things that most ritters cannot do.)

```
/ipv6 firewall filter add \
    chain=forward \
    src-mac-address=c0:ff:ee:c0:ff:ee \
    action=drop \
    comment="FORWARD: No IPv6 for reMarkable tablet"
```

### Traffic is controlled

After adding these rules in the router, the tablet can connect to wifi and speak with other devices on the local network, but cannot reach the outside world.

This has allowed me to experiment with [clock synchronization](clock.md), I have a Linux server at home which is able to pull backups from the tablet every hour (not that there's a lot to save, but as a concept it works), and it also makes it possible for me to set up [rmfakecloud](https://ddvk.github.io/rmfakecloud/) in the future.


## Telemetry

The tablet's filesystem has a `/home/root/.cache/remarkable/xochitl/telemetry/` directory, containing an ever-growing collection of files containing what appears to be a collections of strings containing just `1` and `0`.

When I've seen "telemetry" files in the past, it was because the device was uploading information somewhere, usually to the hardware or OS manufacturer, about what the machine was doing. As a rule I'm not comfortable with uploads happening without my knowledge or consent, especially when I can't tell what information is being sent.

I asked about these files on the `rcu-develop` list (for [RCU](http://www.davisr.me/projects/rcu/) users who are more "technically minded"). A few people were *aware* of them, but nobody had any real information about what they were being used for or what information they contain.

I did notice that, after connecting to wifi for the first time, the tablet *did* try to open a connection to `34.36.20.125`, which is used by "a Google Cloud customer" - probably reMarkable but without knowing the hostname which *resolved to* this IP, I can't really be sure. Also, I don't *know* if this is related to these telemetry files or not.

I've tried setting up a packet sniffer on the router to capture all traffic to/from the tablet, but this particular connection hasn't happened again. I'm hoping that if it does, there will be a DNS request just before it tries to connect and the hostname it's querying for will tell me something.


# Ideas

MITM proxy

- find/edit SSL root

Real network, limit access

- watch DNS requests
- list domains/hostnames that the tablet tries to resolve
- list attempted connections, see if any can/should be allowed
