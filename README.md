## Commentary:

This is a fork of powerline.el which I began while the original
authorship of Emacs powerline was unknown. 

(Nicolas Rougier posted to powerline.el 1.0.0 to Emacswiki initially.)

![](https://raw.github.com/jasonm23/emacs-mainline/master/emacs-mainline.png)

## Using mainline.el.

Add a require to .emacs 

    (require 'mainline) 

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
