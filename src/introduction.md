# Introduction

I am the owner of a new (as of 2023-06-27) [reMarkable 2](https://remarkable.com/) tablet. (Update: I picked up a used tablet so I can experiment with it, without any risk of losing or accidentally sharing the files in my primary tablet.)

I'm using this site as a way to record the information I learn about them, and the things I do to customize them. I'm doing this for two reasons:

* So that I will have a reference to look back on in the future, in case I need it. (I find that the act of writing documentation helps me to organize the details in my head.)

* So that others who may find this information useful will have access to it as well.

There probably won't be much to see at first, but I plan to add information over time after and I start playing/working with them.

> &#x2139;&#xFE0F; **In Progress**
>
> Some of the items in the Table of Contents menu may not actually link to pages yet, and some of the pages which *exist* may not be complete. I'm writing this in my spare time, and `$DAYJOB` doesn't give me a whole lot of that. If you're paying attention, you'll probably notice there are more updates on the weekends. Please be patient.

![rss.svg](images/rss.svg) [RSS feed](https://remarkable.jms1.info/commits.xml) - if you use an RSS reader, this feed contains a post for each commit in the git repo where I track the site's source files. (The git repo is [stored in Keybase](https://book.keybase.io/git), although I *could* move it to Github if people are interested in looking at it.) (This web site is also [hosted using Keybase Sites](https://book.keybase.io/sites).)


## Links

These are links that I seem to be copying and pasting a lot whenever I talk to other people about the tablet. I'm putting them here so I know where to quickly find them when I need them.

* [Case](https://www.amazon.com/dp/B0BWTN88W4) - I keep my tablet in this "CoBak" case. I ordered the reMarkable [Book Folio](https://remarkable.com/store/remarkable-2/folios) (in Gray) *with* the tablet, but the third-party cover fully encloses the tablet *and* the stylus. (I actually have two of these - green with a built-in stand for my primary tablet, and blue without the stand for my spare tablet.)

* [Titanium nibs](https://www.amazon.com/dp/B0BF9WJ8VX) - I used one of these "nibs" in my stylus (reMarkable "Marker Plus") for about a month. I've seen people online say that metal nibs can damage the screen, which makes sense ... any time there's friction between two things (like a nib and a screen), the *weaker* thing is going to take a bit of damage.

    I haven't noticed any scratches, "smooth spots", or other damage on my screen, but I also don't press down very hard when I write. Either way, I don't want to take the chance of damaging my tablet (although I *might* use one with the "spare" tablet, just to see if I end up noticing anything.

* [Plastic nibs](https://www.amazon.com/dp/B0BWX873ZX) - I've gone back to using the original reMarkable nib that came in the stylus, and I'll be trying these when that original nib wears down.

* [RCU](http://www.davisr.me/projects/rcu/) - third-party program to manage reMarkable tablets, especially tablets which don't connect to the reMarkable cloud service. **Highly recommended**, especially if you don't connect your tablet to the reMarkable cloud service.

## reMarkable Cloud

**For now**, I'm planning to NOT connect my tablet to the "reMarkable Cloud" at all. I'm doing this for a few reasons:

* **Privacy**

    If you know anything about me, you know that privacy is *very* important to me. Not that I have any great secrets, I just don't like the feeling of somebody (or thousands of somebodies) watching everything I do over my shoulder, especially when they are monetizing everything they see without sharing any of that money with me.

    reMarkable has pretty much designed the tablet's software to keep everything synchronized to their "cloud", which is hosted on Google's "cloud" in Europe.

    There *are* benefits in doing it this way.

    * You'll have an automatic backup in case the tablet is physically damaged or needs to be replaced.

    * It allows the reMarkable apps on your computer or phone to access the cloud and work with files on the tablet, without having to connect *directly* to the tablet.

    * Since the API that the apps use to "talk to" the cloud is *mostly* known, it allows third-party apps to also interact with your tablet (i.e. upload and download documents) by talking to your cloud account.

    However.

    Synchronizing the tablet to the cloud means that copies of all of your content - every notebook, every "quick sheet", every PDF or EPUB file you upload into the tablet - are being uploaded to their cloud.

    The files in the cloud are "encrypted", however the keys are held by reMarkable and/or Google, which means that your files can be read by reMarkable or Google employees, along with any shady three-letter government agencies who ask, and any random anklebiter who manages to hack into reMarkable's or Google's systems. (Because, you know, large companies with obscene amounts of money to pay dedicated security staffers [never get hacked](https://techcrunch.com/2023/07/17/microsoft-lost-keys-government-hacked/)).

    These people can also *change* what's in the cloud, and your tablet will happily download those changes, changing or deleting content however *somebody else* wants.

    It IS possible to structure the cloud service in such a way that the files in the cloud are encrypted, with the encryption keys only available to the devices and apps attached to the account. (This is how [Keybase](https://keybase.io/) is structured, each *device* has its own encryption keys.) reMarkable did not structure their cloud service this way, and as a result, any files created or side-loaded into a reMarkable tablet are available to hundreds of other people, thousands of government employees, and unknown hordes of "hackers".

* **Compliance/Legal**

    My current `$DAYJOB` is with a company in the healthcare industry. My particular job (software development, system and network administration, and other related "technical" stuff) doesn't involve *regular* exposure to any PHI (protected health information), however some of my cow-orkers deal with HIPAA issues all day long, so they wouldn't *legally* be able to use the cloud service.

    I have since found that reMarkable *IS WILLING* to execute a HIPAA Business Associate Agreement (see the [reMarkable Account Terms and Conditions](https://support.remarkable.com/s/article/Terms-and-Conditions-reMarkable-Accounts), section 7) with their users. A BAA is a legally binding document where reMarkable agrees to be held liable in case of a data breach in/through their cloud. The fact that they are *willing* to make this agreement is an indicator that *they* believe in the security of their cloud. (It isn't clear to me whether they have also executed such an agreement with Google, but for *their* sake I would hope so.)

    The other thing that would me *me personally* more comfortable would be a statement that nobody, not even reMarkable employees, are able to look at the contents of the notes that people store in the cloud ... but from their description of how the service is structured, it's obvious to me that this is not the case.

    For what it's worth, [rmfakecloud](https://ddvk.github.io/rmfakecloud/) is a project which duplicates most of the "cloud sync" functionality, but hosted on a server that YOU control. This includes handwriting recognition, by talking to the same [third-party service](https://www.myscript.com/) that reMarkable uses to provide handwriting recognition.

* **Functionality**

    The news is full of stories about companies who design their products to connect to a "cloud" service of some kind, and then when the company later decides to stop providing the cloud service (or goes out of business entirely), those products suddenly stop working.

    **When I buy a product, I expect that product to be able to do the same job, even if the original manufacturer goes out of business.**

    In the case of the reMarkable tablet, one of the things you miss out on by not connecting to their "cloud" is handwriting recognition (where the tablet turns the pen strokes you draw with the stylus, into actual text). I remember reading somewhere that this happened on the tablet itself, which was one of the reasons I decided to buy one. I later found that this was not the case, however it has already replaced the paper notebooks I used to keep, so returning the tablet is not an option.

## Created with `mdbook`

This "book" is being created using a program called [mdbook](https://rust-lang.github.io/mdBook/), which allows me to write the content using [Markdown](https://en.wikipedia.org/wiki/Markdown) and have it converted to an HTML format that *I think* looks nice, especially with a few minor customizations.

And rather than making the same customizations every time I start a new "book" (I have several, both at work and for non-work), I created a template containing a newly created book with my customizations already in place.

&#x21D2; [`https://github.com/kg4zow/mdbook-template/`](https://github.com/kg4zow/mdbook-template/)

## Keybase

I make use of [Keybase](https://keybase.io/) on a *very* regular basis.

* This site's "source code" is being tracked in a [Keybase git](https://book.keybase.io/git) repo.

* The site is being served using [Keybase Sites](https://book.keybase.io/sites).

Either or both of these functions *could* be replaced by Github, however I prefer using Keybase in general (again, privacy), so unless I have a good reason to move them to Github, I plan to leave them where they are.

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
