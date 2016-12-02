# Unreal Package Textures Renamer
You can unpack Unreal Engine *.u* packages and decompile classes to *.uc* with **WOTgreal Exporter**.

But what to do if you want to repack them?

`UCC make` will give you many errors claiming that textures are missing.

**WOTgreal Exporter** could unpack textures, but it unpack them with names taken from `NAME=` option of `#EXEC TEXTURE IMPORT` directive in *.uc* files.

So, I've created simple script with [AutoHotkey 2.0](https://autohotkey.com/v2/) that reads all `#EXEC TEXTURE IMPORT` directives (it could omit `//` comments, but not `/* */`, you need to delete them manually, to avoid annoying warning messages) in all *.uc* files and renames textures to original names specified in `FILE=` option (and restores their original path).

How to use it
------
- In *.uc directory* field enter (or select with <kbd>...</kbd> button) path to Classes directory (without trailing slash) with unpacked/decompiled *.uc* files.
- In *Textures directory* field enter (or select with <kbd>...</kbd> button) path (without trailing slash) to textures unpacked from respective *.u* package (if you use **WOTgreal Exporter** - export both to `.bmp` and `.pcx`, as it is not possible to predict which texture of what format is).
- Press <kbd>Do</kbd> button and magic begins.
- Textures will be renamed and copied with xcopy to respective paths specified if `FILE` option, relative to theirs original path (sometimes there `..` may be found in original path, so it may copy files to upper folder), directory structure will be created, if needed.

***
Maybe in future version I will embed *.u* unpacker and UCC to fully automate process of repacking, but I think it will be completely new project.
