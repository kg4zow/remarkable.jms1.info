# Scripts

I have written a few scripts to work with the reMarkable tablet, and after the "new tablet smell" wears off, chances are I'll be working on others in the future. This section of the book is where I'll share them with the world.

> **microsoft windows**
>
> I don't use windows anymore. The only windows machine I own is an old laptop infected with windows 7, that I keep around for programming an older ham radio. Since then, [CHIRP](https://chirp.danplanet.com/projects/chirp/wiki/Home) has added support for those older radios and I can program them from a Mac, so I probably don't even need it anymore.
>
> The fact that I haven't physically *touched* that laptop in almost two years is another good sign that I don't need it anymore.
>
> I've heard that there are ways to run Linux-ish things on windows these days, but other than running Linux in a VM (using something like [VirtualBox](https://www.virtualbox.org/)) and making sure the USB device for the tablet is passed through to the guess, I can't really tell you how to do it.

### Github

Since I started this site, I started a Github repo for these scripts. This ended up being a lot easier for me to manage.

Going forward, all of my reMarkable scripts are being tracked and published there. When I have time, the scripts listed on *this* site will also be moved there.

&#x21D2; [kg4zow/rm2-scripts](https://github.com/kg4zow/rm2-scripts/)


## SSH Access

**Some of these scripts will need access to SSH into the tablet.** In addition, the scripts will run more smoothly if you set up an SSH key.

[The SSH Access page](../info/ssh.md) contains information about how to set this up.

## Perl

I write many of my scripts in Perl, mostly because it's what I'm most familiar (and comfortable) with. For the most part, they are designed to run on a macOS or Linux computer, while the reMarkable tablet is connected via USB.

Because of this, you'll need Perl installed on the computer.

Luckily, Perl comes pre-installed on macOS and *some* Linux systems, and can be installed fairly easily on most others.

```
$ perl --version

This is perl 5, version 30, subversion 3 (v5.30.3) built for darwin-thread-multi-2level
(with 2 registered patches, see perl -V for more detail)
...
```

If it's not there, use your system's package manager to install it. This will generally involve a command line "`yum install`" or "`apt install`", depending on which Linux distribution you're using.

### Perl JSON module

The reMarkable software uses a lot of JSON files, and some of the scripts need to read them. This means you will also need the Perl JSON module.

Again, it may already be installed. To check, run this command: (The last character is "digit ONE", not "lowercase L".)

```
$ perl -MJSON -e1
```

If it shows the next command prompt without printing anything, the module is installed.

If it shows a message like this ...

```
$ perl -MJSON -e1
Can't locate JSON.pm in @INC (you may need to install the JSON module) ...
```

... then you need to install the module.

If your system's package manager *has* a package for it, you should install it that way, so it can also keep the package up to date with the rest of your system's packages.

* Debian: `apt install libjson-perl`
* CentOS: `yum install perl-JSON`

If not, you can install it using [CPAN](https://cpan.org/).

```
$ cpan install JSON
```

## Golang

I'm trying to teach myself the Go language (aka "Golang") in my spare time.

Golang allows you to compile a program to run on a different platform than where you're compiling it. For example, I can write and compile a program on macOS and produce executables for a wide assortment of operating systems and CPU types (including windows, if you're into that sort of thing), all without having to figure out a bunch of "cross compilers" and different versions of libraries. And the people who *use* these programs, don't have to deal with installing a bunch of libraries (like the Perl JSON library) in order to use the program.

Specifically, I have found that a simple "hello world" program written in Go, compiled with the following settings, can be uploaded and executed as-is on the reMarkable 2 tablet.

* `GOOS=linux GOARCH=arm GOARM=7 go build ...`

> The reMarkable tablets are running a 32-bit kernel.
>
> Be sure to use `GOARCH=arm` rather than `GOARCH=arm64`.

I mention this because when I get some time, I plan to re-write these Perl scripts in Golang, so people don't have to deal with installing Perl or CPAN modules. Instead, they'll be able to download and use a single binary.

Note that when/if I do this, the Perl versions of the scripts won't be going away. Both versions will continue to be available, possibly from the pages on this site, but definitely from Github - although the different Golang programs will be in their own repos, so I can use Github's "releases" functionality to let users download compiled executables for their own systems.

The [`rmweb`](https://github.com/kg4zow/rmweb) program is an example of this. It's a command line utility which uses the tablet's web interface to list the documents on a tablet, and download them as PDF files. Executables are available for macOS (Intel and ARM), Linux (x86 and x86_64), and ms-windows (Intel 32- and 64-bit).
