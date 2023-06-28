# Introduction

I am the owner of a new (as of 2023-06-27) [reMarkable 2](https://remarkable.com/) tablet.

I'm using this site as a way to record the information I learn about it, and the things I do to customize it. I'm doing this for two reasons:

* So that I will have a reference to look back on in the future, in case I need it. (I find that the act of writing documentation helps me to organize the details in my head.)

* So that others who may find this information useful will have access to it as well.

There probably won't be much to see at first, but I plan to add information over time after and I start playing/working with it.

> &#x2139;&#xFE0F; **In Progress**
>
> Some of the items in the Table of Contents menu may not actually link to pages yet, and some of the pages which *exist* may not be complete. I'm writing this in my spare time, and `$DAYJOB` doesn't give me a whole lot of that. Please be patient.

### reMarkable Cloud

**For now**, I'm planning to NOT connect my tablet to the "reMarkable Cloud" at all. I'm doing this for two reasons:

* **Privacy**

    If you know me, you know that privacy is *very* important to me. Not that I have any great secrets, I just don't like the feeling of somebody (or thousands of somebodies) watching everything I do over my shoulder, especially when they are monetizing everything they see without sharing any of that money with me.

    reMarkable has pretty much designed the tablet's software to keep everything synchronized to their "cloud", which is actually part of Google's "cloud" in Europe. This *can* be a good thing, i.e. you have an automatic backup in case the tablet is physically damaged or needs to be replaced, you can synchronize content between a tablet and desktop/mobile apps, and so forth.

    However.

    Synchronizing the tablet to the cloud means that copies of all of your content - every notebook, every "quick sheet", every PDF or EPUB file you upload into the tablet - are being uploaded to their cloud. The files in the cloud can be read by reMarkable employees, Google employees, shady three-letter government agencies, any random anklebiter who manages to hack into their systems. These people can also *change* what's in the cloud, and your tablet will happily download those changes, changing or deleting content however *somebody else* wants.

    It IS possible to structure the cloud service in such a way that the files in the cloud are encrypted, with the encryption keys only available to the devices and apps attached to the account. (This is how [Keybase](https://keybase.io/) is structured, each *device* has its own encryption keys.) reMarkable did not structure the cloud service this way, and as a result, any files created or side-loaded into a reMarkable tablet are available to hundreds of other people, thousands of government employees, and unknown hordes of "hackers".

* **Functionality**

    The news is full of stories about companies who design their products to connect to a "cloud" service of some kind, and then when the company later decides to stop providing the cloud service (or goes out of business entirely), those products suddenly stop working.

    **When I buy a product, I expect that product to be able to do the same job, even if the original manufacturer goes out of business.**

    In the case of the reMarkable tablet, one of the things you miss out on by not connecting to their "cloud" is handwriting recognition (where the tablet turns the letters and numbers you draw with the stylus, into actual text). This process *supposedly* happens on the tablet itself, and in my case, their claim that handwriting recognition happens on the tablet was one of the things that finally made me decide to spend the money.

    It turns out that, even if the software *can* perform the handwriting recognition on the tablet itself, the software *won't* do it unless it's been synchronized to the cloud. I don't know why this is, unless it's reMarkable's way of forcing people into using their cloud. (I will admit, maybe there is a legitimate reason, maybe this is my own cynicism and mis-trust of corporations in general.)

    This really feels like a "bait and switch" to me. Nothing on the web site explains *that*, or *why*, functionality that happens on the device itself needs to be dependent on being tied to their cloud service. They do offer a 100-day free return policy, so I may return it. If so, this will be one of the biggest reasons.

## Created with `mdbook`

This "book" is being created using a program called [mdbook](https://rust-lang.github.io/mdBook/), which allows me to write the content using [Markdown](https://en.wikipedia.org/wiki/Markdown) and have it converted to an HTML format that *I think* looks nice, especially with a few minor customizations.

And rather than making the same customizations every time I start a new "book" (I have several, both at work and for non-work), I created a template containing a newly created book with my customizations already in place.

&#x21D2; [`https://github.com/kg4zow/mdbook-template/`](https://github.com/kg4zow/mdbook-template/)

## Keybase

I make use of [Keybase](https://keybase.io/) on a *very* regular basis.

* This site's "source code" is being tracked in a [Keybase git](https://book.keybase.io/git) repo.

* The site is being served using [Keybase Sites](https://book.keybase.io/sites).

## Feedback

I would appreciate any feedback you may have to offer about this book. This *especially* includes if you spot any typos, if you see any information which is incorrect or incomplete, or if there's something you'd like to see me cover.

* Email: `jms1@jms1.net`
* [Keybase: `jms1`](https://keybase.io/jms1/)

## License

![CC BY 4.0](https://i.creativecommons.org/l/by/4.0/88x31.png)

This web site is licensed under a [Creative Commons Attribution 4.0 International License](href="http://creativecommons.org/licenses/by/4.0/").

Short version, you're free to use, copy, and re-share the information, including commercially, as long as you tell people that I originally wrote it, provide a link back to where you found it (i.e. this web site), and if you're sharing a modified version, make it clear which parts you modified.

&#x21D2; [Better explanation](https://creativecommons.org/licenses/by/4.0/)

&#x21D2; [Full legal mumbo jumbo](https://creativecommons.org/licenses/by/4.0/legalcode)

### Exception

The `/theme/index-template.hbs` file in the git repo, whose contents make up part of every generated HTML page, was copied from `/src/theme/index.hbs` in [the mdbook source](https://github.com/rust-lang/mdBook/blob/master/src/theme/index.hbs) and then modified. As such, that file is technically covered by the [Mozilla Public License 2.0](https://www.mozilla.org/en-US/MPL/), as noted [in their repo](https://github.com/rust-lang/mdBook/blob/master/LICENSE).
