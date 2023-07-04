# Information

From everything I'm seeing, it looks like reMarkable only enables certain functionality when the tablet is connected to their "cloud", which is physically stored in Google's cloud. To me, the thought of an outside company,

## Other Sources of Information

- [`remarkable.com`](https://remarkable.com/) - official home page

- [reMarkableWiki](https://remarkablewiki.com/) - "wiki" site full of links and info about the reMarkable tablets

- [awesome-reMarkable](https://github.com/reHackable/awesome-reMarkable) - list of "hacks" (which seems to be the term people use for making the tablet do anything other than run the built-in software). I found almost everything in the [hacks](../hacks/index.md) section from this page.

- [Github](https://github.com/reMarkable/) - contains a collection of reMarkable AG's public source code, including their custom versions of the Linux kernel.

## Things to Investigate

- [RCU](http://www.davisr.me/projects/rcu/) reMarkable Connection Utility - looks like a GUI for managing the RM1/RM2 tablets.

- [ReCalendar](https://recalendar.me/) - browser-base calendar generator ... generates a PDF containing "day planner" pages ... all work happens in the browser, nothing is uploaded anywhere

    I've seen the word "template" thrown around, not sur if this means the PDF is copied when creating a new (note? file? page?) or if it's used as a "background" and the user's content exist in a layer "above" that, or ... ?

## Wish List

Tablet software

- desktop manager that works over SSH, to allow management without the cloud

- rename pages within a notebook ... "Page 1"

- file manager - sorting options (new-to-old, old-to-new, alpha, etc.) ... stored for each folder (for references I want alpha, for work/notes I want new-to-old, etc.)

- allow download/install firmware updates without wifi

reMarkable web site

- explain connectivity "levels"
    - never connected at all
    - wifi but no cloud
    - cloud but no paid service
    - paid service

- make it plain that handwriting recognition is cloud-based
