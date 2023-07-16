# Information

Background info about the tablet as a whole

## Other Sources of Information

I'm not trying to make this site into "the ultimate reMarkable reference site" or anything like that. I don't have the time for that, plus there are already several other sites like that out there.

Some of those other sites are ...

- [`remarkable.com`](https://remarkable.com/) - reMarkable AS's official home page, and where to go to purchase a reMarkable tablet from them.

- [`github.com/reMarkable/`](https://github.com/reMarkable/) - contains a collection of reMarkable's public source code, including their custom version of the Linux kernel.

- [awesome-reMarkable](https://github.com/reHackable/awesome-reMarkable) - List of "hacks" (which seems to be the term people use for making the tablet do anything other than run the built-in software), programs, and other information that people have written for/about the reMarkable tablets.

- [reMarkableWiki](https://remarkablewiki.com/) - Wiki site with links and info about the reMarkable tablets.

## Things to Investigate

- **[ReCalendar](https://recalendar.me/)** - Browser-based calendar generator, creates PDFs containing "day planner" pages. All work happens in the browser, nothing gets uploaded anywhere.

    It's a cool idea, and from a privacy standpoint I like the fact that it doesn't upload any information anywhere. It's just not something that I personally need.

- **[RCU, reMarkable Connection Utility](http://www.davisr.me/projects/rcu/)** - this is a GUI for managing the RM1/RM2 tablets. I'm using this to manage my own tablet.

    &#x21D2; [RCU](rcu.md)

- **Templates** are like "background images" for notebook pages, providing a guide for where to write things on the page. The tablet comes with a collection of them, including blank, lined paper, graph paper, "dot" paper, musical staves, and pre-made forms for different organizational schemes.

    It is possible to make your own templates (they're just `.png` images), the tricky part is loading them into the tablet and making the reMarkable software use them. Luckily, the details of how to do this were figured out long ago, and as a long-time Linux user, it was actaully pretty easy to do.

    &#x21D2; [Templates](../templates/)

## Wish List

### Tablet software

- Better (or *any*?) support for tablets which don't synchronize with the cloud service.

    - Desktop Manager that works over SSH (RCU is good)

- Rename pages within a notebook ... pages could have titles like "Table of Contents", "Chapter 1", that kind of thing. Page titles should be search-able.

- File manager

    - Sorting options (new-to-old, old-to-new, alpha, etc.)

    - Sort order stored for each folder, i.e. for some directories I want alpha, for work/notes I want new-to-old, etc.

- Software Updates

    - Allow the user to control *when* their tablet updates, other than a single "yes or not" switch.

        This means several things:

        - Show the user a LIST of available updates, and provide a clear list of what changes are made by each update. This should include a list of bugs fixed by each update, as well as any changes which would make it impossible to "downgrade" after a certain upgrade is installed (due to things like internal data format changes, where no process exists to reverse the change.)

        - **Provide an "install now" button**, rather than leaving it up to random chance when the tablet, or the cloud, decides when to update.

        - Let the user decide which update(s) they want to install. Specifically, this means that if a tablet is "three versions behind", allow the user to choose which of the three updates they want to install.

            If this is unwise because of known security issues with one of the versions, *say that* in the output and don't allow the user to choose that one, but *still show* the versions, so the user has a full list of updates and bug fixes between the version they're on now, and the version they're about to update to.

    - Provide an official way to download and install firmware updates without wifi.

        Also provide an official archive of past firmware versions. Ideally this should include ALL versions, even those with known security issues (with notes saying "security issue XXX exists" and links to pages explaining each issue), even if the built-in upgrade process doesn't allow upgrading to that particular version.

        I say this because there *are* a few users who may legitimately need to install these versions, if only to research how to support their *own* programs running on these versions of the firmware.

- Show ALL available options.

    This includes showing things like the "automatically download and install firmware updates" setting (which I have never seen, because my tablet has never been connected to a wifi network). **All settings which *exist* should be visible**, even if they won't *do* anything. If it doesn't make sense to change a certain setting, add a note below that setting's title explaining why not, but sill *allow* the user to turn it on and off anyway.

    The overall idea is, the user paid the money, they *own* the hardware, they should be able to fully control it. If this includes turning on/off a switch which doesn't *do* anything, *explain* that it won't do anything, but let them do it anyway. It doesn't affect reMarkable at all, and it allows users like me to make sure that the settings are how we want them, *before* going online for the first time.

- TEXT HANDLING

    The way the tablet currently handles text (as of firmware 3.0.5.56) is *horrible*. I can *sorta* see the logic in wanting "typed" text to automatically "flow" around lines that the user has drawn, but ... that isn't something I would need or want on every single page.

    For a lot of my notes, I'd like to be able to *type* a "title" at the top of the page, and use handwriting (not "recognized", just a bag of lines) for the rest of the page ... but the software doesn't seem to allow you to position "real text" at the very top of the screen (i.e. the first 120 pixels at the top of the page, where a "title" would go), even though you can draw there with the stylus.

    I'm *hoping* this has improved in later firmware versions, if so it would be the first real reason I've found to *want* to upgrade.

- Add Keybase as a file-sync service. &#x21D2; [Keybase](https://keybase.io/)

    Even better (and I know this is a "pipe dream") ... use Keybase as the "backing store" for the cloud-sync process. Users would be able to access their own files, but nobody else - not google, not reMarkable, and not anybody who hacks into those companies' systems - would be able to.

### reMarkable web site

- More detail about the different connectivity "levels"
    - Never connected to any network at all
        - obviously no data is sent anywhere
        - no NTP, and the GUI provides no way to set the clock, so timestamps on files will not be accurate
            - my own tablet was about three minutes "fast" when I took it out of the box, SSH'd in and used `date` command, then `hwclock -w` to "save" it
        - "deleted" files are not really deleted
        - telemetry files build up forever
    - Wifi but no cloud
        - NTP - ???
            - if not, what *is* the expected mechanism to keep the tablet's clock in sync with the real world?
        - are "deleted" files actually deleted?
        - are telemetry files sent anywhere?
    - Cloud but no paid service
        - [reMarkable web site](https://support.remarkable.com/s/article/Using-reMarkable-without-a-subscription) description
        - current info is okay, but it reads like advertising copy for the paid service
        - more detail about the "50 days" thing
            - scope: does the 50-day limit apply to entire notebooks, or to individual *pages* within notebooks? (i.e. if somebody has a "daily journal" notebook with new pages every day, will the older *pages* stop sync'ing?)
            - which actions reset the 50-day timer? (people have resorted to manually duplicating notebooks to make it start sync'ing again, would adding a line to a page be enough to make it start sync'ing again?)
            - if a note *was* over the 50-day limit but then the user edits the note, does that note start sync'ing again?
    - Paid service
        - again, a lot of it reads like ad copy

- Make it plain that handwriting recognition is cloud-based and done by a third party, and that it's only available with the paid service (because the third party charges reMarkable AS for each query).

## Privacy

From everything I'm seeing, it looks like reMarkable designed the software around the idea that every tablet will be connected to their "cloud", which is physically stored in google's cloud, in Europe.

According to [their web site](https://support.remarkable.com/s/article/How-is-content-secured-in-the-cloud), users' data is stored in google's cloud, encrypted using keys which are managed by google. **This means that google holds the keys, and is able to decrypt the files, read/analyze them, and feed the results into their advertising engine.** This includes running their own OCR (optical character recognition, aka "convert handwriting to text") against hand-written notes.

Think about that for a minute. If you have a *free* cloud account, YOU won't be able to convert your hand-written notes to text, but google can.

I HATE the thought of an outside company, *especially* the world's biggest advertising company, being able to read my files, regardless of whether there's anything private in them or not, so for now I'm not planning to connect to their cloud.

**This may change.** I don't have anything super-secret in my notes, and as much as I hate to sound defeatist, the truth is that google is going to try and show me ads either way, and I'm going to continue to block them either way. **For now**, I want to continue figuring out just how much I *can* do to maintain my privacy.

### HIPAA

Another factor is, `$DAYJOB` is with a US-based company in the healthcare industry. It doesn't happen very often, but in my own job I *do* occasionally come across information which is protected by HIPAA (the US law protecting privacy of healthcare information). I try as hard as I can to avoid coming in contact with this kind of information, and I have no interest in *keeping* any of it, especially on a reMarkable tablet, however it is something I'm supposed to keep in the back of my mind all the time.

However, some of the people I work with are exposed to PHI (protected health information) every day. If *they* were using a reMarkable tablet to replace paper notebooks, it's possible that *they* might need to write down somebody's PHI, even if it's just temporarily. And it's possible that that information could be sync'ed up to the reMarkable cloud.

According to [reMarkable's web site](https://support.remarkable.com/s/article/Is-reMarkable-subject-to-privacy-legislation), reMarkable is willing to execute a Business Associate Agreement with a user. This agreement makes them liable in case of a data breach which is tracked back to a problem on reMarkable's part (such as, the fact that users' files in the reMarkable cloud can be ready by reMarkable employees, google employees, and anybody who manages to "hack into" either company's systems.)

The fact that they are willing to sign these agreements, makes me feel a *little* bit better about using their cloud service. (Still not totally confident about it, but not immediately *against* it either.)

### GDPR

reMarkable AS is a European company, so they are required to follow GDPR rules as well. I live in the US so I'm not *as* familiar with GDPR's rules, but according to an email that I got back from reMarkable support when I asked them about this ...

> Our device and services have not been specifically designed to be HIPAA compliant, but we do comply with the GDPR which in our understanding is at least as strict as HIPAA regulations.
>
> If you are a customer using our Cloud Service, and you need a Business Associate Agreement pursuant to the HIPAA regulation in the US, you may download our standard Business Associate Agreement that is available through our terms and conditions [https://support.remarkable.com/s/article/Terms-and-Conditions-for-Connect](https://support.remarkable.com/s/article/Terms-and-Conditions-for-Connect) The Business Associate Agreement becomes legally binding if and when you return a fully executed version to privacy@remarkable.com.
>
> Please also note that you may have full control over the processing of content by deactivating the cloud service, although it, unfortunately, means that you lose some functionality such as handwriting conversion. You can find more information on how to transfer files by using the USB cable here [https://support.remarkable.com/s/article/Transferring-files-using-a-USB-cable](https://support.remarkable.com/s/article/Transferring-files-using-a-USB-cable).

The GDPR governs EU companies (such as reMarkable AS) regardless of whether the data subject (myself, or a potential patient whose PHI somehow ended up being stored in my tablet) is in the EU or not, so ... there's that.

### Summary

My own concerns have more to do with the privacy of my own information, and the ability of others to use that information for their own benefit, without my knowledge, permissions, or ability to also benefit from it.

I don't see myself ever storing PHI, even my own, in a reMarkable tablet anyway, so I doubt HIPAA/GDPR would ever be an issue for me to begin with. I just feel like, whatever steps reMarkable is taking to follow the rules about HIPAA/GDPR, probably also fall under the category of "good security" to start with - especially GDPR (since HIPAA is limited to healthcare-related information).

**My biggest concern is the fact that google is holding the encryption keys for the data-at-rest.** If it isn't obvious, I don't trust google at all. (I also don't trust amazon or microsoft, so changing cloud providers wouldn't help things any.)
