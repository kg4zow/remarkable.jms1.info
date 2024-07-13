# Calendar PDF script

This script creates a PDF file whose pages can be any of ...

* A calendar for a year
* A calendar for a month
* A page for a single day, in a similar format to the "daily-work" template shown on the [Basic Templates](../templates/basic.md) page.

I also figured out how to set up "links" from one page to another. The calendars on the various pages all link to the appropriate day, month, or year page, if that day/month/year *has* a page within the file.

> One thing that I wish I had known before spending several *days* trying to figure out is that, in the terminology used within PDF files, **"annotations" are links**, and they can jump to other pages (or specific *parts* of pages) within the same PDF, other PDF files, or URLs on the internet.

## Script

&#x21D2; Github - [kg4zow/rm2-scripts](https://github.com/kg4zow/rm2-scripts/tree/main/rm2-cal)

The `README.md` file in Github has more information, and the repo also has sample PDF files which were generated using `rm2-cal`.

## Future

* *Maybe* also a "weekly" page of some kind? I personally don't have any need for this, but it seems like something others might need, and it might be fun to write.

* *Maybe* have a way to add notes within the PDF for specific days. This could be useful for labelling holidays or birthdays, or if somebody is using this for work, adding reminders for recurring meetings.

