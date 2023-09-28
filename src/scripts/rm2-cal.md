# Calendar PDF script

This is a script that I'm *working on*, for now called `rm2-cal` but subject to change, which creates a PDF file whose pages can be any of ...

* A calendar for a year (working)

* A calendar for a month (working, but I need to adjust the formatting)

* Some kind of "day planner" type page for a day (not started yet, I need to decide what these "daily" pages should look like.)

* *Maybe* also a "weekly" page of some kind? I personally don't have any need for this, but it seems like something others might need, and it might be fun to write.

* *Maybe* have a way to add notes within the PDF for specific days. This could be useful for labelling holidays or birthdays, or if somebody is using this for work, adding reminders for recurring meetings. (This is more of a "version 2" kinda thing.)

Also, last night I figured out how to set up "links" from one page to another. At the moment (2023-09-28) it's just the one link - if you're looking at a "year" page and tap on the name of a month, if that month also *has* a page in the same PDF it will jump to that page directly.

> One thing that I wish I had known before spending several *days* trying to figure out is that, in the terminology used within PDF files, **"annotations" are links**, and they can jump to other pages (or specific *parts* of pages) within the same PDF, other PDF files, or URLs on the internet.

Because of this, I need to go back and re-visit how and where to add links on the year and month pages -
