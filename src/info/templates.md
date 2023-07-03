# Templates

The reMarkable tablets offer a selection of "templates" that you can base your notebook pages on. Some of them look like notebook paper, graph paper, a grid of dots, or musical staves. Some look like pages from a "day planner", and some have lines laid out in patterns which can be useful when doing design or art work. There's also a template called "Blank" which, as you might expect, doesn't have anything on it at all.

Every page consists of multiple "layers", whose contents are shown above each other. The template is always the bottom layer, and when you write or type on a page, you're writing or typing into a layer *above* the template.

The biggest problem I've run into with templates is that the built-in software doesn't offer a way to create, add, remove, or otherwise manage templates.

However, it's fairly simple to upload your own templates into the tablet, and if you can *carefully* edit a text file, you can add your template to the list used by the reMarkable software, and then use that template with your own notebooks.

Templates can also be used as "cover pages" for your notebooks.

## Useful Pages

* [How to Make Template Files for Your reMarkable](https://www.simplykyra.com/how-to-make-template-files-for-your-remarkable/) - fairly simple explanation of how to load templates into the tablet.

* [reMarkable Wiki - Customizing the Templates](https://remarkablewiki.com/tips/templates) - another good explanation, along with a collection of other links

## Creating a Template File

A template file is an image file with the following properties:

- Format: PNG

    Apparently you can also use a PDF file, but I haven't tried it. In addition, the template files that come with the tablet have SVG versions, however I haven't seen SVG mentioned as a usable template file type anywhere, so I don't know if they would work or not. (If I get a chance and remember, I'll try it and update this page with my findings.)

- Size: 1404x1872 pixels, 226 dpi

- Colour depth: I create 8-bit greyscale, others may work as well

- Transparency: I've read reports online saying that there can be issues with templates with a transparency layer (or "alpha channel"). In the templates I've made, I use white as the background and remove the alpha channel.

The zone on the left where the menu bar appears and disappears is 120 pixels wide. If the users of your template may want/need to work while the menu bar is on screen, you may want to be sure not to have anything important in this area.

You can create the file using any graphics program which can save a PNG file. For example, I use [Graphic Converter](https://www.lemkesoft.de/en/products/graphicconverter/) for most of the graphics work I do.

## Uploading Template Files

Once you've created a template file, it needs to be uploaded and stored on the tablet, in the `/usr/share/remarkable/templates/` directory. The templates which are built into the reMarkable software are stored here, be careful not to change or delete them by accident.

Note that you can create sub-directories here if you like. If you do this, remember to include the directory name in the `filename` value when you add the template to the JSON file.

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

    * [reMarkable Wiki](https://remarkablewiki.com/tips/templates) has a list of the iconCode values used in system 2.3.0.16

* `landscape` = whether template shows up in landscape mode
    * defaults to `false`
    * not sure if setting this `true` makes it *not* show up in portrait mode

* `categories` = which tabs in the "template chooser" UI should "contain" this template. The same template can appear in multiple tabs. The "All" tab doesn't need to be listed because it already contains every template listed in the file.

### Restarting the reMarkable Software

After modifying `templates.json` you need to restart `xochitl`.

```
systemctl restart xochitl
```

If you watch the tablet, you will see the screen reset and it will look like it's rebooting.


## Easier options to upload templates

- [`templatectl`](https://github.com/PeterGrace/templatectl)
    - command line utility, written in rust
    - looks like it ONLY updates the JSON file

- [reMarkable Assistant](https://remarkablewiki.com/tips/assistant)
    - free
    - [Github](https://github.com/richeymichael/remarkable-assistant)

- [RCU](http://www.davisr.me/projects/rcu/) = reMarkable Connection Utility
    - $12, includes 365 days of updates and email support from author
    - claims to be "free software" but the price is not zero, and the source code is not available without paying for it (sounds like RedHat's definition of "free" software)
    - [web page](http://www.davisr.me/projects/rcu/)

- eInkPads Template Installer
    - $21.45, on sale for $18.99
    - free updates for life
    - mac/windows versions
    - [web](https://www.einkpads.com/collections/frontpage/products/remarkable-template-installer-apple-computers)

## Sources of Templates

### Online

I've seen several places online offering ready-made templates for download, and people are even *selling* them on etsy. The one(s) listed here are the ones that actually seem useful to me.

- [Templarian](https://templarian.github.io/remarkable/)
    - GENERATES grids (square) or isometric (triangular)
    - adjustable sizes, offsets, and colours
    - runs in the browser

### My Templates

See [`/keybase/public/jms1/reMarkable2/templates/`](https://jms1.pub/reMarkable2/templates/) for some of the templates I've created.