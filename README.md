## Commentary:

This is a fork of powerline.el which I began while the original
authorship of powerline was unknown, I'll include accreditation to
the proper author(s), please drop me a line at jasonm23@gmail.com
and let me know if you have historical information about poweline
on emacs.

Note: the original version forked from was not credited to Nicolas
Rougier and Chen Yuan, let me know if this was initially ommitted,
or if Nicholas and Chen have extended powerline.el from the
initial version. Thank you.

Additional shapes added:
chamfer, rounded, slant, slant-left, slant-right

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
