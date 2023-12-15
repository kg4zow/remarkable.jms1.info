# File Types

I've seen a few different mis-conceptions about the file types used on the reMarkable tablets.

# Templates

The word "template" has a couple of different meaning.

In general, the word refers to a "page layout" which can be re-used. For example, the paper form you might fill out to apply for a drivers license is a kind of template. Each finished form has a different person's information on it, but they all have the same layout - each person's name, address, date of birth, and other information are all in the same place on the form.

## "Real" Templates

**On reMarkable tablets**, the word "template" specifically refers to a "background image" which can be used with pages in a notebook. The OS comes with several dozen templates built in, everything from basic lines and dots up to sheet music, day planner pages, and perspective guides used when drawing.

The reMarkable software doesn't offer a way to add your own templates, however you *can* do this using SSH. Many people (myself included) prefer to use a third-party program like [RCU](http://www.davisr.me/projects/rcu/) to do this.

### `.png` and `.svg` files

Technically, a template is a 1404x1872 pixel PNG or SVG image. The templates that come with the reMarkable OS come in both formats. The first templates I uploaded by hand were in PNG format only, and the reMarkable software used them without any problem. When I later uploaded my templates using RCU, it created SVG versions of them and uploaded both formats.

> I don't know for sure, but I *think* the SVG files are used to repeat a pattern when "extending" a template on an "infinite scrolling" notebook page.

## PDF files as Templates

I've seen a lot of people use the word "template" when talking about a PDF file.

While this might fit the dictionary's definition of the word, it can be confusing because using PDF files in this manner involves a totally different set of workflows than using "real" templates.

* In a PDF file, you cannot assign a template (a "real" template) to a page, because the content from the underlying PDF page *is* the template for that page.

* If you want to use the same "template" on multiple pages, either the PDF needs to have the correct "templates" for each page before you upload it to the tablet, or you have to create duplicate pages within the PDF.

* If you want to use the same PDF as the "template" for multiple documents, you have to create multiple copies of the document containing the PDF. If you didn't create a "master copy" when you uploaded the PDF, this means copying an existing document and erasing the pen strokes on every page in the copy before you can use it.

Using PDFs in this way can be useful. A common example is a "day planner" file, with pre-made pages for every day, week, or month. You can make PDFs whose pages have "links" to other pages, so if you're looking at a monthly calendar and tap on the 15th, it will jump directly to the page for the 15th rather than having to scroll through pages or use the "page selector" tool.

However, if all you need is a "template", it's usually better to stick with real templates, since they can be assigned to as many pages as you like, and the UI to do this is built into the reMarkable software.

## `.rmt` files (RCU)

If you're using [RCU](http://www.davisr.me/projects/rcu/), you can download templates as `.rmt` files. The computer won't be able to do much with these files, but you can use RCU to upload them back to the tablet (or to a different tablet.)

The file itself is an "archive" containing the `.png` and/or `.svg` files, along with a `.json` file containing the template's metadata (display name, selected categories, and selected "icon").

You can use a command like "`tar tvf xxx.rmt`" to see the contents of the archive.

## Documents

A "document" is a collection of pages that you can write on. reMarkable tablets have two major types of document: notebooks and PDFs.

Each document is stored as a *set* of files within the tablet. The names and structures of thes files are explained on the [Filesystem](../info/filesystem.md) page.

### Notebook

A "notebook" is a document created on a reMarkable tablet. It has no content other than the text or pen strokes added by the user.

Each page in a notebook has its own template, selected from the list of templates in the tablet.

Pages in a notebook can be added, duplicated, re-ordered, and deleted as needed.

### PDF files

When you upload a PDF file, the tablet creates a document "around" that PDF. The original PDF file is held in the tablet, un-modified, and any pen strokes you add "on top of" those pages are stored in the same pen-stroke files used for regular notebooks.

The big difference is that the contents of each PDF page are used as the templates for each page in the document. When you're "reading" a PDF on the tablet, you're actually looking at a collection of blank pages (i.e. no pen strokes) with the PDF contents as the template "underneath" each page. This is how you're able to write "on top of" a PDF file.

As with other documents, pages can be duplicated and re-ordered, and the template (the PDF content) for each page "follows" the pages as you would expect. However, if you *add* a new page to the document, the new page won't have a template - it'll just have a blank background, and (as of the 3.8.2 software) the reMarkable software won't allow you to choose a normal template for those "added" pages.

### EPUB files

When you upload an EPUB file, the tablet converts it to a PDF. When you're working with the document on the screen, you're actually working with the PDF, and everything mentioned above about the features and limitations of PDF files will apply.

#### Re-formatting

The tablet provides a way to change the formatting of EPUB files (i.e. the font, font size, margins, etc.) When you do this, the tablet generates a *new* PDF.

When the new PDF is generated, the content of each page may change. Text from the EPUB file may end up being moved to entirely different pages, especially if you make the text larger or smaller.

**Pen strokes are "tied to" the page where they are created.** For example, if you circle a word on page 30 and then change the formatting to use a larger font, the word you circled might *now* be on page 36, but the circle you drew will still be on page 30, circling a totally different word (or nothing at all). This is why the tablet warns you before changing the formatting of an EPUB document, because if you *have* any pen strokes, there's a good chance they will end up on the "wrong" page.

### `.rmn` files (RCU)

If you're using [RCU](http://www.davisr.me/projects/rcu/), you can *download* documents to the computer. It downloads them as `.rmn` files. These are containers which have all of the files from the tablet's filesystem which make up the document. The computer won't be able to do much with this file, but you can use RCU to upload this `.rmn` file back to the tablet (or to a different tablet).

This is important because, if you "export" a document to a PDF file, your pen strokes will be "burned into" the PDF. You can later upload that PDF back into a tablet, but the earlier pen strokes will now be "permanent", and you won't be able to edit them.

When you use `.rmn` files, the pen strokes remain as pen strokes, and when you upload it back to a tablet, they will be just as edit-able as they were before you downloaded the file.
