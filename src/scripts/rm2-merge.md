# rm2-merge script

## Idea

Script which reads two or more `.rmn` files and combines them into a single `.rmn` file

```
$ ./rm2-merge -o output.rmn input1.rmn input2.rmn input3.rmn
```

## Status

0%, haven't started yet

## Other

Inspired by [this question on Reddit](https://www.reddit.com/r/RemarkableTablet/comments/16khykj/merge_rmn_files/)

How to handle `.rmn` files containing PDF/EPUB files

* refuse

* allow in *first* file only, pages from additional files are added to the end with template removed

    * what happens if templates are *not* removed? `xochitl` doesn't let you set templates for additional pages, but can it handle such pages if they already exist in the `UUID.content` file?
