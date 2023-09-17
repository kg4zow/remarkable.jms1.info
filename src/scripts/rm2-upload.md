# rm2-upload script

**Idea**: command line script to upload archived documents/templates to a tablet, works with `rm2-download` or with files downloaded using RCU

* upload `.rmn` files
    * to original folder (by UUID) if it exists on the tablet
    * to root otherwise

* upload `.rmt` files
    * store in same place RCU stores them, create symlinks, update `templates.json`
    * convert SVG to PNG
        * does rM *need* both files?
        * why doesn't `.rmt` file contain both?

* upload `.rmf` files
    * so that documents can be upload back to their original folders

* upload multiple files
    * always upload `.rmt`, then `.rmf`, then `.rmn`
    * option to recursively upload all files in a directory tree

**Status**: 20% done - `.rmf` seems to be working, others *partly* written and not even tried yet.
