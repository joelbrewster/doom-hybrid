;;; doom-hybrid-theme.el --- Colors from Vim Hybrid theme and MacOS Mojave dark mode
(require 'doom-themes)

;;
(defgroup doom-hybrid-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-hybrid-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-hybrid-theme
  :type 'boolean)

(defcustom doom-hybrid-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-hybrid-theme
  :type 'boolean)

(defcustom doom-hybrid-comment-bg doom-hybrid-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-hybrid-theme
  :type 'boolean)

(defcustom doom-hybrid-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-hybrid-theme
  :type '(or integer boolean))

;;
(def-doom-theme doom-hybrid
  "A dark theme inspired by the vim Hybrid theme and Mac OS Mojave"

  ;; name        default   256       16
  ((bg         '("#232323" nil       nil            ))
   (bg-alt     '("#353535" nil       nil            ))
   (base0      '("#101010" "#101010" "black"        ))
   (base1      '("#202020" "#202020" "brightblack"  ))
   (base2      '("#303030" "#303030" "brightblack"  ))
   (base3      '("#404040" "#404040" "brightblack"  ))
   (base4      '("#505050" "#505050" "brightblack"  ))
   (base5      '("#606060" "#606060" "brightblack"  ))
   (base6      '("#707070" "#707070" "brightblack"  ))
   (base7      '("#808080" "#808080" "brightblack"  ))
   (base8      '("#909090" "#909090" "white"        ))
   (fg         '("#C4C4C4" "#C4C4C4" "brightwhite"  ))
   (fg-alt     '("#2D2D2D" "#2D2D2D" "white"        ))

   (grey       base4)
   (red        '("#CC6666" "#CC6666" "red"          ))
   (orange     '("#DE935F" "#DE935F" "brightred"    ))
   (green      '("#B5BD68" "#B5BD68" "green"        ))
   (teal       '("#8ABEB7" "#8ABEB7" "brightgreen"  ))
   (yellow     '("#F0C674" "#F0C674" "yellow"       ))
   (blue       '("#81A2BE" "#81A2BE" "brightblue"   ))
   (dark-blue  '("#5F819D" "#5F819D" "blue"         ))
   (magenta    '("#B294BB" "#B294BB" "brightmagenta"))
   (violet     '("#85678F" "#85678F" "magenta"      ))
   (cyan       '("#8ABEB7" "#8ABEB7" "brightcyan"   ))
   (dark-cyan  '("#5E8D87" "#5E8D87" "cyan"         ))

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   (doom-darken base1 0.1))
   (selection      dark-blue)
   (builtin        magenta)
   (comments       (if doom-hybrid-brighter-comments dark-cyan base5))
   (doc-comments   (doom-lighten (if doom-hybrid-brighter-comments dark-cyan base5) 0.25))
   (constants      violet)
   (functions      magenta)
   (keywords       blue)
   (methods        cyan)
   (operators      blue)
   (type           yellow)
   (strings        green)
   (variables      (doom-lighten magenta 0.4))
   (numbers        orange)
   (region         `(,(doom-lighten (car bg-alt) 0.15) ,@(doom-lighten (cdr base0) 0.35)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg) "black" "black"))
   (-modeline-bright doom-hybrid-brighter-modeline)
   (-modeline-pad
    (when doom-hybrid-padded-modeline
      (if (integerp doom-hybrid-padded-modeline) doom-hybrid-padded-modeline 4)))

   (modeline-fg     nil)
   (modeline-fg-alt base5)

   (modeline-bg
    (if -modeline-bright
        (doom-darken blue 0.475)
      `(,(doom-darken (car bg-alt) 0.15) ,@(cdr base0))))
   (modeline-bg-l
    (if -modeline-bright
        (doom-darken blue 0.45)
      `(,(doom-darken (car bg-alt) 0.1) ,@(cdr base0))))
   (modeline-bg-inactive   `(,(doom-darken (car bg-alt) 0.1) ,@(cdr bg-alt)))
   (modeline-bg-inactive-l `(,(car bg-alt) ,@(cdr base1))))


  ;; --- extra faces ------------------------
  ((elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")

   (evil-goggles-default-face :inherit 'region :background (doom-blend region bg 0.5))

   ((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground fg)

   (font-lock-comment-face
    :foreground comments
    :background (if doom-hybrid-comment-bg (doom-lighten bg 0.05)))
   (font-lock-doc-face
    :inherit 'font-lock-comment-face
    :foreground doc-comments)

   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis
    :foreground (if -modeline-bright base8 highlight))

   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))

   ;; Doom modeline
   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))
   (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'bold)
   (doom-modeline-buffer-path :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-buffer-project-root :foreground green :weight 'bold)

   ;; ivy-mode
   (ivy-current-match :background dark-blue :distant-foreground base0 :weight 'normal)

   ;; --- major-mode faces -------------------
   ;; css-mode / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)

   ;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   (markdown-code-face :background (doom-lighten base3 0.05))

   ;; org-mode
   (org-hide :background hidden)
   (solaire-org-hide-face :foreground hidden))


  ;; --- extra variables ---------------------
  ;; ()
  )

;;; doom-hybrid-theme.el ends here
