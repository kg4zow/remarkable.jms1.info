# Definitions

While reading other pages about the reMarkable tablets, I've noticed that some words seem to mean different things to different people.

I think it may be helpful for me to write down some of these terms, what **I think** they mean, and what they mean when you see them on this web site.

## Notebooks

**A notebook is a collection of pages**. I've also seen them called "native notebooks", "documents", or "files". This is the digital version of a paper notebook.

The pages within a notebook are an "ordered set", meaning they exist in a specific order (i.e. page 1, page 2, page 3, and so on). This is *normally* the order in which the pages are created, however you can re-arrange them in whatever order you like.

Internally, each notebook is stored as a collection of files. The file structure is explained in more detail on the [Filesystem](info/filesystem.md) page.

### Pages

**Pages are the individual surfaces that you write or draw your notes on.** This is the digital version of a sheet of paper.

Each page has two or more "layers". Layers are logically ordered from the "bottom" to the "top". When you're looking at a page on the screen, you're seeing the contents of all of the layers "stacked" on top of each other. It draws the layers "from the bottom up", so things on a higher layer will "cover up" things on lower layers.

The "lowest" layer of each page contains a **template**. You cannot change the *contents* of a template, however you can change *which* template is used for each page.

The things you write or draw with the stylus are stored as a series of pen strokes. You may also see these referred to as lines or strokes. Each layer's pen strokes are stored separately.

### Templates

**A template is an image file used in conjunction with a page in a notebook.** This is the digital version of the lines on graph paper, the dots on dotted paper, the lines and words on a "form" that you fill out, or in general, the pre-printed elements on any page which doesn't start off totally blank.

The reMarkable software comes with a collection of templates, which can be used on any page in a notebook. The reMarkable template files have both PNG and SVG versions.

The reMarkable software doesn't offer any way to upload your own templates, however you *can* use SSH (or a utility like RCU which *uses* SSH) to upload your own template files into the tablet and make the reMarkable software use them.

The [Templates](templates/) section of this web site has more information about how to do this, as well as some simple templates that I've designed for myself. (Fair warning, I'm a computer programmer, not a graphic designer, so don't expect anything super-pretty.)

### Cover Pages

**A cover page is "Page 1" in a notebook whose "Notebook cover" setting is set to "First page".**

Some people like to make custom cover pages for their notebooks. I do this by making a template which looks like a book cover, with a space in the middle where I can draw or write the title of that notebook. It looks like this:

![cover-simple.png](../templates/cover-simple-sm.png)

The [Simple Cover Page](../templates/cover-page.md) page has more information about this, and includes the script I used to create the template image.

### Quick Sheets

**A "Quick sheet" is a page in a notebook called "Quick sheets".**

The reMarkable tablet's "file browser" has a "&#x2295; Quick sheets" link at the top of every screen. Tapping this link will ...

* Create a notebook called "Quick sheets", in the "My files" root directory in the tablet's folder structure, if it doesn't already exist.

* Create a new page at the end of this notebook.

* Open that page, ready for you to start writing.

The idea is, if you just need to quickly write something down, you can put it on a quick sheet and then later move that page to the notebook where it belongs.

The "Quick sheets" notebook is *just like any other notebook*, except that ...

* The "file browser" will not allow the user to rename, move, or delete the notebook.

* The reMarkable software's "&#x2295; Quick sheets" link is hard-coded to use it.

## PDF and EPUB Files

The reMarkable tablets allow you to upload PDF and EPUB files, and will show them on the screen like a big "book reader" device, with the added bonus that you can make your own annotations *on top of* the original file.

This is actually one of the reasons I bought my tablet in the first place. In addition to taking notes all day long for work, I sometimes use it as a "book reader", especially for PDF files formatted for US 8&#xBD;"x11" paper (or A4, for the rest of the world), and therefore don't "look right" on a smaller screen like an iPhone, or the [Kobo Libra 2](https://us.kobobooks.com/products/kobo-libra-2) I read while falling asleep (*also* without connecting it to their cloud service).

### PDF vs EPUB

The reMarkable tablet treats PDF and EPUB files similarly, however the files are very different.

* **PDF files contain pages.** Each papge may include a list of directions like "draw a line from coordinates (100,500) to (250,800)" or "draw the text 'Hello' in a box from coordinates (850,400) to (950,450)". The location of each "thing" (line, image, letter, etc.) on the page is contained in the PDF file itself, so they can't move. If a page was designed for 8&#xBD;"x11" paper and you look at it on a smaller screen, you would see a blown-up version of one *part* of the page.

    Many people who create PDF files, do so *because* it locks the position, size, and appearance of the elements on the page. For example, a calendar wouldn't be very useful if the numbers in each box were positioned anywhere else on the page.

* **EPUB files contain text.** They include instructions on how to *format* the text (i.e. this word should be italicized, these words should be bold, and so forth), however **they do not dictate *where* the words should appear** on the page ... or have anything to do with "pages" at all.

    The location of the text is controlled by the program or device which displays the text. This allows the text to be shown on different sized screens, using different fonts and font sizes, and "flowed" around images or other elements which may need to be shown along with the text.

I'm not going to claim that either format is inherently "better" than the other. They are both useful, but **they are meant for different purposes**.

The tablet presents the document as a series of pages, organized to make it *look like* a notebook. The contents of each page are used as a "bottom layer", similar to how notebooks use templates. One or more drawing layers are added above it, to hold the pen strokes for whatever annotations you might make on that page.

**This means that you cannot change the "templates" for pages in a PDF file.** Even if you "insert a blank page" in the file for taking notes, the reMarkable software won't allow you to choose a template for that page - you get a blank page and that's it.

> &#x2139;&#xFE0F; **When an EPUB file is uploaded to a reMarkable tablet, the tablet generates a PDF file internally.**
>
> The original EPUB file is kept, however it looks like once the internal PDF file is generated, the PDF version is what the software actually uses when showing the file on the display.

> &#x26A0;&#xFE0F; **This EPUB-to-PDF conversion process is not perfect**, at least not in reMarkable firmware 3.0.5.56. So far I've found two different books where the original EPUB file has pictures in certain places, and those pictures are missing when I look at the book on the tablet, and they're missing from the generated PDF file in the tablet.
>
> So for now, my plan for EPUBs is to use [Calibre](https://calibre-ebook.com/) to convert them to PDF, and transfer the resulting PDFs to my reMarkable tablet.

## PDF vs Template

This is probably the single biggest point of confusion I've seen. A lot of people use the term "template" when talking about a PDF file, or talk about "using a PDF *as* a template".

**PDFs and templates are NOT the same thing.** The main differences are ...

* Templates can be assigned to individual pages *within a notebook*.

* Templates *cannot* be assigned to pages within a PDF file. Even if you insert a blank page in a PDF document (to write your own notes), you cannot assign a template to the page.

I don't have a dictionary in front of me, but part of the meaning of the word "template" is that it's reusable. In this case, it means that it can be re-used for as many notebook pages as you like. If you're using a PDF file to simulate a template, the only way to use that "PDF template" more than once is to duplicate the original PDF.

### Example

For work, I keep a notebook for every month, where I write down the things I work on each day. I sometimes also add pages for different tickets, usually right after the "daily list" for the day when I work on them.

If I wanted to use a PDF for this, I would need to generate a new PDF for every month, and I would only be able to add *blank* pages between the "daily" pages.

Because I'm using templates, I am able to organize the notebook the way that works for me. What I do is ...

* At the beginning of each month, I create a new notebook, assign a "cover page" template for page 1 and write in the month/year. Then I add a page, assign a "calendar" template for page 2, and write in the numbers.

* Every morning I add a new page to the notebook, assign the "daily work" template to that page, and start writing things down.

* If I need one or more "extra" pages for that day, I add them after the current "daily" page, and use whatever template makes sense for each of those pages. Sometimes I use what I call the "Basic Page" template, sometimes "Lined medium", sometimes "Dots S", sometimes "Blank" ... whatever makes sense for the information I need to write.

* Most days I'll add an extra page at the end to use as "scratch paper" (for things I need to write down for a few minutes, but I know I'm not going to need permanently), then delete the page when I no longer need it.

Using templates allows me to use whatever "form" I need for each page in the notebook, without having to know exactly which "form" is going to be needed ahead of time (i.e. while creating a PDF on a computer).

### The *correct* use of the word "Template"

It's up to you how you want to use the word "template".

* I think of it a *specific* term, referring to an image that can be used as the background for pages in reMarkable notebooks, and which can only be updated using SSH (or a third-party utility like RCU which *uses* SSH).


* Others may think of it in the *generic* sense, referring to a "background" that you can write over. A PDF file *can* be thought of in this way.

    When you see the word "template" on this web site, this is what I'm referring to.

I'm not going to insist that others stick to my terminology. All I ask is ...

* When you see the word "template" *on this web site*, or if you're talking to me and I *use* the word, be aware that I mean it in the specific sense explained above.

* If you're talking with me and *you* use the word "template", please be very clear about which sense of the word you mean.

## Static Screens

The reMarkable software comes with several images which are shown for special purposes.

The one most people want to change is `suspended.png`, aka the "**Sleep screen**". This is shown when the tablet is sleeping. The `suspended.png` file in the reMarkable firmware is an almost empty page with this in the middle.

![suspended-sm.png](images/suspended-sm.png)

These screens can be replaced by uploading a new file with the same filename as the one you want to replace.

These files are covered in more detail on the [Filesystem](../info/filesystem.md#static-screens) page.
