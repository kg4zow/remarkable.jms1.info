# Fonts

Several people have asked how to install custom fonts on a reMarkable tablet. This page will explain what I've figured out.

## Background

The reMarkable tablets come with a collection of font files pre-installed. The `xochitl` program (aka the "reMarkable app" running on the tablet) was written specifically to use these fonts, so one thing you absolutely *don't* want to do is delete these files.

### Built-in Fonts

The tablet comes with two font families installed.

**[Noto](https://fonts.google.com/noto)** is used for most text. Font files are available for just about every human-readable language on the planet.

**[EB Garamond](https://fonts.google.com/specimen/EB+Garamond)** is used for "fancy" text. It has a limited set of fonts available for languages which don't use latin characters. In particular, none of the languages I searched for (Arabic, Chinese, Hebrew, Japanese, or Korean) have font files available.

### Missing Glyphs

One problem you may run into is that the font files don't contain glyphs (the "shapes" you see on the screen for each letter) for every possible character in every possible language. This is especially true for text in languages which don't use "normal" Latin characters.

It is possible to add font files to the tablet. If you do this, and the tablet needs to *display* those characters, it will use glyphs from those font files rather than showing a generic "box" in place of each character it can't draw.

![Without Korean font](../images/glyphs-missing.png) Without a Korean font installed

![With Korean font](../images/glyphs-present.png) With the [Noto Serif KR](https://fonts.google.com/noto/specimen/Noto+Serif+KR) font installed

## Installing Custom Fonts

The tablet uses the [fontconfig](https://www.freedesktop.org/wiki/Software/fontconfig/) library to manage fonts. Any font which fontconfig knows about, will be available for use by `xochitl` if needed.

The tablet can use `.ttf` or `.otf` font files. It *might* be able to use other formats, I haven't tried. All of the fonts I've needed have been available in one of these two formats.

### Font Storage Directory

The fontconfig library is configured with a list of directory names which, *if they exist*, may contain font files. This list is:

* `/usr/share/fonts/`
* `/home/root/.local/share/fonts/`
* `/home/root/.fonts/`

The `/usr/share/fonts/` directory is in the OS partition, which means it will be replaced if the OS is upgraded. You *can* add custom font files here, but I don't recommend it.

The other two directories are under `/home/`, which is the user data partition. These files will NOT be overwritten when the OS is upgraded.

There is a note in the `/etc/fonts/fonts.conf` file which says that `~/.fonts` is deprecated and will be removed in a future version (not sure if this means a future version of fontconfig or a future version of xochitl), so to be on the safe side, I'm storing the custom font files on my own tablets in the `/home/root/.local/share/fonts/` directory.

If it doesn't already exist, you can create this directory using this command:

```
mkdir -f /home/root/.local/share/fonts
```

You can create other sub-directories under this if you like, the `fc-cache` program (below) will scan all sub-directories looking for font files.

### Adding Font Files

Upload your custom font files to the `/home/root/.local/share/fonts/` directory.

You can use any SSH file transfer program to do this, I normally use the `scp` command line client. For example ...

```
scp filename.ttf root@10.11.99.1:/home/root/.local/share/fonts/
```

### Rebuild the Font Cache

Any time you add, remove, or update font files, you need to run this command to rebuild fontconfig's cache files.

```
fc-cache -fv
```

The `-f` option tells it to rebuild the cache files for directories which were previously cached.

The `-v` option tells the command to show more information about what it's doing. Specifically, it shows you each directory it's processing.

```
# fc-cache -fv
/usr/share/fonts: caching, new cache contents: 0 fonts, 1 dirs
/usr/share/fonts/ttf: caching, new cache contents: 0 fonts, 2 dirs
/usr/share/fonts/ttf/ebgaramond: caching, new cache contents: 12 fonts, 0 dirs
/usr/share/fonts/ttf/noto: caching, new cache contents: 13 fonts, 0 dirs
/home/root/.local/share/fonts: caching, new cache contents: 0 fonts, 1 dirs
/home/root/.local/share/fonts/NotoSerifKRFont: caching, new cache contents: 7 fonts, 0 dirs
/home/root/.fonts: skipping, no such directory
/usr/share/fonts/ttf: skipping, looped directory detected
/home/root/.local/share/fonts/NotoSerifKRFont: skipping, looped directory detected
/usr/share/fonts/ttf/ebgaramond: skipping, looped directory detected
/usr/share/fonts/ttf/noto: skipping, looped directory detected
/var/cache/fontconfig: cleaning cache directory
/home/root/.cache/fontconfig: not cleaning non-existent cache directory
/home/root/.fontconfig: not cleaning non-existent cache directory
fc-cache: succeeded
```

The "looped directory" messages are harmless, they just mean that `fc-cache` has already scanned that directory and is refusing to scan it a second time.

### Restart xochitl

After rebuilding the font cache, you need to restart xochitl. This is because it doesn't re-read the font cache after starting, it only reads it once when it starts up.

```
systemctl restart xochitl.service
```

If you're watching the tablet's display, you'll see the screen go black and then see the "loading" message while the software starts up.

Once this is done, the new fonts will be available if needed.

## Renaming Notebooks

You *can* also change notebooks' "display names" to include characters in these alternate fonts.

![Document names](../images/fonts3.png)

**However.** You can't do this using xochitl (the software running on the tablet itself), because neither the on-screen keyboard, nor the "type folio", have the ability to type arbitrary characters in languages other than the ones supported by the software.

A user on Reddit [reports](https://www.reddit.com/r/RemarkableTablet/comments/1g1kl3x/emojis_in_titles/) that the reMarkable desktop and/or mobile apps are able to rename folders and documents to include emoji in the title, and that those emoji carried over to the tablet. I can't use their desktop or mobile apps because I don't use the reMarkable cloud, so I have no way to verify this, however it does make sense - if the computer, tablet, or phone where the app is running provides a keyboard with full unicode support.

They also reported that, even though they have an rMPP with a colour screen, the emoji they were using appeared in colour on the computer, but in greyscale on the tablet. I suspect this is because their computer had a font file containing colour glyphs for those emoji, but the tablet has a font file with greyscale glyphs.

If this is also not an option for you, the other option is to edit the document's metadata file.

> &#x26A0;&#xFE0F; **Be very careful.**
>
> Making the wrong kind of typo here can cause problems. At the very least, it can make the document "not work" on the tablet, or it's possible that it could crash the software entirely. I don't know, because I've been editing JSON file for 20+ years, and I've always been really careful when working with files directly on the tablet, *especially* when editing their contents.
>
> If you're not 100% sure what you're doing, PLEASE don't try to do this.

### Identify the document's UUID

reMarkable documents are stored in the tablet's [filesystem](filesystem.md) as collections of files, each with a UUID for the name.

> &#x2139;&#xFE0F; **UUID**
>
> A UUID is a "Universal Unique IDentifier". It's a 128-bit random number. The idea is, every document must have a unique identifier, and the chances of the tablet choosing a UUID which is already being used are very small (technically, it's a one in 2<sup>128</sup> chance).

This is because the tablet will allow you to give multiple documents the same "display name", if you really want to so do. (I don't recommend it, there's no way to tell which document is which - unless they have different numbers of pages or something.)

You will need the UUID in order to identify which file to edit. What I normally do is this:

* In the tablet's UI, rename the document to something unique. (I like to use `xyzzy` for this, but use whatever you like. It just needs to be unique across all documents in your tablet.)

* In the tablet, search the `UUID.metadata` files to find the one containing that name.

    ```
    # cd /home/root/.local/share/remarkable/xochitl/
    # grep -i 'xyzzy' *.metadata
    9cc3f363-8076-4ecc-aeb7-ebddbfeaad8c.metadata:    "visibleName": "xyzzy"
    ```

    It should only find one file. If it finds more than one, go back and rename the document to something unique and try again.

### Edit the `UUID.metadata` file

There are a few ways to do this.

* The tablet has `vi` and `nano` built in. If you're familiar with one or both of them, you can use them.

    ```
    # cd /home/root/.local/share/remarkable/xochitl/
    # nano 9cc3f363-8076-4ecc-aeb7-ebddbfeaad8c.metadata
    ```

* You can also download this *one file* using `scp`, edit the file on your computer, and upload it back to the tablet.

    If you do this, be sure you're using a TEXT EDITOR which can use (and save) files having only LF (aka `\n`) characters at the ends of the lines. DO NOT use a "word processor". You must, Must, MUST make sure that the file you upload back to the tablet contains nothing but JSON.

However you edit the file, you're going to need to either use an editor which allows you to type Unicode characters (`vi` and `nano` on the tablet do not), or you're going to have to manually look up the Unicode "code point" values for each character. (This is what I did, to make the Korean and Hebrew filenames you see in the example above.)

Assuming you're entering the Unicode code points directly, you'll need to encode each non-latin character as `\uXXXX`, where `XXXX` is the code point number in exactly four hexadecimal digits. For example ...

| Language  | String | Encoded |
|:----------|:-------|:--------|
| Korean    | &#xC548;&#xC601; &#xD558;&#xC138;&#xC694;! | `\uC548\uC601 \uD558\uC138\uC694!`
| Hebrew    | Shalom &#x05E9;&#x05DC;&#x05D5;&#x05DD; | `Shalom \u05E9\u05DC\u05D5\u05DD`

Before you save your changes ...

* DO NOT edit anything other than the `"visibleName"` line.

* MAKE SURE the string has double-quotes before and after the new title.

* If the line you edited DID HAVE a comma at the end, don't remove it.

* If the line you edited DID NOT HAVE a comma at the end, don't add one.


    ```
    {
        "createdTime": "1728093402780",
        "lastModified": "1728094480054",
        "lastOpened": "1728095240368",
        "lastOpenedPage": 0,
        "parent": "",
        "pinned": false,
        "type": "DocumentType",
        "visibleName": "Shalom \u05E9\u05DC\u05D5\u05DD"
    }
    ```

    > &#x2139;&#xFE0F; **Different file formats**
    >
    > This example is from an rM2 running 3.14.1.9. Different versions of the reMarkable software may include more, less, or "other" keys than the ones shown here. As long as the `"visibleName"` line is the only one you edit, you should be fine.

Once you're sure taht the file is correct, save your changes.

### Restart xochitl

After renaming a document by hand, you need to restart xochitl to make it re-read the documents' names from the disk.

```
systemctl restart xochitl.service
```

Assuming you did everything correctly, you should see the document's new name in the file browser.
