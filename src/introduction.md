# Introduction

I am the owner of a new (as of 2023-06-27) [reMarkable 2](https://remarkable.com/) tablet.

* Update: I picked up a used tablet so I can experiment with it, without any risk of losing or accidentally sharing the files in my primary tablet.

* Update: I also picked up a used rM1 tablet, also for experimentation.

I'm using this site as a way to record the information I learn about them, and the things I do to customize them. I'm doing this for two reasons:

* So that I will have a reference to look back on in the future, in case I need it. (I find that the act of writing documentation helps me to organize the details in my head.)

* So that others who may find this information useful will have access to it as well.

There probably won't be much to see at first, but I plan to add information over time after and I start playing/working with them.

> &#x2139;&#xFE0F; **In Progress**
>
> Some of the items in the Table of Contents menu may not actually link to pages yet, and some of the pages which *exist* may not be complete. I'm writing this in my spare time, and `$DAYJOB` doesn't give me a whole lot of that. If you're paying attention, you'll probably notice there are more updates on the weekends. Please be patient.

![rss.svg](images/rss.svg) [RSS feed](https://remarkable.jms1.info/commits.xml) - if you use an RSS reader, this feed contains a post for each commit in the git repo where I track the site's source files. (The git repo is [stored in Github](https://github.com/kg4zow/remarkable.jms1.info), and the web site is [hosted using Keybase Sites](https://book.keybase.io/sites).)

## Similar Sites

This site is becoming "known" in the reMarkable community ... which is cool I guess, but I'm not really trying to become "the one site" for everything relating to reMarkable tablets. There are other sites out there with more/better information, and/or which cover things I haven't covered (and may *never* cover) on this site.

* [`remarkable.guide`](https://remarkable.guide/) has been around a lot longer than this site. Most of the pages there seem to be quick little "what to do" articles, which is cool if you just want to "do the thing" and aren't interested in why you need to do it, or what's actually happening under the covers.

    I've always been more curious and tend to want to understand things in more detail, so I tend to write longer, more detailed pages - especially because I *use* the site myself (I don't remember every little detail about everything I write about, that's why I write it down).


## reMarkable Cloud

I'm NOT connecting any of my tablets to the "reMarkable Cloud" at all. I'm doing this for a few reasons:

* **Privacy**

    Privacy is *very* important to me. Not that I have any great secrets, I just don't like the feeling of somebody (or thousands of somebodies) watching everything I do over my shoulder, especially when they are using that information against me by targeting ads.

    reMarkable has pretty much designed the tablet's software to keep everything synchronized to their "cloud", which is hosted on Google's "cloud" in Europe.

    There *are* some benefits in doing it this way.

    * If your tablet is damaged or lost, you can buy another tablet and sign it into the same account, and your documents will sync back from the cloud.

    * It allows the reMarkable apps on your computer or phone to access the cloud and work with documents on the tablet, without having to connect *directly* to the tablet.

    * Since the API that the apps use to "talk to" the cloud is *mostly* known, third-party apps are  also able to interact with your documents by talking to your cloud account.

    However.

    Synchronizing the tablet to the cloud means that copies of all of your content - every notebook, every "quick sheet", every PDF or EPUB file you upload into the tablet - are being uploaded to their cloud.

    On some level, the files in the cloud are encrypted. However, the encryption keys are held by reMarkable and/or Google, which means that your files can be read by reMarkable or Google employees, along with any shady three-letter government agencies (from *any* country) who ask, along with any random anklebiter who manages to hack into reMarkable's or Google's systems. (Because as we all know, large companies who pay obscene amounts of money for dedicated security staffers [never get hacked](https://techcrunch.com/2023/07/17/microsoft-lost-keys-government-hacked/).)

    These people can also *change* what's in the cloud, and your tablet will happily download those changes, changing or deleting content however *somebody else* wants.

    It IS possible to structure a cloud service in such a way that the files in the cloud are "end-to-end" encrypted, with the encryption keys only available to the devices and apps attached to the account. ([Keybase](https://keybase.io/) is a good example of this, each *device* has its own encryption keys.) reMarkable didn't structure their cloud service this way, and as a result, any files created or side-loaded on a reMarkable tablet which connects to the cloud service are available to hundreds of other people, thousands of government employees (for various values of "government"), and unknown hordes of "hackers".

* **Security of Third Party Services**

    reMarkable offers integrations with third-party file storage services, currently including Dropbox, Google, and Microsoft. **These integrations are done by the reMarkable cloud servers.** Your tablet never talks to these other services directly, the only things it ever talks to are reMarkable's servers (other than basic networking services).

    Part of setting up each integration involves generating a security token that gives the reMarkable servers access to your accounts on these other providers. These tokens are held on reMarkable's servers.

    Just like how reMarkable employees, government-ish agencies, and random hackers who get into reMarkable's systems are able to access the files on your tablet, they are also able to access files in your accounts on these other services.

* **Compliance/Legal**

    My current `$DAYJOB` is with a company in the healthcare industry. My particular job (software development, system and network administration, and other related "technical" stuff) doesn't involve *regular* exposure to PHI (protected health information), however some of my cow-orkers deal with log files containing small bits of PHI on a regular basis, so they wouldn't *legally* be able to use the cloud service.

    reMarkable **used to be** willing to execute a HIPAA Business Associate Agreement with their users, however when they updated their [Terms and Condtions](https://support.remarkable.com/s/article/Terms-and-Conditions-reMarkable-Accounts) in 2024-02 they removed that paragraph - section 7 *used to* have three parargraphs, now it only has two.

    The page *says* "Effective date: February 27, 2023" but the change was made in 2024, I choose to attribute this to human carelessness rather than as an attempt to "back-date" the agreement, especially since the same change also messed up the formatting of the page (look at how the section headers are formatted, it looks like a *bad* micosoft word document).

    Something that would make *me personally* more comfortable would be a clear statement that nobody, not even reMarkable employees, are able to look at peoples' documents in the cloud. But from their description of how the service is structured, and the fact that they DID offer to execute BAA's but now they don't, it's obvious to me that this is not the case.

    > &#x2139;&#xFE0F; **rmfakecloud**
    >
    > [rmfakecloud](https://ddvk.github.io/rmfakecloud/) is a project which duplicates most of the "cloud sync" functionality, but hosted on a server that YOU control. This includes handwriting recognition, by talking to [MyScript](https://www.myscript.com/) (the third-party service that reMarkable uses to perform handwriting recognition).
    >
    > If you do this, you do have to get your own service with MyScript if you plan to use the handwriting recognition functionality. MyScript's service charges based on the number of "recognition events" you perform each month. I *think* reMarkable has some kind of volume discount with MyScript. The API requests to perform the handwriting recognition all use reMarkable's account with MyScript, and reMarkable pays for them as part of peoples' monthly subscription fees for the reMarkable cloud.
    >
    > I have not played with `rmfakecloud` yet, however it is on my list of things to check out.

* **Functionality**

    The news is full of stories about companies who design their products to connect to a "cloud" service of some kind, and then when the company later decides to stop providing the cloud service (or goes out of business entirely), those products suddenly stop working.

    **When I buy a product, I expect that product to be able to do the same job, even if the original manufacturer goes out of business.**

    In the case of the reMarkable tablet, one of the things you miss out on by not connecting to their "cloud" is handwriting recognition (where the tablet turns the pen strokes you draw with the stylus, into actual text). I remember reading somewhere that this happened on the tablet itself, which was one of the reasons I decided to buy one. I later found that this was not the case, however it has already replaced the paper notebooks I used to keep, so returning the tablet is not an option.

### NOT A BACKUP

**The reMarkable cloud service is not a backup.**

Anything you delete on the tablet will also be deleted from the cloud, and anything deleted from the cloud will also be deleted from the tablet.

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

* Email: `jms1@jms1.net`
* [Keybase: `jms1`](https://keybase.io/jms1/)

    I am also `kg4zow` on Keybase, however I only use that account for amateur radio stuff. If you try to contact me there, there's a good chance I won't see it for several months.

## License

![CC BY 4.0](https://i.creativecommons.org/l/by/4.0/88x31.png)

This web site is licensed under a [Creative Commons Attribution 4.0 International License](href="http://creativecommons.org/licenses/by/4.0/").

Short version, you're free to use, copy, and re-share the information, including commercially, as long as you tell people that I originally wrote it, provide a link back to where you found it (i.e. this web site), and if you're sharing a modified version, make it clear which parts you modified.

&#x21D2; [Better explanation](https://creativecommons.org/licenses/by/4.0/)

&#x21D2; [Full legal mumbo jumbo](https://creativecommons.org/licenses/by/4.0/legalcode)

### Exception

The `/theme/index-template.hbs` file in the git repo, whose contents make up part of every generated HTML page, was copied from `/src/theme/index.hbs` in [the mdbook source](https://github.com/rust-lang/mdBook/blob/master/src/theme/index.hbs) and then modified. As such, that file is technically covered by the [Mozilla Public License 2.0](https://www.mozilla.org/en-US/MPL/), as noted [in their repo](https://github.com/rust-lang/mdBook/blob/master/LICENSE).
