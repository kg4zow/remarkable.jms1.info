# Hacks

The reMarkable tablets are running Linux, and make it easy to SSH into the unit, as root, so there's no need to "hack into" the unit.

Because of this, there's a whole community of people who have come up with ways to modify how the unit works.

I already *know* that I'll be SSH'ing into mine and customizing things, and I've started collecting bookmarks for some of these "hacks".

## List of Hacks

[awesome-reMarkable](https://github.com/reHackable/awesome-reMarkable) is a list of hacks compiled by others. Almost all of the hacks I've seen are linked *from* this page.

> &#x2139;&#xFE0F; To be totally clear, I am NOT trying to start my own "index of hacks" here. When I'm finished (or *if* I'm finished?) this site will contain information about the hacks I actually use on my own tablet, and *maybe* the ones that I look at but decide not to use.

## Hacks

### Using on my tablet

I *think* I'm going to end up writing separate pages about each of the hacks I end up using. I can see some of them needing more detailed write-ups than would comfortably fit into a list.

### Not tried yet

As I write this (2023-06-25), I don't actually have the tablet yet, so I haven't had a chance to try any of these. I'm just writing down the ones that look like I'll probably be using them.

* [Toltec](https://github.com/toltec-dev/toltec) seems to be a software repository for the reMarkable tablets. A lot of the "hacks" I've looked at so far seem to refer to it.

    * [Toltec web site](https://toltec-dev.org/)

* [RCU](http://www.davisr.me/projects/rcu/) reMarkable Connection Utility - looks like a GUI for managing the RM1/RM2 tablets.

* [Calibre Remarkable Device Driver Plugin](https://github.com/naclander/Calibre-Remarkable-Device-Driver-Plugin) - a plugin for [Calibre](https://calibre-ebook.com/) which allows it to manage ebook files on the tablet, the same way it manages other ebook readers (i.e. kobo, kindle, nook, etc.)

* [reMarkable Printer](https://github.com/Evidlo/remarkable_printer) - makes the table emulate a printer. When a computer "prints" to it, the output is saved as a new document (PDF?) on the tablet.

* [reStream](https://github.com/rien/reStream) - Stream your reMarkable screen over SSH. Can be used with a screen-capture utility to record movies of what's on the tablet's screen.

* [regitable](https://github.com/after-eight/regitable) - Make the tablet automatically commit and upload backups to a git repo. Uses [git-lfs](https://github.com/git-lfs/git-lfs) to store large files outside the repo itself, so the files in the `.git` directory don't contain duplicate copies of larger files.

    The reMarkable 2 only has 8 GB of storage, part of which is used by the OS, so ... *that's* going to be interesting as well.

* [rm-sync](https://github.com/simonschllng/rm-sync) - Shell script which uses `curl` to upload files to the tablet, and `scp` to download/backup files from the tablet.

* [recept](https://github.com/funkey/recept/) - Uses an `LD_PRELOAD` hack to intercept the communications with the screen digitizer (which reads the pen) and "averages" the sample positions to "smooth out" the lines. (Not super easy to explain, but the page has an example which shows the difference.)

* [rM-signature-patch](https://github.com/Barabazs/rM-signature-patch) - *modifies the `xochitl` executable* (the reMarkable software itself) to remove the advertisement that it adds to the bottom of every email it sends out.

    This one is also a simple script, and in fact I've opened a [pull request](https://github.com/Barabazs/rM-signature-patch/pull/2) against it, to only require `opkg` (the [Toltec](https://github.com/toltec-dev/toltec) package installer) if `perl` needs to be installed. (I'm sure Toltec isn't the only way to install Perl on the tablet.)
