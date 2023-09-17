# Single `rm2` Golang program

One of the problems I can see people running into when using my scripts is that, for some of them, they might need to install a bunch of third-party dependencies, or in some cases (i.e. Perl) the language itself.

Also ... ms-windows.

Outside of various "day jobs" (where a company pays me a regular salary to do stuff for them) I haven't used ms-windows since around the time "windows xp" came out (aaaaargh, *soooo* much unnecessary eye-candy, just *thinking* about it makes me feel like I need to wash my eyeballs out with bleach).

If you can't tell, I am *not* a fan of ms-windows, however I understand that some people are forced to use it, and others might actually *like* it. I look at it this way ... what *you* do with *your* computer is on *you*. It doesn't affect me, so ... you do you.

### Golang

One of the things I'm trying to learn is [Golang](https://go.dev/), aka the "Go" language. It *looked* interesting when I first found out about it, and at one point it looked like I was going to need it for something at `$DAYJOB`. That ended up not happening, but I *did* write one [simple program](https://github.com/kg4zow/volca-convert) using it - probably not the cleanest Golang code, but it does seem to work.

One of the big advantages of [Golang](https://go.dev/) is that, at least for command line programs, **you can compile the same source code to run on any of several dozen different platforms**, including both 32- and 64-bit versions of ms-windows.

I did some playing around with a way to build the same Golang program for a list of different architectures. [This repo](https://github.com/kg4zow/hello-golang) talks about how to do it, and includes a `Makefile` that

## Idea

The idea I have is to write a single `rm2` program which can be used instead of the existing `rm2-xxx` scripts. I'm not sure if I want to include the template scripts, but I think it makes sense for the others (`rm2-list`, `rm2-backup`, `rm2-clean`, etc.) to be included.

Each `rm2-xxx` script would become a sub-command, so `rm2-list` would become "`rm2 list`".

Obviously the resulting `rm2` (or `rm2.exe`) executables would be available for any architecture that Golang supports, and the source code would be available under an open-source license
