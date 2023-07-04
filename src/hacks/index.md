# Hacks

The reMarkable tablets are running Linux, and they provide an easy way to SSH into the tablet as root, so unlike many other devices, there's no need to "root" or otherwise "break into" the tablet.

Because of this, there's a whole community of people who have come up with ways to modify how the unit works.

I already *know* that I'll be SSH'ing into mine and customizing things, and I've started collecting bookmarks for some of these "hacks". As I look at each one in more detail, I'll update this page or, if it makes sense, add separate pages for some of them.

## List of Hacks

[awesome-reMarkable](https://github.com/reHackable/awesome-reMarkable) is a list of hacks compiled by others. Almost all of the hacks I've seen are linked *from* this page.

> &#x2139;&#xFE0F; To be totally clear, I am NOT trying to start my own "index of hacks" here. When I'm finished (or *if* I'm finished?) this site will contain information about the hacks I actually use on my own tablet, and *maybe* the ones that I look at but decide not to use.
>
> Please do not look at this page as "the ultimate list of reMarkable hacks".

## Hacks - On My Tablet

So far the only "hack-ish" things I've done with my tablet are ...

* Enabling SSH access.

    The ability to SSH into the tablet is built into the reMarkable software, so I don't really think of this as a "hack". It's just something that reMarkable, unlike most other consumer electronics companies, decided *not* to prevent users from doing.

    &#x21D2; The [SSH Access](../info/ssh.md) page documents this.

    > For the record, this was also a big part of what convinced me to spend the money. If SSH access was not easily available, I wouldn't have bought the tablet.

* Wrote a backup script.

    &#x21D2; The [Backing Up the Tablet](../info/backups.md) page documents this.

* Created some templates.

    I read through [How to Make Template Files for Your reMarkable](https://www.simplykyra.com/how-to-make-template-files-for-your-remarkable/), which includes a LOT of information, including what I needed - details about the file formats, where to upload them, and how to make the reMarkable software use them.

    &#x21D2; The [Templates](../info/templates.md) page documents this.

## Hacks - Not Tried Yet

This is a list of "hacks" that look interesting to me. I plan to look at them in more detail in the future.

In no particular order ...

* [RCU](http://www.davisr.me/projects/rcu/) reMarkable Connection Utility - looks like a GUI for managing the RM1/RM2 tablets. It also seems to be a good option for managing tablets which are not connected to "the cloud".

    It's not free, but ... it's only $12, which isn't bad.

* [Toltec](https://toltec-dev.org/) looks like a third party software repository for the reMarkable tablets, similar to [Homebrew](https://brew.sh/) for macOS. Some of the "hacks" I've looked at so far say they require packages installed from it.

    * [Github repo](https://github.com/toltec-dev/toltec)

* [reMarkable Printer](https://github.com/Evidlo/remarkable_printer) - makes the tablet emulate a printer. When a computer "prints" to it, the output is saved as a new document (PDF?) on the tablet. (The same thing can be done using the "Print to PDF" functionality built into macOS, then uploading the PDF to the tablet.)

* [reStream](https://github.com/rien/reStream) - Stream your reMarkable screen over SSH. Can be used with a screen-capture utility to record movies of what's on the tablet's screen.

* [goMarkableStream](https://github.com/owulveryck/goMarkableStream) is another way to stream the reMarkable screen's contents to a web browser.

* [regitable](https://github.com/after-eight/regitable) - Make the tablet automatically commit and upload backups to a git repo. Uses [git-lfs](https://github.com/git-lfs/git-lfs) to store large files outside the repo itself, so the files in the `.git` directory don't contain duplicate copies of larger files.

    The reMarkable 2 only has 8 GB of storage, part of which is used by the OS, so ... *that's* going to be interesting as well.

* [recept](https://github.com/funkey/recept/) - Uses an `LD_PRELOAD` hack to intercept the communications with the screen digitizer (which reads the pen) and "averages" the sample positions to "smooth out" the lines. (Not super easy to explain, but the page has an example which shows the difference.)

* [rM-signature-patch](https://github.com/Barabazs/rM-signature-patch) - *modifies the `xochitl` executable* (the reMarkable software itself) to remove the advertisement that it adds to the bottom of every email it sends out.

    This one is also a simple script, and in fact I've opened a [pull request](https://github.com/Barabazs/rM-signature-patch/pull/2) against it, to only require `opkg` (the [Toltec](https://github.com/toltec-dev/toltec) package installer) if `perl` needs to be installed. (I'm sure Toltec isn't the only way to install Perl on the tablet.)

## Hacks I Am Not Using

Nothing against them, they're just not for me. I'm listing them here because I did look at them, and they could be suitable for you. (For the record, if I look at any hacks and decide that I *don't* like them for some reason, they will not be listed here at all.)

* [rm-sync](https://github.com/simonschllng/rm-sync) - Shell script which uses `curl` to upload files to the tablet, and `scp` to download/backup files from the tablet. It looks simple enough, but I already have an [`rsync`-based backup solution](../info/backups.md) that I've been using for 15+ years, so I stuck with what I know.

    With that said, the idea of using `curl` to upload EPUB/PDF files is in the back of my brain, and when I get ready to write a script for that, I'll probably come back to this one and use the same `curl` command line he's using to do it.

* [Calibre Remarkable Device Driver Plugin](https://github.com/naclander/Calibre-Remarkable-Device-Driver-Plugin) - a plugin for [Calibre](https://calibre-ebook.com/) which allows it to manage ebook files on the tablet, the same way it manages other ebook readers (i.e. kobo, kindle, nook, etc.)

    &#x274C; This apparently doesn't work with the reMarkable 3.x software.
