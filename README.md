### Main-line - v1.2.8

This is a fork of powerline.el which I began while the original
authorship of powerline was unknown.

- Note: Forked from the original emacs port of vim powerline,
Powerline.el by Nicolas Rougier

**Note:** Mainline is being merged with the other active fork of [Powerline](https://github.com/milkypostman/powerline) - The new separators and serveral new ones have been added already. I will be retiring emacs-mainline in light of this, and 1.2.8 is likely the final release. I suggest you switch over to [Powerline](https://github.com/milkypostman/powerline) if you are using main-line currently.
## Using main-line.el

Add a require to .emacs / init.el

     (require 'main-line)

You can customize the separator graphic by setting the custom variable (you can also click the separators to cycle through them)

     main-line-separator-style
     
e.g.

     (setq main-line-separator-style 'wave)

possible values...

- `contour`
- `contour-left`
- `contour-right`
- `roundstub`
- `roundstub-left`
- `roundstub-right`
- `brace`
- `wave`
- `zigzag`
- `butt`
- `wave-left`
- `zigzag-left`
- `butt-left`
- `wave-right`
- `zigzag-right`
- `butt-right`
- `chamfer`
- `chamfer14`
- `rounded`
- `arrow`
- `arrow14`
- `slant`
- `slant-left`
- `slant-right`
- `curve`

To customize the modeline - simply override the value of mode-line-format,
see the default at the end of the script, as an example.

You can create your own modeline additions by using the defmain-line macro.

for example,

    (defmain-line row "%4l")

gives you `main-line-row` to use in `mode-line-format`

Note. Using `main-line-percent-xpm` requires 18px separators (use
`main-line-percent` with `arrow14` or `chamfer14`)

Examples

![](https://raw.github.com/jasonm23/emacs-mainline/master/emacs-main-line-examples.png)
