# Controlling the Network

I was under the impression that, as soon as you allow a reMarkable tablet to access any network, it would immediately start trying to talk to "the mother ship", and would upgrade itself to the latest firmware update without asking.

Because of this, I haven't connected my tablet to *any* network since I took it out of the box.

However, according to [this comment](https://github.com/owulveryck/goMarkableStream/issues/52#issuecomment-1636887834) ...

* Connecting the tablet to a network *does not* automatically send any information anywhere.

* The first time you connect the tablet to a network, the Settings interface starts showing an option which allows you to *select* whether you want the operating system to update itself or not.

    I don't understand why the tablet *hides* this setting until it connects to a network for the first time. I wouldn't be so uneasy about letting the tablet connect to the internet if I were able to control (or at least *see*) what it's going to do with that connection, *before* it connects to any network.

### Telemetry

The tablet's filesystem has a `/home/root/.cache/remarkable/xochitl/telemetry/` directory, containing an ever-growing collection of files containing what appears to be a collections of strings containing `1` and `0`.

When I've seen "telemetry" files in the past, it was because the device was uploading information somewhere, usually to the hardware or OS manufacturer, about what the machine was doing. As a rule I'm not comfortable with uploads happening without my knowledge or consent, especially when I can't tell what information is being sent.

- asked on `rcu-develop` list about this
- ask author of "fake sync" server thing?

## Controlling Network Traffic

### Ideas

MITM proxy

- find/edit SSL root

Real network, limit access

- get tablet's MAC address
- set up DHCP reservation
- firewall rules to limit traffic to/from tablet's IP
    - most firewalls aren't configurable enough for this
    - allow NTP
    - watch DNS requests
    - list domains/hostnames that the tablet tries to connect to, allow/deny as needed
