# Issues with reMarkable

After contacting reMarkable support to report an incorrect statement on one of their support web pages, I received an email asking me to take a survey. Very simple, the usual 1-10 NPS (net promoter score), plus an open text entry field to explain why I chose the score I did.

I have a whole *list* of things that I *could* tell them, and usually these fields have a limit on how much text you can enter, so I figured I would type it up and put the list online, and just give 'em the URL.

Then it occurred to me, other people may want to see the list, and suggest other things to add to it, so ... I'm putting that list here.

Last updated: 2023-11-11

## General

### No information about internals

My biggest issue is probably the fact that they designed the reMarkable tablets with the ability to SSH into it, but then just *stopped*. There is no documentation about what people will find if they do this, or why they might want (or *not* want) to do this. In addition, any time people have asked reMarkable about it, their questions have gone un-answered.

A lot of people, including myself, have *figured out* bits and pieces of how things work. I started a [web site](https://remarkable.jms1.info) where I'm documenting what I'm finding, and others have used this information (not necessarily from *my* site, but the same *kinds* of information) to write their own utilities to manage the tablets, separately from reMarkable's official tools.

**However.** Regardless of what anybody has figured out, there's always the fact that reMarkable could change any or all of it, at any time, without notice. I've spoken (through Reddit) to a few people who have some cool ideas for programs, either on the tablet or on a computer which *talks to* a tablet, but they don't want to spend a bunch of time developing it, only to have it suddenly stop working every time a new firmware version is released.

Having some kind of policy statement from reMarkable about this would help. For example, "this file's format is guaranteed to stay the same for all 3.x firmware versions, but may change in 4.x".

### Limited sleep options

The tablet has an "Auto sleep" function where, if you don't interact with it for 20 minutes, the tablet will put itself to sleep. **The time should be configurable**, either as a list of options (with "one hour" as one of the options), or as an entry field where the user can enter how many minutes (where I would enter `60`.)

### Limited security options

The tablet has a feature which allows you to set a four-digit PIN number to unlock it. **This should be more configurable.**

Ideally it should allow the user to create an arbitrary-length password, and the "correct' password should be stored as a hash (like what *most* Linux machines store in the `/etc/shadow` file) so that if somebody finds a backup, they won't be able to just *read* the password out of the `xochitl.conf` file like they can with the current four-digit PIN.

If that's too hard, then *at least* allow arbitrary length numeric PIN codes - maybe with a *minimum* of four digits, but allow longer numbers. As an example, the code I *currently* use to unlock my phone is ten digits, and at one point in the past it was 17 digits.

## Cloud service

### Required

The software on the tablet seems to have been *designed* around the idea that every tablet would be connected to the cloud service. It doesn't look like a whole lot of thought went into tablets that *don't* connect to the cloud.

* Some people are not ALLOWED to connect to the cloud, because of corporate policy or legal compliance reasons.

    One example of this would be HIPAA, the US law covering privacy of healthcare records. I know it's possible to sign a BAA which would make reMarkable liable in case of a breach due to their cloud systems, but (1) even with a BAA in place I wouldn't want to take that chance with healthcare information in the first place, and (2) there are other reasons, such as lawyer/client confidentiality, which would preclude people from using the cloud service.

* Others, like myself, don't WANT to connect to the cloud.

    In my case, it's because the cloud is hosted with google, who I *absolutely* do not trust at all. Their core business is advertising, and I don't trust them *not* to scan through copies of the sync'ed files from my tablets and use them to build or refine an "advertising profile" against me, or to write their own handwriting recognition program to convert pen strokes to text - again, to feed their ad-targeting database.

This is a problem because some parts of the tablet's functionality require the cloud service.

* The third-party sync functionality with Dropbox, google, and microsoft, was designed to work through the cloud.

    When you create a link to these services, the authentication tokens are held on reMarkable's cloud servers. The tablet itself never talks to these services - when you exchange files with them, the cloud servers are actually doing the work, and the tablet picks up the changes through the sync mechanism it already uses.

    This is definitely a *simpler* design to implement, but it means that reMarkable employees, and anybody who hacks into reMarkable's servers, have access to those authentication tokens, and therefore have access to your accounts on these third-party services. It's possible for them to read, add, delete, or change any files that you have access to on those other services, whether you interact with the files through the reMarkable tablet or not. (I'm not saying that reMarkable employees *would* do this, but ... How often do you read in the news about these "ransomware" jokers selling millions of peoples' data on the "dark web"?)

    The software which talks to these external services *could have been* designed to run directly on the tablet, either by building their clients into the tablet software, or even better, through a documented "plug-in" interface, which would allow others to write file-exchange plug-ins that could also run on the  tablet. In my case I have no interest in Dropbox, google, or microsoft, but I would be VERY interested in using (or maybe writing?) a plug-in to exchange files with [Keybase](https://keybase.io/).)

* The handwriting recognition is performed by a third-party company called [MyScript](https://www.myscript.com/). When you ask for handwriting to be "recognized", the tablet sends the pen-strokes to a reMarkable cloud server, which then forwards the information to MyScript.

    In a way this makes sense. I'm sure reMarkable is *paying* for an API key with MyScript, which it uses for *all* of the handwriting recognition requests from all reMarkable tablets, and they don't want their API key to exist on the tablets where "hackers" like me could find it and use it for handwriting recognition requests from other devices or programs.

    I do wish they had built in an *option* for users to get their own API key from MyScript, and have the tablet send handwriting recognition requests directly to them, but ... to be fair, that would mean two totally different "code paths" for handwriting recognition, which would make the software harder to maintain and support.

* I feel like I'm forgetting something, like there was some other functionality on the tablet which requires the cloud service. If I think of it I'll update this document.

### Not encrypted

(This is the big one.)

**The files stored in the cloud are not encrypted.**. If they were, and the encryption keys were *only* available to the endpoints (tablets, desktop/mobile apps, etc.), it would mean that reMarkable (and google, and random governments or government-*ish* groups around the world who can create "legal orders" of some flavour or another) would not be ABLE to read peoples' documents.

A "master copy" of each account's encryption key could also be stored in the cloud, in a file which is itself encrypted using the user's login password (or even better, using a separate passphrase), so that only people who know the password would be able to access the encryption key to access the files, or to set up a new device on the account.

Encrypting the files in such a way that **nobody** other than the user (including reMarkable, google, intelligence agencies, and random anklebiters who manage to hack into any of their systems) can read the files stored in the cloud, would go a LONG way towards making people like myself, and companies who currently don't allow reMarkable tablets to be used, *trust* the cloud service.


## Tablet software

The software running on the tablets is actually pretty good, but like anything else, there's room for improvement.

I know the tablet was designed around the idea of being a "minimal" experience, with just the minimum functionality needed to simulate writing in a paper notebook, but there are things that I *almost immediately* felt were missing ... and after spending some time on [Reddit](https://www.reddit.com/r/RemarkableTablet/), it's clear to me that I'm not the only person who feels this way.

### Templates

The reMarkable software comes with a collection of "templates", which serve as a "background layer" for each page.

Different people have different needs. In my case, some of these templates are useful (lines, grids, dots, and "blank") but most of the others (sheet music lines, perspective grids for art, storyboards, half-page variants of lines/grids/dots, etc.) are just "taking up space", and there's so many of them that it feels like they're *in the way* when I need to choose the template for a new page.

Also, I have created several "custom templates" that I use every day. I normally use a third-party program called [RCU](http://www.davisr.me/projects/rcu/) to upload my own templates to the tablet, but I also *can* upload them by hand and manually edit the `templates.json` file so `xochitl` knows about them.

**I really wish the tablet had a built-in way to *manage* templates.**

This would include ...

* Adding a way for the built-in web server, and for the "cloud", to handle uploading custom template files.

    This would need to include verifying that the uploaded files *are* valid templates (i.e. 1404x1872 PNG/SVG files), and rejecting invalid uploads (with an *error message* sent to the browser, rather than just silently failing like invalid document uploads do).

* Storing user-supplied template files, and the `templates.json` file itself, under `/home/root/` somewhere, so they don't "disappear" when the firmware is updated.

* Updating the UI on the tablet to allow the user to hide or un-hide the built-in templates, and rename or delete custom templates. (Built-in templates should not be deleted or renamed, only "hidden vs shown" when selecting a template for a page.)

* Allowing the "icon" for each template (shown when choosing a template for a page) to be customized. For some of the templates (graphs, dots, etc.) it makes sense to have a zoomed-in portion of the page, but for others it would make sense to use a miniature version of the entire page. (It may be worth adding a way to upload custom icon files for templates?)

    The current implementation uses a collection of "icons" which is fixed into a custom font file, making it *very* difficult (although probably not impossible, I haven't looked in detail yet) to customize. These should be actual *thumbnail images*, generated on the fly the first time they're needed, and then stored (like you already do with notebook page thumbnail images).

* Providing documentation on what makes a file usable as a template.

    In particular, explain how the "repeating background" thing works for the built-in templates, so that people who design their own templates which *should* logically repeat when a page is extended downward (or to the right), can design them accordingly. Specifically, how does the tablet know how many rows of pixels to repeat at the bottom of the template when "extending" a page downward?

### Splash screens

Everything I said above about templates, also applies to the "splash screens", specifically the following files in the `/usr/share/remarkable/` directory:

* `batteryempty.png`
* `factory.png`
* `overheating.png`
* `poweroff.png`
* `rebooting.png`
* `restart-crashed.png`
* `starting.png`
* `suspended.png`

The software could provide a way for users to upload their own versions of these files, or at least `suspended.png` and `poweroff.png` (again, via the built-in web interface and/or the "cloud").

The documentation should also explain how many pixels to reserve at the bottom of the image to leave room for the "owner information" to be overlaid when the "Personal information" setting is enabled. For my own sleep screen I *guessed* and it worked out okay, but it would have been nice not to *need* to guess.

### Text

The way the tablets handle text right now is ... I don't know any other way to say it, it's *horrible.* It's like whoever designed the feature, figured that every page should be *either* text *or* handwriting, but not both at the same time ... and that text pages should always be laid out exactly the same way.

I don't know for sure what the "right way" to handle text might be. The only times I've dealt with text as part of a GUI was using [gimp](https://gimp.org/) or [Graphic Converter](https://www.lemkesoft.de/en/products/graphicconverter/), both of which treat text as an "object" which exists "above" the canvas, and gets "flattened into" the image when saving the file to an image file which doesn't support "layers".

So my suggestion is this ...

* **Text would be contained in "text objects".**

* Each object would have a font, font size, and alignment setting. All text within the object would use the same font, size, and alignment.

* Text will support modifiers (bold, italic, underline, strike-through, and super/subscript) for character ranges within the text.

* Each object would have its own position on the page, totally independent of other objects or pen strokes.

    In particular, if text objects end up overlapping with each other or with pen strokes, or if a user draws pen strokes "on top of" an existing text object, **that's what the user wants**, so allow it to happen. Don't try to "move text out of the way", or automatically enforce weird margins to try and make text avoid pen strokes or other text objects. People are *going* to want to add text and then manually circle or highlight that text using the stylus.

* Each object's *width* would be resizable. The height would be automatic, based on how much text is *in* the object. Each object would have a minimum height of one line of text, based on the object's font size.

* If an existing text object is resized, the text within the object would automatically "re-flow" to use the new area of the object. If an object contains more text than the size of the object, the object's height would be adjusted accordingly. (And if this adjustment makes it necessary to extend the lower edge of the page, the page would be adjusted as well.)

* Each object can *optionally* be drawn with a border, and with "padding" between the border and the text. The user should be able to select whether a border is used or not, and if so, adjust the colour and width of the border, the line style (i.e. solid line, dashes, dots, etc.), the corner style (sharp corner, curved corner, etc.) and the amount of padding between the border and the text.

### Drawing tools

Tools to draw simple shapes would be *awesome*. This would include things like circles/ellipses, squares/rectangles, and generic polygons. The shapes could be solid (filled) or empty (outline only).

Also, maybe a setting of some kind that, if enabled, would ensure that all lines are either "always straight", or "always straight *and* aligned with the nearest 45&#xB0; angle". (This would only affect lines above a certain length, to preclude interfering with normal handwriting.) I'm not sure if this is already happening in the 3.8.2 release or not, but if so, that's something you could have mentioned in the release notes.

And, a "fill" tool that would flood an area with "ink".

### Image support

It would be nice if the tablet had a way to handle images - maybe as "image objects", similar to the "text objects" I suggested above, which would contain a raster image.

Images could be created by allowing images to be selected and copied from existing documents, either "from the current layer only", or "from all visible layers", and then pasted as a new "image object". If a user needs to upload an image, they can use a PDF and then copy/paste the image *from* the PDF.

Once pasted into a page, image objects could be moved and resized. There would be a setting where the user can choose either allow or not allow the aspect ratio to be changed while resizing.

Image objects, text objects, and pen strokes should be allowed to freely overlap with each other. Don't try to move things around to avoid this, trust the user to know what they want to do.

Ideally, images should support transparency. This means *real* transparency, not "faking it". In particualr, white pixels should "cover up" whatever is "below" it with white, like the eraser tool used to do before 3.8.0.

### Interoperability

I've been advocating for open-source software for over twenty years now. reMarkable built these tablets on a foundation of Linux and other open-source software, I think it would have only been fair if they had designed things to be as "open" as possible, including *documented* mechanisms to operate in conjunction with other software.

A few examples ...

* They could have implemented third-party upload/download functionality on the tablet itself, using a "plug-in" mechanism that allows new services to be added *without* a full operating system update, using a *documented* API that would allow people to write their own plug-ins to work with other file storage services.

    They could have included plug-ins for standard services like SMB, NFS, WebDAV, and `sshfs`, so people could upload/download files to local file servers at their home/office.

    Adding this now would be a *huge* effort. I'm not pushing for this, I'm just saying that I wish it had been designed this way to begin with.

* They could have added a signal handler, or maybe an API server listening on `http://127.0.0.1:nnn/`, so other processes *on the tablet* could tell the software to re-scan its file storage after documents (or templates) are added, deleted, or modified.

    This actually wouldn't be a *huge* effort to add in now, especially if it's just a signal handler. If I had access to (and was familiar with) the source code I could probably have a pull request ready in a day or two for the signal handler idea, or maybe a week or two for the API server idea (which could later be used to support other operations as well). `#justsayin`

* They could *publish* the API used by the cloud service, and commit to not making any breaking changes to it. This would make it easier to write programs with interact with the cloud, and it would also make it easier to write things like [rmfakecloud](https://github.com/ddvk/rmfakecloud), which can provide the same "cloud" functionality, so that companies (and people) don't have to worry about their data leaving their own systems.

    This would require the tablet to have a new configuration item for "sync server hostname", but otherwise the end user experience would be the same.

Don't get me wrong, I realize that the way they're doing it is perfectly *legal* according to the various software licenses involved. I have no reason to believe that the reMarkable is violating any licenses, that's not what I'm saying at all.

What I *am* saying is ... it seems like such a *waste*. There are *so many things* that people *could be* doing with these tablets, if reMarkable had designed some "hooks" into the software to *allow* other programs to "play nice" with it. Obviously they can put a bunch of disclaimers on their web site (and on the tablet) saying that they don't provide support beyond a certain point, and maybe even make the user tap an "I agree" button on the tablet before showing them the root password for the first time.

But the community, probably the *existing* community, would end up helping each other out and "providing support" for people who want to customize things.

### Actually ...

While I was writing the section above, it occurred to me that reMarkable *could* also release their own "private cloud server" program, that a company could run on a Linux server in their own datacenter (or a person like me, in their home or on a VPS). Customers could use this to ensure that their tablets' data would never leave their network, which could bring in more tablet sales from people who like the idea but can't allow their data to leave systems under their own control.

Handwriting recognition would be an issue. The customer could ...

* Get their own API key with MyScript
* reMarkable could include an API key as part of a paid service contract
* Configure the server to not perform handwriting recognition at all

I would suggest making the program itself free, and charging a subscription based on how many tablets are sync'ing against it, with the first one or two tablets for free. Pricing should be lower than the reMarkable Connect service offering, since the customer would be providing the resources that the "cloud" runs on.

This could also open a new revenue stream, selling support contracts for these private servers. (My "finders fee" for the idea would be one lifetime server license with unlimited tablets, with the agreement that I won't be selling it as a service.)

## Updates

The "official" mechanism works by "just waiting for the update to show up". This might work for some people, but **some users want or need to control when the firmware on THE TABLET THEY OWN is updated**.

Under the covers, the actual filenames containing the firmware updates appear to be deliberately obfuscated, most likely to prevent people from being able to manually download the files and use third-party software like [remarkable-update](https://github.com/ddvk/remarkable-update) to install them on their tablets.

**People who are *inclined* to manually install firmware updates, are generally *able* to do so.**

Especially if there's a simple and *documented* way to do so, such as using `scp` to upload the firmware file, then running a command like "`install-firmware FILENAME`" on the tablet.

**PLEASE stop hiding the firmware update files.**

If something about the current software *requires* the non-predictable portion of the filename, then publish a web page with the filenames and download links, and keep it updated whenever new releases, normal *or* beta, are released.

## Support

I haven't had to interact with reMarkable's support people very much. When I have, the *people* are always polite and professional, but I haven't always been able to get a good answer.

To be honest, I tend to have this problem just about every time I need to contact a company's "tech support" department. I've been programming computers since 1981, and I used to build and run ISPs for a living. In many cases I already know *what* the problem is, and just don't have *access* to fix it myself.

### No escalation (?)

Most companies have a way to escalate questions to a "senior" person, and then if necessary, to an "engineer" of some kind. As examples, my ISP, my credit union, and a global computer company who I'm not allowed to identify, have all given me alternate contact methods which bypass the normal support queues, after realizing that I'm never going to call with something simple. (The real trick is, I know how to *do my own troubleshooting* before calling "tech support".)

The impression I've gotten about reMarkable is ...

* Their support people seem to have a collection of canned responses they're supposed to use.

    For most users this may be okay, but I'm not "most users".

* Either they don't *have* a way to escalate issues, or they're under orders to avoid using it.

    It would be nice if there were a way for users with "more advanced" questions to talk with somebody who can provide "more advanced" answers, rather than just "that's all we can tell you, have a nice day".

To be fair, part of my opinion here is based on what other people have described on [Reddit](https://www.reddit.com/r/RemarkableTablet/). I've only ever had to contact reMarkable support twice, with the second time being to let them know that something on one of their support web pages was wrong (see below).

Hopefully they *do* have a way to escalate calls, and I've just never had a reason to find out.

### Answering the wrong question

On 2023-11-08 I [sent in a report](https://support.remarkable.com/s/contactsupport) about [this page on the `support.remarkable.com` web site](https://support.remarkable.com/s/article/Move-files-and-pages) , which at the time was giving out incorrect information (that pages could be freely moved between PDFs, EPUBs, and regular notebooks).

The first response I received tried to explain how to do *something or other* with the Text tool (which I don't use, and *certainly* didn't ask about), and then included a link to a support page explaining how "gestures" work (which I already know, and *also* didn't ask about). Nothing about the response had anything to do with my original report.

I responded and *repeated* the original problem. I didn't hear back from that, but when I looked today (2023-11-11) the page had been *updated*. However, I feel like there's still room for improvement.

Right now the page says ...

> Tapping Move in a notebook will allow you to either move pages within that notebook, or from one notebook to another. In PDFs or ebooks, you can move **note pages** within the document or into an existing notebook.

*(Emphasis on "note pages" is mine)*

I think the page should clarify that the term "note pages" refers to extra blank pages that people can add to PDF/EPUB files, for the purpose of adding their own notes. It should also plainly state that pages which originally *came from* a PDF or EPUB file, cannot be moved to other documents.
