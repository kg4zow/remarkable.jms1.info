# `rmssh` Golang program

One of the problems I can see people running into when using my scripts is that, for some of them, they might need to install a bunch of third-party dependencies, or in some cases (i.e. Perl) the language itself.

Also ... ms-windows.

Outside of various "day jobs" (where a company pays me a regular salary to do stuff for them) I haven't used ms-windows since around the time "windows xp" came out (aaaaargh, *soooo* much unnecessary eye-candy, just *thinking* about it makes me feel like I need to wash my eyeballs out with bleach).

If you can't tell, I am *not* a fan of ms-windows, however I understand that some people are forced to use it, and others might actually *like* it. I look at it this way ... what *you* do with *your* computer is on *you*. It doesn't affect me, so ... you do you.

### Golang

One of the things I'm trying to learn is [Golang](https://go.dev/), aka the "Go" language. It *looked* interesting when I first found out about it, and at one point it looked like I was going to need it for something at `$DAYJOB`. That ended up not happening, but I *did* write one [simple program](https://github.com/kg4zow/volca-convert) using it - probably not the cleanest Golang code, but it does seem to work.

One of the big advantages of [Golang](https://go.dev/) is that, at least for command line programs, **you can compile the same source code to run on any of several dozen different platforms**, including both 32- and 64-bit versions of ms-windows.

I did some playing around with a way to build the same Golang program for a list of different architectures. [This repo](https://github.com/kg4zow/hello-golang) talks about how to do it, and includes a `Makefile` that

## Idea

The idea I have is to write a single command line program which can be used instead of the existing `rm2-xxx` scripts. I'm not sure if I want to include the template scripts, but I think it makes sense for the others (`rm2-list`, `rm2-backup`, `rm2-clean`, etc.) to be included.

Because the program will use SSH, and will work with both rM1 and rM2 tablets, my current thinking is to call it `rmssh`.

Each `rm2-xxx` script would become a sub-command, so `rm2-list` would become "`rmssh list`".

Obviously the resulting `rmssh` (or `rmssh.exe`) executables would be available for the architecture that people commonly use, and *could* be available for every architecture that Golang supports. The source code would be available under an open-source license.

## Status

As of 2024-07-13: just *barely* started.

When I first got [`rmweb`](https://github.com/kg4zow/rmweb) working, I copied the "skeleton" to another golang program called "rmssh", which doesn't curently do anything other than show its own version number.

The idea behind "rmssh" is exactly what I described above - a single command line program which can list, download, and upload files from/to rM1 and rM2 tablets. The only thing it won't be able to do *via SSH* is download PDF files, so that may end up only being available when the tablet's web interface is enabled and accessible (which usually means "when the tablet is connected via USB cable", although I've read that there are ways to make the web interface also accessible via wifi).

### Building PDF files

A "stretch goal" might be to figure out how to *build* a PDF file from scratch, using the raw files downloaded from the tablet. If so, I can see that being part of "rmssh" (and the web interface wouldn't be needed at all), but also available as a separate command line utility which "converts" from `.rmn` or `.rmdoc` files to PDF.
