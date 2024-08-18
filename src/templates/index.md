# Templates

The reMarkable tablets offer a selection of "templates" that you can base your notebook pages on. Some of them look like notebook paper, graph paper, a grid of dots, or musical staves. Some look like pages from a "day planner", and some have lines laid out in patterns which can be useful when doing design or art work. There's also a template called "Blank" which, as you might expect, doesn't have anything on it at all.

Every page consists of multiple "layers", whose contents are shown above each other. The template is always the bottom layer, and when you write or type on a page, you're writing or typing into a layer *above* the template.

The biggest problem I've run into with templates is that the built-in software doesn't offer a way to create, add, remove, or otherwise manage templates. However, it's fairly simple to upload your own templates into the tablet, and if you can edit a JSON file (which is human-readable text, it just has a very specific format) you can add your template to the list used by the reMarkable software, and then use that template with your own notebooks.

This page will explain what I've learned about creating and installing templates. At the very end of the page are links to some of the templates I've created for myself.

> &#x26A0;&#xFE0F; **PDF Files Are Not Templates**
>
> A lot of people like to use the word "template" when talking about PDF files.
>
> **They are NOT the same thing.**
>
> [This page](../faq/file-types.html#pdf-files-as-templates) explains in more detail.

## Useful Pages

* &#x2705; [How to Make Template Files for Your reMarkable](https://www.simplykyra.com/how-to-make-template-files-for-your-remarkable/) - Explains a lot of deatails about templates, including how to load them into the tablet and make the reMarkable software use them.

    The page you're reading is probably a "stripped down" version of this page. Even if my page covers everything you need, it's definitely worth taking the time and reading through this page as well.

* [reMarkable Wiki - Customizing the Templates](https://remarkablewiki.com/tips/templates) - another good explanation, along with a collection of links to other pages.

## Creating a Template File

A template file is an image file with the following properties:

- Format: PNG

    I've seen a few web pages mention using a PDF file as a template. I tried this, and ... *it's not a template*. What you're actually doing is *viewing the PDF*, and adding notes on a layer above it.

    In addition, the template files that come with the tablet have SVG versions, however I haven't seen SVG mentioned as a usable template file type anywhere, so I don't know if they would work or not. (If I get a chance and remember, I'll try it and update this page with my findings.)

- Size: 1404x1872 pixels, 226 dpi

- Colour depth: I normally create them using an 8-bit greyscale colour space. The tablet can handle full-colour images, however it will obviously *show* them as greyscale.

- Transparency: I've read reports online saying that there can be issues with templates with a transparency layer (or "alpha channel"). In the templates I've made, I use white as the background and remove the alpha channel.

The zone on the left (or right, if the tablet is in left-handed mode) where the menu bar appears and disappears, *was* 120 pixels wide in the 3.0 firmware, and was reduced to 104 pixels in 3.5. If the users of your template may want/need to work while the menu bar is on screen, you may want to be sure not to have anything important in this area. In most of my templates I draw a lightly shaded rectangle there, so users don't accidentally draw there without meaning to.

You can create the file using any graphics program which can save a PNG file. For example, I use ..

* [ImageMagick](https://imagemagick.org/) for simple scripts.
* Perl with the [GD module](https://metacpan.org/pod/GD) (which is a wrapper around the [GD library](https://libgd.github.io/)) for more complex scripts.
* [Graphic Converter](https://www.lemkesoft.de/en/products/graphicconverter/) or [GIMP](https://gimp.org/) for "hands on" graphics work.

There *are* other programs and libraries out there, these are just the ones that I use personally.

## Uploading Template Files - Third Party Software

There are two primary methods of uploading templates to the tablet - using a third-party program, or doing it by hand.

### RCU

I use a program called [RCU](http://www.davisr.me/projects/rcu/) to upload templates. It's available for several Linux distributions, as well as FreeBSD, macOS, and windows.

RCU can also be used to download documents in a format which can be uploaded and edited again, i.e. it doesn't "burn" the pen strokes into the PDF like the reMarkable software. It can also be used to upload custom "splash screens", such as the "sleep screen" that the tablet shows when you aren't using it.

When it uploads templates or splash screens, it stores the *files* in the partition which doesn't get replaced when the firmware is updated, and *links* the files into the system directories where the reMarkable software looks for them. When the firmware is updated, RCU can detect files which were previously uploaded but are no longer linked, and will offer to re-link them automatically.

It's not free (as in "zero pricetag") but it's not expensive - I believe it's only $12/yr for access to upgrades as they're released, which includes access to the source code and a "developers" mailing list.

With that said, it *is* open-source, under the [GNU AGPLv3](https://www.gnu.org/licenses/agpl-3.0.en.html) license. The developer has stated that this allows customers to share the source code with the world, however I haven't heard of anybody doing this. Personally, I feel like if you're going to use it, you should pay for it - especially where it's only $12. (Now that I've used it for a while, I would actually be willing to pay more ... but don't tell the developer that.) &#x1F601;

### Others

At some point I want to look at these ...

- [reMarkable Assistant](https://github.com/richeymichael/remarkable-assistant)
    - free (can't find any mention of which license it uses)
    - Last commit 2018-02-17

I know there are others out there, but I don't remember them off the top of my head. I'll update this page if I happen to see them. Or if you happen to know of any, please [let me know](../introduction.md#feedback).

## Uploading Template Files - Manually

Custom template files need to be uploaded and stored on the tablet, in the `/usr/share/remarkable/templates/` directory. The templates which are built into the reMarkable software are stored here, be careful not to change or delete them by accident.

There are two problems with this:

* The `/usr/share/remarkable/templates/` directory is not under `/home/`, which means it's in the `/` filesystem, along with the OS and the reMarkable software. This filesystem is almost full to begin with, and if you upload enough new files to totally fill it, you won't be able to SSH into the tablet at all.

* The `/usr/share/remarkable/templates/` directory will be replaced when the tablet's built-in software is updated. Any files you may have uploaded or edited will be gone, the only things left will be whatever the new OS image includes.

You can (mostly) work around these problems using "symbolic links", aka "symlinks". A symlink is a small file which contains the *name* of a different file, along with a flag which says "this is a symlink". When a program tries to read or write the symlink, the kernel will see that it *is* a symlink, and will actually read or write the file that the symlink points to.

When I realized that the `/` filesystem is almost full, I had to think of some other way to upload templates without totally filling it up.

### My original solution

What I *originally* came up with is this:

* Create a directory under `/home/` somewhere, just for custom template files. Because this is under the `/home/` directory, it will NOT be replaced when the OS is upgraded.

* When uploading or updating a template ...

    * Upload the image file to this custom directory.
    * In the `/usr/share/remarkable/templates/` directory, create a symlink with the same name as the image file, *pointing to* the actual image file under `/home/`.
    * Update the `templates.json` file (see below) as usual.

Then, after an OS upgrade, all I would need to do is re-create the symlinks and update the `templates.json` file. The actual template *files* would still be on the tablet, just not in the directory where the reMarkable software would be looking for them, so I wouldn't need to upload them from the computer again.

I did get this working, and I was *planning* to write a program that I could run on the tablet, to scan both directories and build a new JSON file ... but then I started using RCU.

### What RCU does

It turns out RCU does *more or less* the same thing I was doing, i.e. storing the image files in a directory under `/home/` and creating symlinks. However, it also stores a small JSON file in the directory with the image files, containing the information that the `templates.json` file needs *about* that template (i.e. display name, icon code, categories, etc.)

I'd like to think I would have come up with the same idea, but the truth is, since I started using RCU I've never uploaded a template by hand, and I haven't even *thought* about my first idea until just now when I wrote this.

### Updating the `templates.json` file

In the `/usr/share/remarkable/templates/` directory is a file called `templates.json`. This is a JSON file containing the filename, description (the caption below the template's icon in the reMarkable software), which icon to use for the template, and which categories should "contain" the template.

The file itself looks like this:

```json
{
  "templates": [
    {
      "name": "Blank",
      "filename": "Blank",
      "iconCode": "\ue9fe",
      "categories": [
        "Creative",
        "Lines",
        "Grids",
        "Life/organize"
      ]
    },
    {
      "name": "Blank",
      "filename": "Blank",
      "iconCode": "\ue9fd",
      "landscape": true,
      "categories": [
        "Creative",
        "Lines",
        "Grids",
        "Life/organize"
      ]
    },

    {
      "name": "Hexagon small",
      "filename": "P Hexagon small",
      "iconCode": "\ue98c",
      "categories": [
        "Grids"
      ]
    }
  ]
}
```

Within each object are the following items:

* `name` = The caption shown below the icon in the "template chooser" interface.

* `filename` = The filename of PNG/SVG file, without the extension.

    The built-in templates have both `.png` and `.svg` files. From what I can tell ...

    * The software looks for a file with this name plus `.svg`, in the `/usr/share/remarkable/templates/` directory.
    * If it doesn't find one, it looks for a file with this name plus `.png`, also in the `/usr/share/remarkable/templates/` directory.
    * If it doesn't find either one, it skips that template.
    * If the file that it finds is actually a symlink, the software ends up reading whatever file the symlink *points to*, without knowing that it *is* a symlink to begin with.

    My *guess* is that with `.svg` files, the software is able to "repeat" a pattern when doing the "infinite scrolling" thing (i.e. if you scroll the page down to keep writing).

* `iconCode` = Unicode character number used as the template's icon in the "template chooser" interface.

    The icons are actually characters being shown from a "web font" file. The file is `/usr/share/remarkable/webui/fonts/icomoon.woff`.

    * [reMarkable Wiki](https://remarkablewiki.com/tips/templates) has a list of the iconCode values used in system 2.3.0.16. It looks like the same file is being used in later versions, at least up to 3.0.5.56 (which is what was on my tablet when I received it).

    * I haven't checked myself, but I remember reading somewhere that in later versions of the software, the icon codes use different numbers for each image.

* `landscape` = whether template is meant for landscape mode (i.e. tablet rotated 90&deg;). If this value is not present, the software assumes `false` (i.e. that the template is for portrait mode).

* `categories` = which tabs in the "template chooser" UI should "contain" this template. The same template can appear in multiple tabs.

    * The "All" tab doesn't need to be listed because it already contains every template listed in the file.

    * The tablet combines all of the category names from all of the templates to build the "tabs" along the top of the template chooser interface.

    Note that you *can* add your own tabs, but be careful not to "overflow" the width of the screen. I normally change every instance of "Life/organize" to "LifeOrg" to make room on the screen, and then use "Custom" for all of my own custom templates.

### Restarting the reMarkable Software

If you've modified `templates.json`, you will need to restart `xochitl`.

```
systemctl restart xochitl
```

If you watch the tablet, you will see the screen reset and it will look like it's rebooting, although the process doesn't take as long as a full reboot.


## Other Sources of Templates

I've seen several places online offering ready-made templates for download, and people are even *selling* them. The one(s) listed here are the ones that actually seem useful to me.

- [Templarian](https://templarian.github.io/remarkable/)
    - GENERATES grids (square) or isometric (triangular), using dots, lines, or anything in between (i.e. "+" marks)
    - Adjustable sizes, offsets, and colours
    - Javascript, runs in your browser

## My Templates

I have created a few templates ... more specifically, I have created *scripts* which create templates.

See the pages under the "Templates" section on the left.

If you're interested, I also wrote a shell script called [`generate`](generate) which I run on my workstation after adding or updating the scripts, to copy the scripts into this directory and generate the `.png` files.
