(setq user-full-name "Junio Koi"
      user-mail-address "53125029+Juniokoi@users.noreply.github.com")

(setq custom-tab-width 4)

(setq scroll-margin 7)             ;; Vertical Margin while scrolling
(setq hscroll-margin 16)           ;; Horizon Margin
(pixel-scroll-mode 0)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-follow-mouse 't)

(xterm-mouse-mode 1)
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

(use-package highlight-indent-guides
  :hook (prog-mode . highlight-indent-guides-mode)
  :hook (org-mode . highlight-indent-guides-mode))

(after! highlight-indent-guides
  (setq highlight-indent-guides-method 'bitmap)
  ;;(setq highlight-indent-guides-character ?┆) ;; Examples: ┆¦│⎸ ▏
  (setq highlight-indent-guides-auto-enabled 'top)
  (setq highlight-indent-guides-responsive 'top)
  (set-face-attribute 'highlight-indent-guides-odd-face nil :inherit 'highlight-indentation-odd-face)
  (set-face-attribute 'highlight-indent-guides-even-face nil :inherit 'highlight-indentation-even-face)
  (set-face-foreground 'highlight-indent-guides-character-face "dimgray" )
  (set-face-background 'highlight-indent-guides-character-face nil ))

(defun disable-tabs () (setq indent-tabs-mode nil))
(defun enable-tabs  ()
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  (setq indent-tabs-mode t)
  (setq tab-width custom-tab-width)
  (setq-default evil-shift-width custom-tab-width)
  (setq backward-delete-char-untabify-method 'hungry))

;; Hook to enable tabs
(add-hook 'prog-mode-hook 'enable-tabs)
(add-hook 'lisp-mode-hook 'enable-tabs)
(add-hook 'emacs-lisp-mode-hook 'enable-tabs)
;; Hooks to Disable Tabs
; (add-hook 'lisp-mode-hook 'disable-tabs)
; (add-hook 'emacs-lisp-mode-hook 'disable-tabs)

;; Style indent with bar (ie:│)
(setq whitespace-style '(face tabs tab-mark trailing))
(custom-set-faces
 '(whitespace-tab ((t (:foreground "#636363")))))
(setq whitespace-display-mappings
      '((tab-mark 9 [124 9] [92 9]))) ; 124 is the ascii ID for '\|'
(global-whitespace-mode)

;;Settings
(map! :leader
      :desc "Comment or uncomment lines" "TAB TAB" #'comment-line
      (:prefix ("t" . "toggle")

       :desc "Toggle line highlight in frame" "h" #'hl-line-mode
       :desc "Toggle line highlight globally" "H" #'global-hl-line-mode
       :desc "Toggle truncate lines" "t" #'toggle-truncate-lines))


(beacon-mode 1)
(setq beacon-color "#bfafdf")

(use-package emojify
  :hook (after-init . global-emojify-mode))

(set-face-attribute 'mode-line nil :font "Ubuntu Mono")
(setq doom-modeline-height 30     ;; sets modeline height
      doom-modeline-bar-width 5   ;; sets right bar width
      doom-modeline-persp-name t  ;; adds perspective name to modeline
      doom-modeline-persp-icon t) ;; adds folder icon next to persp name

(define-globalized-minor-mode global-rainbow-mode rainbow-mode
  (lambda ()
    (when (not (memq major-mode
                     (list 'org-agenda-mode)))

      (rainbow-mode 1))))
(global-rainbow-mode 1)

(after! neotree
  (setq neo-smart-open t
        neo-window-fixed-size nil))
(after! doom-themes
  (setq doom-neotree-enable-variable-pitch t))

(map! :leader
      :desc "Toggle neotree file viewer" "t n" #'neotree-toggle
      :desc "Open directory in neotree" "d n" #'neotree-dir)

(setq ibuffer-saved-filter-groups
      '(("Config" (or
                   (filename . ".dots/")
                   (filename . ".emacs.d/")))
        ("Dired"  (mode . dired-mode))
        ("Org"    (mode . org-mode))
        ("Emacs" (name . "^\\*.*\\*$")))

      ibuffer-show-empty-filter-groups nil)

(map! :leader
      (:prefix ("b". "buffer")
       :desc "List bookmarks" "L" #'list-bookmarks
       :desc "Save current bookmarks to bookmark file" "w" #'bookmark-save))

(evil-define-key 'normal ibuffer-mode-map
  (kbd "f c") 'ibuffer-filter-by-content
  (kbd "f d") 'ibuffer-filter-by-directory
  (kbd "f f") 'ibuffer-filter-by-filename
  (kbd "f m") 'ibuffer-filter-by-mode
  (kbd "f n") 'ibuffer-filter-by-name
  (kbd "f x") 'ibuffer-filter-disable
  (kbd "g h") 'ibuffer-do-kill-lines
  (kbd "g H") 'ibuffer-update)

(setq display-line-numbers-type 'relative)

(after! magit
  (magit-wip-after-save-mode t)
  (magit-wip-after-apply-mode t)

  (setq magit-save-repository-buffers 'dontask
        magit-repository-directories '(("/home/junio/www/" . 3)
                                       ("/home/junio/.dotfiles/" . 0))
        magit-popup-display-buffer-action nil ;; Not sure why this is here, wonder what it does
        magit-display-file-buffer-function #'switch-to-buffer-other-window
        magithub-clone-default-directory "~/www" ;; I want my stuff to clone to ~/projects
        magithub-preferred-remote-method 'ssh_url)) ;; HTTPS cloning is awful, i authenticate with ssh keys.

(after! org
  (setq
 org-directory "~/org/"
        org-agenda-files '("~/jk/Org/agenda.org")
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-log-done 'time
        org-hide-emphasis-markers t
        ;; ex. of org-link-abbrev-alist in action
        ;; [[arch-wiki:Name_of_Page][Description]]
        org-link-abbrev-alist    ; This overwrites the default Doom org-link-abbrev-list
        '(("google" . "http://www.google.com/search?q=")
          ("arch-wiki" . "https://wiki.archlinux.org/index.php/")
          ("ddg" . "https://duckduckgo.com/?q=")
          ("wiki" . "https://en.wikipedia.org/wiki/"))
        org-table-convert-region-max-lines 20000
        org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
        '((sequence
           "TODO(t)"           ; A task that is ready to be tackled
           "BLOG(b)"           ; Blog writing assignments
           "PROJ(p)"           ; A project that contains other tasks
           "VIDEO(v)"          ; Video assignments
           "WAIT(w)"           ; Something is holding up this task
           "|"                 ; The pipe necessary to separate "active" states and "inactive" states
           "DONE(d)"           ; Task has been completed
           "CANCELLED(c)")))) ; Task has been cancelled

(after! org
    (setq
     org-ellipsis " ⋯ "
     org-superstar-headline-bullets-list '("" "◉" "●" "○" "•") ;;⁖ <- if 1. dont work
     org-superstar-item-bullet-alist '((?+ . ?➤) (?- . ?✦)))) ; changes +/- symbols in item lists
(with-eval-after-load 'org-superstar
  (set-face-attribute 'org-superstar-item nil :height 1.0)
  (set-face-attribute 'org-superstar-header-bullet nil :height 0.8)
  (set-face-attribute 'org-superstar-leading nil :height 1.3))

(setq org-indent-indentation-per-level 4)
(setq org-src-tab-acts-natively t)
(setq org-startup-indented t)
(setq org-adapt-indentation t)

(map! :leader
      (:prefix ("=" . "open file")
       :desc "Edit agenda file" "a" #'(lambda () (interactive) (find-file "~/Org/agenda.org"))
       :desc "Edit doom config.org" "c" #'(lambda () (interactive) (find-file "~/.config/doom/config.org"))
       :desc "Edit doom init.el" "i" #'(lambda () (interactive) (find-file "~/.config/doom/init.el"))
       :desc "Edit doom packages.el" "p" #'(lambda () (interactive) (find-file "~/.config/doom/packages.el"))))

(with-eval-after-load 'org
  (setq org-hide-emphasis-markers t)
  (defun org-toggle-emphasis ()
    "Toggle hiding/showing of org emphasize markers."
    (interactive)
    (if org-hide-emphasis-markers
        (set-variable 'org-hide-emphasis-markers nil)
      (set-variable 'org-hide-emphasis-markers t))
    (org-mode-restart))
  (bind-key (kbd "C-c e") 'org-toggle-emphasis org-mode-map))

(custom-set-faces
 '(markdown-header-face ((t (:inherit font-lock-function-name-face :weight bold :family "variable-pitch"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.5))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.4))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.3))))
 '(markdown-header-face-4 ((t (:inherit markdown-header-face :height 1.2))))
 '(markdown-header-face-5 ((t (:inherit markdown-header-face :height 1.0))))
 '(markdown-header-face-6 ((t (:inherit markdown-header-face :height 1.0)))))

(setq org-journal-dir "~/jk/Org/journal/"
      org-journal-date-prefix "* "
      org-journal-time-prefix "** "
      org-journal-date-format "%B %d, %Y (%A) "
      org-journal-file-format "%Y-%m-%d.org")

(use-package! org-roam
  :ensure t
  :custom
  (org-roam-directory "~/jk/OrgRoam")
  (org-roam-complete-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i"   . completion-at-point))
  :config
  (org-roam-setup))

(setq org-fontify-whole-heading-line t
      ;; I've included these to maximize compatibility with doom-themes in general
      org-fontify-done-headline t
      org-fontify-quote-and-verse-blocks t)
  (defun jk/org-colors-catppuccin ()
  "Enable Catppuccin colors for Org headers."
  (interactive)
  (dolist
      (face
       '((org-level-1 1.4 "#fab387" "#241E29" ultra-bold);;Peach
         (org-level-2 1.3 "#f38ba8" "#29222F" normal)    ;;Red
         (org-level-3 1.2 "#cba6f7" "#332B3B" normal)    ;;Mauve
         (org-level-4 1.1 "#89b4fa" "#2B313B" normal)    ;;Blue
         (org-level-5 1.0 "#74c7ec" "#2B363B" normal)    ;;Sapphire
         (org-level-6 1.0 "#a6e3a1" "#2D3B2B" normal)    ;;Green
         (org-level-7 1.0 "#f9e2af" "#3B362B" normal)    ;;Yellow
         (org-level-8 1.0 "#fab387" "#3B312B" normal)))  ;;Pearh
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 4 face) :height (nth 1 face) :foreground (nth 2 face) :background (nth 3 face)))
    (set-face-attribute 'org-hide nil :inherit 'fixed-pitch)
    (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bac2de"))

(after! parinfer
  (setq parinfer-auto-switch-indent-mode t))

(after! company
  (setq company-tooltip-limit 5
        company-tooltip-minimum-width 80
        company-tooltip-minimum 5
        company-backends
        '(company-capf company-dabbrev company-files company-yasnippet)))

(after! company-box
  (setq company-box-max-candidates 5))

(setq frame-resize-pixelwise t)

(after! all-the-icons
  (setq all-the-icons-scale-factor 1.0))

(setq show-trailing-whitespace nil)

(setq eldoc-idle-delay 2)

(setq doom-font (font-spec :family "Iosevkoi" :size 20))

(setq doom-variable-pitch-font (font-spec :family "Ubuntu mono"))

(setq doom-big-font (font-spec :family "Fira Code" :size 25))

(setq doom-serif-font (font-spec :family "Noto Serif"))

(setq doom-theme 'doom-moonlight)

(after! org-faces
 (jk/org-colors-catppuccin))

(after! doom-themes
  (setq
   doom-themes-enable-bold t
   doom-themes-enable-italic t))

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))