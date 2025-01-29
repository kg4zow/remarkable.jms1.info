# Introduction

I am the owner of four [reMarkable tablets](https://remarkable.com/) - one rM1, two rM2's, and now an rMPP. The first one arrived on 2023-06-27. I'm using the original rM2 as my "primary" tablet, while the others are being used for experimentation (so I can try things which might be dangerous, without any risk to my real notes).

I'm using this site as a way to record the information I learn about them, and the things I do to customize them. I'm doing this for two reasons:

* So that I will have a reference to look back on in the future, in case I need it. (I find that the act of writing documentation helps me to organize the details in my head.)

* So that others who may find this information useful will have access to it as well.

I plan to add information over time, especially with the release of the rMPP.

> &#x2139;&#xFE0F; **In Progress**
>
> Some of the items in the Table of Contents menu may not actually link to pages yet, and some of the pages which *exist* may not be complete. I'm writing this in my spare time, and `$DAYJOB` doesn't give me a whole lot of that. If you're paying attention, you'll probably notice there are more updates on the weekends. Please be patient.

![rss.svg](images/rss.svg) [RSS feed](https://remarkable.jms1.info/commits.xml) - if you use an RSS reader, this feed contains a post for each commit in the git repo where I track the site's source files. (The git repo is [stored in Github](https://github.com/kg4zow/remarkable.jms1.info), and the web site is [hosted using Keybase Sites](https://book.keybase.io/sites).)

## Similar Sites

This site is becoming "known" in the reMarkable community ... which is cool I guess, but I'm not really trying to become "the one site" for everything relating to reMarkable tablets. There are other sites out there with more/better information, and/or which cover things I haven't covered (and may *never* cover) on this site.

* [`remarkable.guide`](https://remarkable.guide/) is run by some of the same people who maintain [Toltec](https://toltec-dev.org/), which is "a community-maintained repository of free software for the reMarkable tablet". These guys do a LOT more low-level hacking on the tablets than I do, including modifying or replacing the software entirely. I would probably be doing the same thing if I had more time, but `$DAYJOB` keeps me pretty busy.

    The `remarkable.guide` site has been around longer than my site (the one you're reading right now). Most of the pages there seem to be quick little "what to do" articles, which is cool if you just want to "do the thing" and aren't interested in *why* you need to do it, or in what's actually happening under the covers.

    I've always been more curious and want to understand things in more detail, so I tend to write longer, more detailed pages - especially because I *use* this site myself. I can't remember every little detail about everything I'm interested in, which is why I write it all down - so I can refer back to it later. (The [`jms1.info`](https://jms1.info/) site is the same idea, but not focused on reMarkable tablets. And it also suffers from the same "not enough time" problem.)

* [`remarkablewiki.com`](https://remarkablewiki.com/) &#x274C; **not working** - When I first got my first tablet, this site had a similar collection of articles. The site has since been taken down, the current page is a generic "this web site is not available" page from a web hosting company in Germany. The domain's registration information was last updated on 2023-11-10.

    My guess is that whoever started the site, stopped paying for the hosting, and the hosting company took over the domain. I'm not aware of any mirrors out there, but from what I remember, the site was fairly useful. I wish they had announced ahead of time that they were shutting down the site, I could have hosted it myself (and I'm sure half a dozen other people can say the same thing).

## Created with `mdbook`

This "book" is being created using a program called [mdbook](https://rust-lang.github.io/mdBook/), which allows me to write the content using [Markdown](https://en.wikipedia.org/wiki/Markdown) and have it converted to an HTML format that *I think* looks nice, especially with a few minor customizations.

And rather than making the same customizations every time I start a new "book" (I have several, both at work and for non-work), I created a template containing a newly created book with my customizations already in place.

&#x21D2; [`https://github.com/kg4zow/mdbook-template/`](https://github.com/kg4zow/mdbook-template/)

## Keybase

I make use of [Keybase](https://keybase.io/) on a *very* regular basis.

* This site's "source code" was *originally* tracked in a [Keybase git](https://book.keybase.io/git) repo. It's now being tracked in [Github](https://github.com/kg4zow/remarkable.jms1.info/) so people can "watch" the repo.

* The site is being served using [Keybase Sites](https://book.keybase.io/sites).

The web hosting function *could* be replaced (by Github, or by my own web server) however I prefer using Keybase in general (again, privacy), so I plan to leave it where it is unless there's a good reason to move it.

## Feedback

I would appreciate any feedback you may have to offer about this book. This *especially* includes if you spot any typos, if you see any information which is incorrect or incomplete, or if there's something you'd like to see me cover.

* [Keybase: `jms1`](https://keybase.io/jms1/)

    I am also `kg4zow` on Keybase, however I only use that account for amateur radio stuff. If you try to contact me using that username, there's a good chance I won't see it for several months.

* [reMarkable Community Discord](https://discord.gg/JSSGnFY): `kg4zow` (I'm not in there very often)

* Email: `jms1@jms1.net`

## License

![CC BY 4.0](https://i.creativecommons.org/l/by/4.0/88x31.png)

This web site is licensed under a [Creative Commons Attribution 4.0 International License](href="http://creativecommons.org/licenses/by/4.0/").

Short version, you're free to use, copy, and re-share the information, including commercially, as long as you tell people that I originally wrote it, provide a link back to where you found it (i.e. this web site), and if you're sharing a modified version, make it clear which parts you modified.

&#x21D2; [Better explanation](https://creativecommons.org/licenses/by/4.0/)

&#x21D2; [Full legal mumbo jumbo](https://creativecommons.org/licenses/by/4.0/legalcode)

### Exception

The `.hbs` files in the git repo's `theme-template/` directory, whose contents make up part of every generated HTML page, were copied from the [mdbook source code](https://github.com/rust-lang/mdBook/blob/master/src/theme/) and then modified. As such, these files are covered by the [Mozilla Public License 2.0](https://www.mozilla.org/en-US/MPL/), as noted in [their repo's `LICENSE` file](https://github.com/rust-lang/mdBook/blob/master/LICENSE).
