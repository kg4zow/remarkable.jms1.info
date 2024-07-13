# rm2-download script

## Idea

Command line script to download documents and templates from rM tablet. Write the same archive files as RCU.

* download documents to `.rmn` files

* download templates to `.rmt` files

* download folders to `.rmf` files (placeholders for UUIDs, so documents can be uploaded back to the same folder they were originally in)

* options to download "all documents", "all templates", "just custom templates", "everything"

* `.rmn` and `.rmt` files can be uploaded using RCU

## Status

85% done, still a few minor bugs

When I started writing this script I didn't realize that RCU *had* a command line interface. Now that I'm invested in the `rm2-download` script, I want to get it (and the [`rm2-upload`](rm2-upload.md) script) finished. The act of *writing* these scripts is helping me better understand how documents are stored on the tablet, which I think will come in handy when/if I start on other ideas.
