# Templates

The reMarkable tablets offer a selection of "templates" that you can base your notebook pages on. Some of them look like notebook paper, graph paper, a grid of dots, or musical staves. Some look like pages from a "day planner", and some have lines laid out in patterns which can be useful when doing design or art work. There's also a template called "Blank" which, as you might expect, doesn't have anything on it at all.

Every page consists of multiple "layers", whose contents are shown above each other. The template is always the bottom layer, and when you write or type on a page, you're writing or typing into a layer *above* the template.

The biggest problem I've run into with templates is that the built-in software doesn't offer a way to create, add, remove, or otherwise manage templates. However, it's fairly simple to upload your own templates into the tablet, and if you can edit a JSON file (which is human-readable text, it just has a very specific format) you can add your template to the list used by the reMarkable software, and then use that template with your own notebooks.

This page will explain what I've learned about creating and installing templates. At the very end of the page are links to some of the templates I've created for myself.

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

- Colour depth: I create 8-bit greyscale, others may work as well

- Transparency: I've read reports online saying that there can be issues with templates with a transparency layer (or "alpha channel"). In the templates I've made, I use white as the background and remove the alpha channel.

The zone on the left (or right, if the tablet is in left-handed mode) where the menu bar appears and disappears, is 120 pixels wide. If the users of your template may want/need to work while the menu bar is on screen, you may want to be sure not to have anything important in this area. In most of my templates I draw a shaded rectangle there, so users don't accidentally draw there without meaning to.

You can create the file using any graphics program which can save a PNG file. For example, I use ..

* [Graphic Converter](https://www.lemkesoft.de/en/products/graphicconverter/) for "hands on" graphics work
* [ImageMagick](https://imagemagick.org/) for simple scripts.
* Perl with the [GD module](https://metacpan.org/pod/GD) (which is a wrapper around the [GD library](https://libgd.github.io/)) for more complex scripts.

There *are* other programs and libraries out there, these are just the ones that I use personally.

## Uploading Template Files

Once you've created a template file, it needs to be uploaded and stored on the tablet, in the `/usr/share/remarkable/templates/` directory. The templates which are built into the reMarkable software are stored here, be careful not to change or delete them by accident.

Note that you can create sub-directories here if you like. If you do this, remember to include the directory name in the `filename` value when you add the template to the JSON file.

One thing to be aware of ... the `/usr/share/remarkable/templates/` directory will be wiped and replaced when the tablet's built-in software is updated. What I've seen other programs (such as [RCU](http://www.davisr.me/projects/rcu/)) do is, create a directory under `/home/root/` for your custom template files, and create *symlinks* in `/usr/share/remarkable/templates/` which point to the files in this new directory. This way when the software is updated, the files will still be there, and only the symlinks will need to be re-created.

## Updating the `template.json` file

In the same directory is a file called `template.json`. This is a JSON file containing the filename, description (the caption below the template's icon in the reMarkable software), which icon to use for the template, and which categories should "contain" the template.

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

* `filename` = The ifilename of PNG/SVG file, without the extension.

    Some of the built-in templates have both `.png` and `.svg` files, I *guess* the software looks for one before the other, and uses whichever one it finds first?

* `iconCode` = Unicode character number used as the template's icon in the "template chooser" interface.

    The icons are actually characters being shown from a "web font" file. The file is `/usr/share/remarkable/webui/fonts/icomoon.woff`.

    * [reMarkable Wiki](https://remarkablewiki.com/tips/templates) has a list of the iconCode values used in system 2.3.0.16. It looks like the same file is being used in later versions, at least up to 3.0.5.56 (which is what was on my tablet when I received it).

* `landscape` = whether template is meant for landscape mode (i.e. tablet rotated 90&deg;)

    * defaults to `false`
    * not sure what setting this to `true` actually *does* yet

* `categories` = which tabs in the "template chooser" UI should "contain" this template. The same template can appear in multiple tabs.

    * The "All" tab doesn't need to be listed because it already contains every template listed in the file.
    * Not sure what happens if you add a name which isn't one of the built-in tabs.

### Restarting the reMarkable Software

After modifying `templates.json` you need to restart `xochitl`.

```
systemctl restart xochitl
```

If you watch the tablet, you will see the screen reset and it will look like it's rebooting, although the process doesn't take as long as a full reboot.


## Easier options to upload templates

I'm using these ...

- [RCU](http://www.davisr.me/projects/rcu/) = reMarkable Connection Utility
    - $12, includes 365 days of updates and email support from author
    - Claims to be "free software" but ...
        - the price is not zero (i.e. it's not "free beer")
        - the source code is only available to paying customers (i.e. it's just *barely* "free speech", although technically it *is* within the limits of most open-source licenses, thanks RedH... er, IBM)

At some point I want to look at these ...

- [`templatectl`](https://github.com/PeterGrace/templatectl)
    - command line utility, written in rust
    - looks like it ONLY updates the JSON file

- [reMarkable Assistant](https://remarkablewiki.com/tips/assistant)
    - free
    - [Github](https://github.com/richeymichael/remarkable-assistant)


## Sources of Templates

I've seen several places online offering ready-made templates for download, and people are even *selling* them. The one(s) listed here are the ones that actually seem useful to me.

- [Templarian](https://templarian.github.io/remarkable/)
    - GENERATES grids (square) or isometric (triangular)
    - adjustable sizes, offsets, and colours
    - runs in the browser

## My Templates

I have created a few templates ... more specifically, I have created scripts which create templates.

See the "Templates" section on the left.
