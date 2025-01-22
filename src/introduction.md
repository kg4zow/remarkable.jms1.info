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

## reMarkable Cloud

I am NOT connecting my primary tablet to the "reMarkable Cloud" at all. I'm doing this for a few reasons:

* **Privacy**

    Privacy is *very* important to me. Not that I have any great secrets, I just don't like the feeling of somebody (or thousands of somebodies) watching everything I do over my shoulder, especially when they are using that information against me (by targeting ads, training AI models, or whatever else they do with it, without my permission or knowledge).

    reMarkable has pretty much designed the tablet's software to keep everything synchronized to their "cloud", which is hosted on Google's "cloud" in Europe.

    There *are* some benefits in doing it this way.

    * If your tablet is damaged or lost, you can buy another tablet and sign it into the same account, and your documents will sync back from the cloud.

    * It allows the reMarkable apps on your computer or phone to access the cloud and work with documents on the tablet, without needing to connect *directly* to the tablet.

    * Since the API that the apps use to "talk to" the cloud is *mostly* known, third-party apps are  also able to interact with your documents by talking to your cloud account. (This was not reMarkable's doing, this is because other people have "sniffed" the traffic and figured out how the API works.)

        Note that the API was changed in mid-2024. At the time people were thinking it was to prevent third-party programs from being able to use it, however the rMPP was announced in 2024-09, so it looks like the main reason for the API change was to support the rMPP, and to support having multiple tablets attached to the same account (to make it easy for people to upgrade from an earlier tablet to the rMPP).

    However.

    Synchronizing the tablet to the cloud means that copies of all of your content - every notebook, every "quick sheet", every PDF or EPUB file you upload into the tablet - are being uploaded to their cloud. There is no way to choose which documents are uploaded, it's "all or nothing".

    On some level, the files in the cloud are encrypted. However, the encryption keys are held by reMarkable and/or Google, which means that your files can be read by reMarkable or Google employees, along with any shady three-letter government agencies (from *any* country) who ask, along with any random anklebiter who manages to hack into reMarkable's or Google's systems. (Because as we all know, large companies who pay obscene amounts of money for dedicated security staffers [never get hacked](https://techcrunch.com/2023/07/17/microsoft-lost-keys-government-hacked/).)

    These people can also *change* what's in the cloud, and your tablet will happily download those changes, changing or deleting the content on your tablet, however *somebody else* wants.

    It IS possible to structure a cloud service in such a way that the files in the cloud are "end-to-end" encrypted, with the encryption keys only available to the devices and apps attached to the account. ([Keybase](https://keybase.io/) is a good example of this, each *device* has its own encryption keys.) reMarkable didn't structure their cloud service this way, and as a result, any files created or side-loaded on a reMarkable tablet which connects to the cloud service are available to hundreds of other people, thousands of government employees (for various values of "government"), and unknown hordes of "hackers".

* **Security of Third Party Services**

    reMarkable offers integrations with third-party file storage services, currently including Dropbox, Google, and Microsoft. **These integrations are done by the reMarkable cloud servers.** Your tablet never talks to these other services directly.

    > &#x2139;&#xFE0F; Other than basic networking services (DHCP and NTP), the only things the tablet talks to directly are reMarkable's servers, and (in later software versions) a [third-party analytics company](https://memfault.com/iot-product-analytics/) who tracks the software (and other things?) on the tablets and is somehow involved in the software upgrade process.

    Part of setting up each file-sharing integration involves generating a security token that gives the reMarkable servers access to your accounts on these other providers. These tokens are held on reMarkable's servers.

    Just like how reMarkable employees, government-ish agencies, and random hackers who get into reMarkable's systems are able to access the files on your tablet, they are also able to access those tokens, and therefore **able to access everything in your accounts on these other services**, whether it has been copied to your tablet or not.

    Also note, these integrations are for uploading and downloading files only. They do not automatically sync changes either way.

* **Compliance/Legal**

    My current `$DAYJOB` is with a company in the healthcare industry. My particular job (software development, system and network administration, "DEVOPS", and other related "technical" things) doesn't involve *regular* exposure to PHI (protected health information), however I do sometimes need to deal with log files containing small bits of PHI. This means that if I were using the reMarkable cloud, I would have to be careful about writing down any information from those log files, because *legally* that information cannot be shared with outsiders (including reMarkable or google).

    reMarkable **used to be** willing to execute a HIPAA Business Associate Agreement with their users, however when they updated their [Terms and Condtions](https://support.remarkable.com/s/article/Terms-and-Conditions-reMarkable-Accounts) in 2024-02 they removed that paragraph - section 7 *used to* have three parargraphs, now it only has two.

    The page *says* "Effective date: February 27, 2023" but the change was made in 2024, I choose to attribute this to human carelessness rather than as an attempt to "back-date" the agreement, especially since the same change also messed up the formatting of the page (look at how the section headers are formatted, it looks like a *bad* micosoft word document).

    Something that would make *me personally* more comfortable would be a clear statement that nobody, not even reMarkable employees, are able to look at peoples' documents in the cloud. But from their description of how the service is structured, and the fact that they DID offer to execute BAA's but now they don't, it's obvious to me that this is not the case.

    > &#x2139;&#xFE0F; **rmfakecloud**
    >
    > [rmfakecloud](https://ddvk.github.io/rmfakecloud/) is a project which duplicates most of the "cloud sync" functionality, but hosted on a server that YOU control. This includes handwriting recognition, by talking to [MyScript](https://www.myscript.com/) (the same third-party service that reMarkable uses to perform handwriting recognition).
    >
    > If you do this, you do have to get your own service with MyScript if you plan to use the handwriting recognition functionality. MyScript's service charges based on the number of "recognition events" you perform each month.
    >
    > My guess is that reMarkable has some kind of volume discount with MyScript. reMarkable pays MyScript for all handwriting recognition requests made by all tablets connected to the reMarkable cloud service. If your tablet is connected to rmfakecloud and you use the handwriting recognition function, you would need to make your own arrangements with MyCloud to pay for that service.
    >
    > [This page](https://developer.myscript.com/pricing) contains what little they're willing to say about pricing - basically the first 2000 requests each month are free, and after that, "contact us". An [old message](https://developer-support.myscript.com/support/discussions/topics/16000030978) on their developer support forum mentions the pricing beyond that as $10 per 1000 requests, I have no idea if that's still accurate or not.
    >
    > I have not played with rmfakecloud yet, however it is on my list of things to check out.
    >
    > Also, it's worth pointing out that rmfakecloud uses the *original* cloud API. The last I heard, the tablet software was capable of using either version of the API, but it's possible that versions released after reMarkable changed their servers to use the newer API are no longer able to "speak" the older API. This means you might need to downgrade your tablet to an older OS if you want to use rmfakecloud.

* **Functionality**

    The news is full of stories about companies who design their products to connect to a "cloud" service of some kind, and then when the company later decides to stop providing the cloud service (or goes out of business entirely), those products suddenly stop working.

    **When I buy a product, I expect that product to be able to do the same job, even if the original manufacturer goes out of business.**

    In the case of the reMarkable tablet, one of the things you miss out on by not connecting to their "cloud" is handwriting recognition (where the tablet turns the pen strokes you draw with the stylus, into actual text). I remember reading somewhere that this happened on the tablet itself, which was one of the reasons I decided to buy one. I later found that this was not the case (i.e. that the handwriting recognition was done "in the cloud"), however it has already replaced the paper notebooks I used to keep, so returning the tablet is not an option.

### NOT A BACKUP

**The reMarkable cloud service is not a backup.** It's a sync service.

The reMarkable desktop and mobile apps all work by talking to a cloud account, and relying on the tablet to sync any changes when they happen.

In particular, anything you delete on the tablet will also be deleted from the cloud, and anything deleted from the cloud will also be deleted from the tablet.

Think of it as a *mirror* of your tablet.

## Created with `mdbook`

This "book" is being created using a program called [mdbook](https://rust-lang.github.io/mdBook/), which allows me to write the content using [Markdown](https://en.wikipedia.org/wiki/Markdown) and have it converted to an HTML format that *I think* looks nice, especially with a few minor customizations.

And rather than making the same customizations every time I start a new "book" (I have several, both at work and for non-work), I created a template containing a newly created book with my customizations already in place.

&#x21D2; [`https://github.com/kg4zow/mdbook-template/`](https://github.com/kg4zow/mdbook-template/)

## Keybase

I make use of [Keybase](https://keybase.io/) on a *very* regular basis.

* This site's "source code" was *originally* tracked in a [Keybase git](https://book.keybase.io/git) repo. It's now being tracked in [Github](https://github.com/kg4zow/remarkable.jms1.info/) so people can "watch" the repo.

* The site is being served using [Keybase Sites](https://book.keybase.io/sites).

The web hosting function *could* be replaced by Github, however I prefer using Keybase in general (again, privacy), so I plan to leave it where it is unless there's a good reason to move it to Github.

## Feedback

I would appreciate any feedback you may have to offer about this book. This *especially* includes if you spot any typos, if you see any information which is incorrect or incomplete, or if there's something you'd like to see me cover.

* [Keybase: `jms1`](https://keybase.io/jms1/)

    I am also `kg4zow` on Keybase, however I only use that account for amateur radio stuff. If you try to contact me there, there's a good chance I won't see it for several months.

* [reMarkable Community Discord](https://discord.gg/JSSGnFY): `kg4zow`

* Email: `jms1@jms1.net`

## License

![CC BY 4.0](https://i.creativecommons.org/l/by/4.0/88x31.png)

This web site is licensed under a [Creative Commons Attribution 4.0 International License](href="http://creativecommons.org/licenses/by/4.0/").

Short version, you're free to use, copy, and re-share the information, including commercially, as long as you tell people that I originally wrote it, provide a link back to where you found it (i.e. this web site), and if you're sharing a modified version, make it clear which parts you modified.

&#x21D2; [Better explanation](https://creativecommons.org/licenses/by/4.0/)

&#x21D2; [Full legal mumbo jumbo](https://creativecommons.org/licenses/by/4.0/legalcode)

### Exception

The `/theme/index-template.hbs` file in the git repo, whose contents make up part of every generated HTML page, was copied from `/src/theme/index.hbs` in [the mdbook source code](https://github.com/rust-lang/mdBook/blob/master/src/theme/index.hbs) and then modified. As such, that one file is covered by the [Mozilla Public License 2.0](https://www.mozilla.org/en-US/MPL/), as noted [in their repo](https://github.com/rust-lang/mdBook/blob/master/LICENSE).
