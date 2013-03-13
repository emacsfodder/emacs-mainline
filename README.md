## Commentary:

This is a fork of powerline.el which I began while the original
authorship of powerline was unknown. As far as I know, Nicolas Rougier
posted to Emacswiki initially.

## Using mainline.el.

Add a require to .emacs 

    (require 'mainline) 

(or install from elpa/marmalade which uses auto-load)

You can customize the separator graphic by setting the customize variable

    mainline-arrow-shape

possible values:

    chamfer
    chamfer14 (default)
    rounded
    arrow
    arrow-14
    slant
    slant-left
    slant-right;
    half
    percent
    curve

For screenshots of all shapes and additional info see the article at:
http://emacsfodder.github.com/blog/powerline-enhanced/

![](https://raw.github.com/jasonm23/emacs-mainline/master/emacs-mainline.png)
