;;; mainline.el --- modeline replacement forked from an early version of powerline.el
;;;
;;; Author: Jason Milkins
;;; Version: 1.1.0
;;;
;;; Keywords: statusline / modeline
;;;
;;; Changelog:
;;; 1.1.0 : Wave, zigzag and butt separators
;;;       : - Changed mainline-arrow-shape to mainline-separator-style
;;;       : - styles for wave       / zigzag       / butt
;;;       : - styles for wave-left  / zigzag-left  / butt-left
;;;       : - styles for wave-right / zigzag-right / butt-right
;;; 1.0.4 : Fixed custom vars
;;; 1.0.3 : Fixed usage instructions
;;; 1.0.2 : Added to marmalade - documentation updated, renamed to mainline.
;;;
;;; 1.0.1 : added additional xpm shape chamfer14, adjusted chamfer xpm.
;;;       : mainline-color1, mainline-color2, mainline-arrow-shape
;;;       : - are now custom variables, to make them available via customize.
;;;       : - they could be set from deftheme: custom-theme-set-variables
;;;       : - already, so Emacs24 color themes can set them.
;;;
;;;   1.0 : forked from powerline 0.0.1 - added additional xpm shapes.
;;;
;;; (forked from the original emacs port of vim powerline > Powerline.el Nicolas Rougier)
;;;
;;; Commentary:
;;;
;;; This is a fork of powerline.el which I began while the original
;;; authorship of powerline was unknown,
;;;;;;
;;; -- Using mainline.el.
;;;
;;; Add a require to .emacs / init.el
;;;
;;;     (require 'mainline)
;;;
;;; You can customize the separator graphic by setting the custom variable
;;;
;;;     mainline-separator-style
;;;
;;; possible values...
;;;
;;; - wave
;;; - zigzag
;;; - butt
;;; - wave-left
;;; - zigzag-left
;;; - butt-left
;;; - wave-right
;;; - zigzag-right
;;; - butt-right
;;; - chamfer
;;; - chamfer14 (default)
;;; - rounded
;;; - arrow
;;; - arrow14
;;; - slant
;;; - slant-left
;;; - slant-right
;;; - half
;;; - curve
;;;
;;; For screenshots and additional info see the article at
;;; emacsfodder.github.com/blog/powerline-enhanced/ - note the article
;;; refers to the original fork.
;;;
;;; To customize the modeline - simply override the value of mode-line-format,
;;; see the default at the end of the script, as an example.
;;;
;;; You can create your own modeline additions by using the defmainline macro.
;;;
;;; for example, (defmainline row "%4l") provides mainline-row for use
;;; in mode-line-format.
;;;

(defgroup mainline nil
  "Alternative mode line formatting with xpm-bitmap separators")

(defcustom mainline-color1 "#123550"
  "Mainline color background 1"
  :group 'mainline)

(defcustom mainline-color2 "#112230"
  "Mainline color background 2"
  :group 'mainline)

(defcustom mainline-separator-style 'chamfer14
  "Mainline separator stylename, which can be: wave, zigzag, curve, rounded,
half, chamfer, slant, slant-left, slant-right, arrow, which are
all 18px high and chamfer14 and arrow14 which are both 14px high"
  :group 'mainline)

(defvar mainline-minor-modes nil)

(defvar mainline-buffer-size-suffix t
  "when set to true buffer size is shown as K/Mb/Gb etc.")

(defun wave-right-xpm
  (color1 color2)
  "Return an XPM wave right."
  (create-image
   (format "/* XPM */
static char * wave_right[] = {
\"12 18 2 1\",
\"@ c %s\",
\"  c %s\",
\"           @\",
\"         @@@\",
\"        @@@@\",
\"       @@@@@\",
\"       @@@@@\",
\"       @@@@@\",
\"      @@@@@@\",
\"      @@@@@@\",
\"      @@@@@@\",
\"     @@@@@@@\",
\"     @@@@@@@\",
\"     @@@@@@@\",
\"    @@@@@@@@\",
\"    @@@@@@@@\",
\"    @@@@@@@@\",
\"   @@@@@@@@@\",
\"  @@@@@@@@@@\",
\"@@@@@@@@@@@@\"};"
           (if color2 color2 "None")
           (if color1 color1 "None"))
   'xpm t :ascent 'center))

(defun wave-left-xpm
  (color1 color2)
  "Return an XPM wave left."
  (create-image
   (format "/* XPM */
static char * wave_left[] = {
\"12 18 2 1\",
\"@ c %s\",
\"  c %s\",
\"@           \",
\"@@@         \",
\"@@@@        \",
\"@@@@@       \",
\"@@@@@       \",
\"@@@@@       \",
\"@@@@@@      \",
\"@@@@@@      \",
\"@@@@@@      \",
\"@@@@@@@     \",
\"@@@@@@@     \",
\"@@@@@@@     \",
\"@@@@@@@@    \",
\"@@@@@@@@    \",
\"@@@@@@@@    \",
\"@@@@@@@@@   \",
\"@@@@@@@@@@  \",
\"@@@@@@@@@@@@\"};"
           (if color1 color1 "None")
           (if color2 color2 "None"))
   'xpm t :ascent 'center))

(defun zigzag-left-xpm
  (color1 color2)
  "Return an XPM zigzag left."
  (create-image
   (format "/* XPM */
static char * zigzag_left[] = {
\"12 18 2 1\",
\"@ c %s\",
\"  c %s\",
\"@@@@        \",
\"@@@@@       \",
\"@@@@@@      \",
\"@@@@@@@     \",
\"@@@@@@      \",
\"@@@@@       \",
\"@@@@        \",
\"@@@@@       \",
\"@@@@@@      \",
\"@@@@@@@     \",
\"@@@@@@      \",
\"@@@@@       \",
\"@@@@        \",
\"@@@@@       \",
\"@@@@@@      \",
\"@@@@@@@     \",
\"@@@@@@      \",
\"@@@@@       \"};"
           (if color1 color1 "None")
           (if color2 color2 "None"))
   'xpm t :ascent 'center))

(defun zigzag-right-xpm
  (color1 color2)
  "Return an XPM zigzag right."
  (create-image
   (format "/* XPM */
static char * zigzag_right[] = {
\"12 18 2 1\",
\"@ c %s\",
\"  c %s\",
\"        @@@@\",
\"       @@@@@\",
\"      @@@@@@\",
\"     @@@@@@@\",
\"      @@@@@@\",
\"       @@@@@\",
\"        @@@@\",
\"       @@@@@\",
\"      @@@@@@\",
\"     @@@@@@@\",
\"      @@@@@@\",
\"       @@@@@\",
\"        @@@@\",
\"       @@@@@\",
\"      @@@@@@\",
\"     @@@@@@@\",
\"      @@@@@@\",
\"       @@@@@\"};"
           (if color2 color2 "None")
           (if color1 color1 "None"))
   'xpm t :ascent 'center))

(defun butt-left-xpm
  (color1 color2)
  "Return an XPM butt left."
  (create-image
   (format "/* XPM */
static char * butt_left[] = {
\"12 18 2 1\",
\"@ c %s\",
\"  c %s\",
\"@@@@@       \",
\"@@@@@@      \",
\"@@@@@@@     \",
\"@@@@@@@     \",
\"@@@@@@@     \",
\"@@@@@@@     \",
\"@@@@@@@     \",
\"@@@@@@@     \",
\"@@@@@@@     \",
\"@@@@@@@     \",
\"@@@@@@@     \",
\"@@@@@@@     \",
\"@@@@@@@     \",
\"@@@@@@@     \",
\"@@@@@@@     \",
\"@@@@@@@     \",
\"@@@@@@      \",
\"@@@@@       \"};"
           (if color1 color1 "None")
           (if color2 color2 "None"))
   'xpm t :ascent 'center))

(defun butt-right-xpm
  (color1 color2)
  "Return an XPM butt right."
  (create-image
   (format "/* XPM */
static char * butt_right[] = {
\"12 18 2 1\",
\"@ c %s\",
\"  c %s\",
\"       @@@@@\",
\"      @@@@@@\",
\"     @@@@@@@\",
\"     @@@@@@@\",
\"     @@@@@@@\",
\"     @@@@@@@\",
\"     @@@@@@@\",
\"     @@@@@@@\",
\"     @@@@@@@\",
\"     @@@@@@@\",
\"     @@@@@@@\",
\"     @@@@@@@\",
\"     @@@@@@@\",
\"     @@@@@@@\",
\"     @@@@@@@\",
\"     @@@@@@@\",
\"      @@@@@@\",
\"       @@@@@\"};"
           (if color2 color2 "None")
           (if color1 color1 "None"))
   'xpm t :ascent 'center))

(defun chamfer-xpm
  (color1 color2)
  "Return an XPM chamfer string representing."
  (create-image
   (format "/* XPM */
static char * chamfer[] = {
\"12 18 2 1\",
\"@ c %s\",
\"  c %s\",
\"@@@@@@@     \",
\"@@@@@@@@    \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \"};"
           (if color1 color1 "None")
           (if color2 color2 "None"))
   'xpm t :ascent 'center))

(defun chamfer14-xpm
  (color1 color2)
  "Return an XPM chamfer string representing."
  (create-image
   (format "/* XPM */
static char * chamfer[] = {
\"12 14 2 1\",
\"@ c %s\",
\"  c %s\",
\"@@@@@@@     \",
\"@@@@@@@@    \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \"};"
           (if color1 color1 "None")
           (if color2 color2 "None"))
   'xpm t :ascent 'center))

(defun rounded-xpm
  (color1 color2)
  "Return an XPM rounded string representing."
  (create-image
   (format "/* XPM */
static char * rounded[] = {
\"12 18 2 1\",
\"@ c %s\",
\"  c %s\",
\"@@@@        \",
\"@@@@@@      \",
\"@@@@@@@     \",
\"@@@@@@@@    \",
\"@@@@@@@@    \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \"};"
           (if color1 color1 "None")
           (if color2 color2 "None"))
   'xpm t :ascent 'center))


(defun slant-left-xpm
  (color1 color2)
  "Return an XPM left slant string representing."
  (create-image
   (format "/* XPM */
static char * slant_left[] = {
\"12 18 2 1\",
\"@ c %s\",
\"  c %s\",
\"@@@@         \",
\"@@@@         \",
\"@@@@@        \",
\"@@@@@        \",
\"@@@@@@       \",
\"@@@@@@       \",
\"@@@@@@@      \",
\"@@@@@@@      \",
\"@@@@@@@@     \",
\"@@@@@@@@     \",
\"@@@@@@@@@    \",
\"@@@@@@@@@    \",
\"@@@@@@@@@@   \",
\"@@@@@@@@@@   \",
\"@@@@@@@@@@@  \",
\"@@@@@@@@@@@  \",
\"@@@@@@@@@@@@ \",
\"@@@@@@@@@@@@\"};"
           (if color1 color1 "None")
           (if color2 color2 "None"))
   'xpm t :ascent 'center))

(defun slant-right-xpm
  (color1 color2)
  "Return an XPM right slant string representing@"
  (create-image
   (format "/* XPM */
static char * slant_right[] = {
\"12 18 2 1\",
\"@ c %s\",
\"  c %s\",
\"        @@@@\",
\"        @@@@\",
\"       @@@@@\",
\"       @@@@@\",
\"      @@@@@@\",
\"      @@@@@@\",
\"     @@@@@@@\",
\"     @@@@@@@\",
\"    @@@@@@@@\",
\"    @@@@@@@@\",
\"   @@@@@@@@@\",
\"   @@@@@@@@@\",
\"  @@@@@@@@@@\",
\"  @@@@@@@@@@\",
\" @@@@@@@@@@@\",
\" @@@@@@@@@@@\",
\"@@@@@@@@@@@@\",
\"@@@@@@@@@@@@\"};"
           (if color2 color2 "None")
           (if color1 color1 "None"))
   'xpm t :ascent 'center))

(defun arrow-left-xpm
  (color1 color2)
  "Return an XPM left arrow string representing@"
  (create-image
   (format "/* XPM */
static char * arrow_left[] = {
\"12 18 2 1\",
\"@ c %s\",
\"  c %s\",
\"@           \",
\"@@          \",
\"@@@         \",
\"@@@@        \",
\"@@@@@       \",
\"@@@@@@      \",
\"@@@@@@@     \",
\"@@@@@@@@    \",
\"@@@@@@@@@   \",
\"@@@@@@@@@   \",
\"@@@@@@@@    \",
\"@@@@@@@     \",
\"@@@@@@      \",
\"@@@@@       \",
\"@@@@        \",
\"@@@         \",
\"@@          \",
\"@           \"};"
           (if color1 color1 "None")
           (if color2 color2 "None"))
   'xpm t :ascent 'center))

(defun arrow-right-xpm
  (color1 color2)
  "Return an XPM right arrow string representing@"
  (create-image
   (format "/* XPM */
static char * arrow_right[] = {
\"12 18 2 1\",
\"@ c %s\",
\"  c %s\",
\"           @\",
\"          @@\",
\"         @@@\",
\"        @@@@\",
\"       @@@@@\",
\"      @@@@@@\",
\"     @@@@@@@\",
\"    @@@@@@@@\",
\"   @@@@@@@@@\",
\"   @@@@@@@@@\",
\"    @@@@@@@@\",
\"     @@@@@@@\",
\"      @@@@@@\",
\"       @@@@@\",
\"        @@@@\",
\"         @@@\",
\"          @@\",
\"           @\"};"
           (if color2 color2 "None")
           (if color1 color1 "None"))
   'xpm t :ascent 'center))

(defun arrow14-left-xpm
  (color1 color2)
  "Return an XPM left arrow string representing@"
  (create-image
   (format "/* XPM */
static char * arrow_left[] = {
\"12 14 2 1\",
\"@ c %s\",
\"  c %s\",
\"@           \",
\"@@          \",
\"@@@         \",
\"@@@@        \",
\"@@@@@       \",
\"@@@@@@      \",
\"@@@@@@@     \",
\"@@@@@@@     \",
\"@@@@@@      \",
\"@@@@@       \",
\"@@@@        \",
\"@@@         \",
\"@@          \",
\"@           \"};"
           (if color1 color1 "None")
           (if color2 color2 "None"))
   'xpm t :ascent 'center))

(defun arrow14-right-xpm
  (color1 color2)
  "Return an XPM right arrow string representing@"
  (create-image
   (format "/* XPM */
static char * arrow_right[] = {
\"12 14 2 1\",
\"@ c %s\",
\"  c %s\",
\"           @\",
\"          @@\",
\"         @@@\",
\"        @@@@\",
\"       @@@@@\",
\"      @@@@@@\",
\"     @@@@@@@\",
\"     @@@@@@@\",
\"      @@@@@@\",
\"       @@@@@\",
\"        @@@@\",
\"         @@@\",
\"          @@\",
\"           @\"};"
           (if color2 color2 "None")
           (if color1 color1 "None"))
   'xpm t :ascent 'center))

(defun curve-right-xpm
  (color1 color2)
  "Return an XPM right curve string representing@"
  (create-image
   (format "/* XPM */
static char * curve_right[] = {
\"12 18 2 1\",
\"@ c %s\",
\"  c %s\",
\"           @\",
\"         @@@\",
\"         @@@\",
\"       @@@@@\",
\"       @@@@@\",
\"       @@@@@\",
\"      @@@@@@\",
\"      @@@@@@\",
\"      @@@@@@\",
\"      @@@@@@\",
\"      @@@@@@\",
\"      @@@@@@\",
\"       @@@@@\",
\"       @@@@@\",
\"       @@@@@\",
\"         @@@\",
\"         @@@\",
\"           @\"};"
           (if color2 color2 "None")
           (if color1 color1 "None"))
   'xpm t :ascent 'center))

(defun curve-left-xpm
  (color1 color2)
  "Return an XPM left curve string representing@"
  (create-image
   (format "/* XPM */
static char * curve_left[] = {
\"12 18 2 1\",
\"@ c %s\",
\"  c %s\",
\"@           \",
\"@@@         \",
\"@@@         \",
\"@@@@@       \",
\"@@@@@       \",
\"@@@@@       \",
\"@@@@@@      \",
\"@@@@@@      \",
\"@@@@@@      \",
\"@@@@@@      \",
\"@@@@@@      \",
\"@@@@@@      \",
\"@@@@@       \",
\"@@@@@       \",
\"@@@@@       \",
\"@@@         \",
\"@@@         \",
\"@           \"};"
           (if color1 color1 "None")
           (if color2 color2 "None"))
   'xpm t :ascent 'center))

(defun make-xpm
  (name color1 color2 data)
  "Return an XPM image for lol data"
  (create-image
   (concat
    (format "/* XPM */
static char * %s[] = {
\"%i %i 2 1\",
\"@ c %s\",
\"  c %s\",
"
            (downcase (replace-regexp-in-string " " "_" name))
            (length (car data))
            (length data)
            (if color1 color1 "None")
            (if color2 color2 "None"))
    (let ((len  (length data))
          (idx  0))
      (apply 'concat
             (mapcar '(lambda (dl)
                        (setq idx (+ idx 1))
                        (concat
                         "\""
                         (concat
                          (mapcar '(lambda (d)
                                     (if (eq d 0)
                                         (string-to-char " ")
                                       (string-to-char ".")))
                                  dl))
                         (if (eq idx len)
                             "\"};"
                           "\",\n")))
                     data))))
   'xpm t :ascent 'center))

(defun half-xpm
  (color1 color2)
  (make-xpm "half" color1 color2
            (make-list 18
                       (append (make-list 6 0)
                               (make-list 6 1)))))

(defun percent-xpm
  (pmax pmin we ws width color1 color2)
  (let* ((fs (if (eq pmin ws)
                 0
               (round (* 17 (/ (float ws) (float pmax))))))
         (fe (if (eq pmax we)
                 17
               (round (* 17 (/ (float we) (float pmax))))))
         (o nil)
         (i 0))
    (while (< i 18)
      (setq o (cons
               (if (and (<= fs i)
                        (<= i fe))
                   (append (list 0) (make-list width 1) (list 0))
                 (append (list 0) (make-list width 0) (list 0)))
               o))
      (setq i (+ i 1)))
    (make-xpm "percent" color1 color2 (reverse o))))


;; from memoize.el @ http://nullprogram.com/blog/2010/07/26/
(defun memoize (func)
  "Memoize the given function. If argument is a symbol then
install the memoized function over the original function."
  (typecase func
    (symbol (fset func (memoize-wrap (symbol-function func))) func)
    (function (memoize-wrap func))))

(defun memoize-wrap (func)
  "Return the memoized version of the given function."
  (let ((table-sym (gensym))
        (val-sym (gensym))
        (args-sym (gensym)))
    (set table-sym (make-hash-table :test 'equal))
    `(lambda (&rest ,args-sym)
       ,(concat (documentation func) "\n(memoized function)")
       (let ((,val-sym (gethash ,args-sym ,table-sym)))
         (if ,val-sym
             ,val-sym
           (puthash ,args-sym (apply ,func ,args-sym) ,table-sym))))))

(memoize 'wave-left-xpm)
(memoize 'zigzag-left-xpm)
(memoize 'butt-left-xpm)
(memoize 'wave-right-xpm)
(memoize 'zigzag-right-xpm)
(memoize 'butt-right-xpm)
(memoize 'rounded-xpm)
(memoize 'chamfer-xpm)
(memoize 'chamfer14-xpm)
(memoize 'slant-left-xpm)
(memoize 'slant-right-xpm)
(memoize 'arrow-left-xpm)
(memoize 'arrow-right-xpm)
(memoize 'arrow14-left-xpm)
(memoize 'arrow14-right-xpm)
(memoize 'curve-left-xpm)
(memoize 'curve-right-xpm)
(memoize 'half-xpm)
(memoize 'percent-xpm)

(defun mainline-make-face
  (bg &optional fg)
  (if bg
      (let ((cface (intern (concat "mainline-"
                                   bg
                                   "-"
                                   (if fg
                                       (format "%s" fg)
                                     "white")))))
        (make-face cface)2
        (if fg
            (if (eq fg 0)
                (set-face-attribute cface nil
                                    :background bg
                                    :box nil)
              (set-face-attribute cface nil
                                  :foreground fg
                                  :background bg
                                  :box nil))
          (set-face-attribute cface nil
                              :foreground "white"
                              :background bg
                              :box nil))
        cface)
    nil))

(defun mainline-make-left
  (string color1 &optional color2 localmap)
  (let ((plface (mainline-make-face color1))
        (arrow  (and color2 (not (string= color1 color2)))))
    (concat
     (if (or (not string) (string= string ""))
         ""
       (propertize " " 'face plface))
     (if string
         (if localmap
             (propertize string 'face plface 'mouse-face plface 'local-map localmap)
           (propertize string 'face plface))
       "")
     (if arrow
         (propertize " " 'face plface)
       "")
     (if arrow
         (propertize " " 'display
                     (cond
                      ((eq mainline-separator-style 'arrow       ) (arrow-left-xpm color1 color2))
                      ((eq mainline-separator-style 'slant       ) (slant-left-xpm color1 color2))
                      ((eq mainline-separator-style 'wave        ) (wave-left-xpm color1 color2))
                      ((eq mainline-separator-style 'zigzag      ) (zigzag-left-xpm color1 color2))
                      ((eq mainline-separator-style 'butt        ) (butt-left-xpm color1 color2))
                      ((eq mainline-separator-style 'chamfer     ) (chamfer-xpm color1 color2))
                      ((eq mainline-separator-style 'chamfer14   ) (chamfer14-xpm color1 color2))
                      ((eq mainline-separator-style 'rounded     ) (rounded-xpm color1 color2))
                      ((eq mainline-separator-style 'slant-left  ) (slant-left-xpm color1 color2))
                      ((eq mainline-separator-style 'slant-right ) (slant-right-xpm color1 color2))
                      ((eq mainline-separator-style 'wave-left   ) (wave-left-xpm color1 color2))
                      ((eq mainline-separator-style 'zigzag-left ) (zigzag-left-xpm color1 color2))
                      ((eq mainline-separator-style 'butt-left   ) (butt-left-xpm color1 color2))
                      ((eq mainline-separator-style 'wave-right  ) (wave-right-xpm color1 color2))
                      ((eq mainline-separator-style 'zigzag-right) (zigzag-right-xpm color1 color2))
                      ((eq mainline-separator-style 'butt-right  ) (butt-right-xpm color1 color2))
                      ((eq mainline-separator-style 'arrow14     ) (arrow14-left-xpm color1 color2))
                      ((eq mainline-separator-style 'curve       ) (curve-left-xpm color1 color2))
                      ((eq mainline-separator-style 'half        ) (half-xpm color2 color1))
                      (t
                       (arrow-left-xpm color1 color2)))
                     'local-map (make-mode-line-mouse-map
                                 'mouse-1 (lambda () (interactive)
                                            (setq mainline-separator-style
                                                  (cond ((eq mainline-separator-style 'chamfer)      'chamfer14)
                                                        ((eq mainline-separator-style 'chamfer14)    'rounded)
                                                        ((eq mainline-separator-style 'rounded)      'zigzag)
                                                        ((eq mainline-separator-style 'zigzag)       'wave)
                                                        ((eq mainline-separator-style 'wave)         'butt)
                                                        ((eq mainline-separator-style 'butt)         'arrow)
                                                        ((eq mainline-separator-style 'arrow)        'slant)
                                                        ((eq mainline-separator-style 'slant)        'slant-left)
                                                        ((eq mainline-separator-style 'slant-left)   'slant-right)
                                                        ((eq mainline-separator-style 'slant-right)  'wave-left)
                                                        ((eq mainline-separator-style 'wave-left)    'zigzag-left)
                                                        ((eq mainline-separator-style 'zigzag-left)  'butt-left)
                                                        ((eq mainline-separator-style 'butt-left)    'wave-right)
                                                        ((eq mainline-separator-style 'wave-right)   'zigzag-right)
                                                        ((eq mainline-separator-style 'zigzag-right) 'butt-right)
                                                        ((eq mainline-separator-style 'butt-right)   'arrow14)
                                                        ((eq mainline-separator-style 'arrow14)      'curve)
                                                        ((eq mainline-separator-style 'curve)        'half)
                                                        ((eq mainline-separator-style 'half)         'chamfer)
                                                        (t                                           'chamfer)))
                                            (redraw-modeline))))
       ""))))

(defun mainline-make-right
  (string color2 &optional color1 localmap)
  (let ((plface (mainline-make-face color2))
        (arrow  (and color1 (not (string= color1 color2)))))
    (concat
     (if arrow
         (propertize " " 'display
                     (cond
                      ((eq mainline-separator-style 'arrow       ) (arrow-right-xpm color1 color2))
                      ((eq mainline-separator-style 'slant       ) (slant-right-xpm color1 color2))
                      ((eq mainline-separator-style 'wave        ) (wave-right-xpm color1 color2))
                      ((eq mainline-separator-style 'zigzag      ) (zigzag-right-xpm color1 color2))
                      ((eq mainline-separator-style 'butt        ) (butt-right-xpm color1 color2))
                      ((eq mainline-separator-style 'rounded     ) (rounded-xpm color1 color2))
                      ((eq mainline-separator-style 'chamfer     ) (chamfer-xpm color1 color2))
                      ((eq mainline-separator-style 'chamfer14   ) (chamfer14-xpm color1 color2))
                      ((eq mainline-separator-style 'slant-left  ) (slant-left-xpm color1 color2))
                      ((eq mainline-separator-style 'slant-right ) (slant-right-xpm color1 color2))
                      ((eq mainline-separator-style 'wave-left   ) (wave-left-xpm color1 color2))
                      ((eq mainline-separator-style 'zigzag-left ) (zigzag-left-xpm color1 color2))
                      ((eq mainline-separator-style 'butt-left   ) (butt-left-xpm color1 color2))
                      ((eq mainline-separator-style 'wave-right  ) (wave-right-xpm color1 color2))
                      ((eq mainline-separator-style 'zigzag-right) (zigzag-right-xpm color1 color2))
                      ((eq mainline-separator-style 'butt-right  ) (butt-right-xpm color1 color2))
                      ((eq mainline-separator-style 'arrow14     ) (arrow14-right-xpm color1 color2))
                      ((eq mainline-separator-style 'curve       ) (curve-right-xpm color1 color2))
                      ((eq mainline-separator-style 'half        ) (half-xpm color2 color1))
                      (t
                       (arrow-right-xpm color1 color2)))
                     'local-map (make-mode-line-mouse-map
                                 'mouse-1 (lambda () (interactive)
                                            (setq mainline-separator-style
                                                  (cond ((eq mainline-separator-style 'chamfer)      'chamfer14)
                                                        ((eq mainline-separator-style 'chamfer14)    'rounded)
                                                        ((eq mainline-separator-style 'rounded)      'zigzag)
                                                        ((eq mainline-separator-style 'zigzag)       'wave)
                                                        ((eq mainline-separator-style 'wave)         'butt)
                                                        ((eq mainline-separator-style 'butt)         'arrow)
                                                        ((eq mainline-separator-style 'arrow)        'slant)
                                                        ((eq mainline-separator-style 'slant)        'slant-left)
                                                        ((eq mainline-separator-style 'slant-left)   'slant-right)
                                                        ((eq mainline-separator-style 'slant-right)  'wave-left)
                                                        ((eq mainline-separator-style 'wave-left)    'zigzag-left)
                                                        ((eq mainline-separator-style 'zigzag-left)  'butt-left)
                                                        ((eq mainline-separator-style 'butt-left)    'wave-right)
                                                        ((eq mainline-separator-style 'wave-right)   'zigzag-right)
                                                        ((eq mainline-separator-style 'zigzag-right) 'butt-right)
                                                        ((eq mainline-separator-style 'butt-right)   'arrow14)
                                                        ((eq mainline-separator-style 'arrow14)      'curve)
                                                        ((eq mainline-separator-style 'curve)        'half)
                                                        ((eq mainline-separator-style 'half)         'chamfer)
                                                        (t                                           'chamfer)))
                                            (redraw-modeline))))
       "")
     (if arrow
         (propertize " " 'face plface)
       "")
     (if string
         (if localmap
             (propertize string 'face plface 'mouse-face plface 'local-map localmap)
           (propertize string 'face plface))
       "")
     (if (or (not string) (string= string ""))
         ""
       (propertize " " 'face plface)))))

(defun mainline-make-fill
  (color)
  ;; justify right by filling with spaces to right fringe, 20 should be calculated
  (let ((plface (mainline-make-face color)))
    (if (eq 'right (get-scroll-bar-mode))
        (propertize " " 'display '((space :align-to (- right-fringe 21)))
                    'face plface)
      (propertize " " 'display '((space :align-to (- right-fringe 24)))
                  'face plface))))

(defun mainline-make-text
  (string color &optional fg localmap)
  (let ((plface (mainline-make-face color)))
    (if string
        (if localmap
            (propertize string 'face plface 'mouse-face plface 'local-map localmap)
          (propertize string 'face plface))
      "")))

(defun mainline-make (side string color1 &optional color2 localmap)
  (cond ((and (eq side 'right) color2) (mainline-make-right  string color1 color2 localmap))
        ((and (eq side 'left) color2)  (mainline-make-left   string color1 color2 localmap))
        ((eq side 'left)               (mainline-make-left   string color1 color1 localmap))
        ((eq side 'right)              (mainline-make-right  string color1 color1 localmap))
        (t                             (mainline-make-text   string color1 localmap))))

(defmacro defmainline (name string)
  `(defun ,(intern (concat "mainline-" (symbol-name name)))
     (side color1 &optional color2)
     (mainline-make side
                    ,string
                    color1 color2)))

(defun mainline-mouse (click-group click-type string)
  (cond ((eq click-group 'minor)
         (cond ((eq click-type 'menu)
                `(lambda (event)
                   (interactive "@e")
                   (minor-mode-menu-from-indicator ,string)))
               ((eq click-type 'help)
                `(lambda (event)
                   (interactive "@e")
                   (describe-minor-mode-from-indicator ,string)))
               (t
                `(lambda (event)
                   (interactive "@e")
                   nil))))
        (t
         `(lambda (event)
            (interactive "@e")
            nil))))

(defmainline arrow       "")

(defmainline buffer-id   (propertize (car (propertized-buffer-identification "%12b"))
                                     'face (mainline-make-face color1)))

(defmainline buffer-size (propertize
                          (if mainline-buffer-size-suffix
                              "%I"
                            "%i")
                          'local-map (make-mode-line-mouse-map
                                      'mouse-1 (lambda () (interactive)
                                                 (setq mainline-buffer-size-suffix
                                                       (not mainline-buffer-size-suffix))
                                                 (redraw-modeline)))))
(defmainline rmw "%*")

(defmainline major-mode
  (propertize mode-name
              'help-echo "Major mode\n\ mouse-1: Display major mode menu\n\ mouse-2: Show help for major mode\n\ mouse-3: Toggle minor modes"
              'local-map (let ((map (make-sparse-keymap)))
                           (define-key map [mode-line down-mouse-1]
                             `(menu-item ,(purecopy "Menu Bar") ignore
                                         :filter (lambda (_) (mouse-menu-major-mode-map))))
                           (define-key map [mode-line mouse-2] 'describe-mode)
                           (define-key map [mode-line down-mouse-3] mode-line-mode-menu)
                           map)))

(defmainline minor-modes
  (let ((mms (split-string (format-mode-line minor-mode-alist))))
    (apply 'concat
           (mapcar '(lambda (mm)
                      (propertize (if (string= (car mms) mm)
                                      mm
                                    (concat " " mm))
                                  'help-echo "Minor mode\n mouse-1: Display minor mode menu\n mouse-2: Show help for minor mode\n mouse-3: Toggle minor modes"
                                  'local-map (let ((map (make-sparse-keymap)))
                                               (define-key map [mode-line down-mouse-1]   (mainline-mouse 'minor 'menu mm))
                                               (define-key map [mode-line mouse-2]        (mainline-mouse 'minor 'help mm))
                                               (define-key map [mode-line down-mouse-3]   (mainline-mouse 'minor 'menu mm))
                                               (define-key map [header-line down-mouse-3] (mainline-mouse 'minor 'menu mm))
                                               map))) mms))))
(defmainline row "%4l")
(defmainline column "%3c")
(defmainline percent "%6p")

(defmainline narrow (let (real-point-min real-point-max)
                      (save-excursion
                        (save-restriction
                          (widen)
                          (setq real-point-min (point-min) real-point-max (point-max))))
                      (when (or (/= real-point-min (point-min))
                                (/= real-point-max (point-max)))
                        (propertize "Narrow"
                                    'help-echo "mouse-1: Remove narrowing from the current buffer"
                                    'local-map (make-mode-line-mouse-map
                                                'mouse-1 'mode-line-widen)))))
(defmainline status      "%s")
(defmainline emacsclient mode-line-client)
(defmainline vc vc-mode)

(defmainline
  percent-xpm
  (propertize "  "
              'display
              (let (pmax
                    pmin
                    (ws (window-start))
                    (we (window-end)))
                (save-restriction
                  (widen)
                  (setq pmax (point-max))
                  (setq pmin (point-min)))
                (percent-xpm
                 pmax pmin
                 we ws 5
                 color1 color2))))

(setq-default
 mode-line-format
 (list "%e"
       '(:eval (concat
                (mainline-rmw            'left   nil  )
                (mainline-buffer-id      'left   nil  mainline-color1  )
                (mainline-major-mode     'left        mainline-color1  )
                (mainline-minor-modes    'left        mainline-color1  )
                (mainline-narrow         'left        mainline-color1   mainline-color2  )
                (mainline-vc             'center                        mainline-color2  )
                (mainline-make-fill                                     mainline-color2  )
                (mainline-row            'right       mainline-color1   mainline-color2  )
                (mainline-make-text      ":"          mainline-color1  )
                (mainline-column         'right       mainline-color1  )
                (mainline-percent-xpm    'right  nil  mainline-color1  )
                (mainline-make-text      "  "    nil  )))))

(provide 'mainline)

;;; mainline.el ends here
