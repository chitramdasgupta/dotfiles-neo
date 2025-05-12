;; Diasble the initial splash screen
(setq inhibit-splash-screen t)

;; Makes *scratch* empty.
(setq initial-scratch-message "")

;; Change scratch buffer to org mode
(setq initial-major-mode 'org-mode)

;; Setup emacs default package manager: package.el
(require 'package)
(dolist (repo '(("melpa"        . "http://melpa.org/packages/")
                ("gnu"          . "https://elpa.gnu.org/packages/")
                ("nongnu"       . "https://elpa.nongnu.org/nongnu/")))
  (add-to-list 'package-archives repo))
(package-initialize)

;; Load use-package
(eval-when-compile
  (require 'use-package))

(setq package-install-upgrade-built-in t)

;; Disable creating backup files (the ones ending with ~)
(setq make-backup-files nil)

;; Use utf-8 everywhere
(prefer-coding-system 'utf-8)

;; Specifying a custom file for emacs to write into
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Disable emacs version-control
(setq vc-handled-backends nil)

;; Disable unnecessary resizing
(setq frame-inhibit-implied-resize t)

;; Change yes-or-no to y-or-n
(setq use-short-answers t)

;; Smooth scrolling
(pixel-scroll-precision-mode)

;; Automatically reread from disk if the underlying file changes
(setq auto-revert-interval 1)
(setq auto-revert-check-vc-info t)
(global-auto-revert-mode)

;; Properly render long lines
(global-visual-line-mode t)

;; Setup vim-like keybindings
(use-package evil
  :ensure t
  :init
  (setq evil-respect-visual-line-mode t)
  (setq evil-undo-system 'undo-redo)
  :config
  (setq evil-want-C-i-jump nil)
  (evil-mode 1))

;; DWIM (Do What I Mean) editing
(use-package typo
  :ensure t)

(add-hook 'text-mode-hook 'typo-mode)
(add-hook 'org-mode-hook 'typo-mode)
(add-hook 'markdown-mode-hook 'typo-mode)

;; Font setup
(set-frame-font "BerkeleyMono 15" nil t)
(set-frame-font "Aporetic Sans Mono 15" nil t)

;; Theme
(use-package modus-themes
  :ensure t)

;; Make the mode-line border of the same color as the background
(setq modus-themes-common-palette-overrides
      '((border-mode-line-active unspecified)
        (border-mode-line-inactive unspecified)))

(load-theme 'modus-vivendi-tinted)

;; I prefer to use an orange cursor with the modus-vivendi theme
(setq evil-normal-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("orange" bar))
(setq evil-visual-state-cursor '("orange" hbar))
(blink-cursor-mode -1)

;; Customize dired
;; Adding some colors
(use-package diredfl
  :ensure t)

(add-hook 'dired-mode-hook #'diredfl-mode)

;; Human-readable file-sizes
(setq dired-listing-switches "-alh")

;; Use rainbow delimeters
(use-package rainbow-delimiters
  :ensure t)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Minibuffer
(setq enable-recursive-minibuffers t)

;; saves history in minibuffer for commonly opened files, commands, etc.
(savehist-mode)

;; Remove Emacs visual clutter
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Relative line numbers
(setq display-line-numbers-type 'relative)

(add-hook 'emacs-lisp-mode-hook 'display-line-numbers-mode)
(add-hook 'clojure-mode-hook 'display-line-numbers-mode)

(setq column-number-mode t)

;; Setup markdown and org-mode
(use-package markdown-mode
  :ensure t)

;; Hard text-wrapping occurs after 80 characters for git commits
(add-hook 'text-mode-hook (lambda () (setq fill-column 80)))

(use-package visual-fill-column
  :ensure t)

;; Soft text-wrapping occurs after 90 characters
(setq-default visual-fill-column-width 120)

;; Centers the text
(setq-default visual-fill-column-center-text t)

(add-hook 'org-mode-hook #'visual-fill-column-mode)
(add-hook 'markdown-mode-hook #'visual-fill-column-mode)

(add-hook 'org-mode-hook 'org-indent-mode)

(setq sentence-end-double-space nil)

(use-package org-bullets
  :ensure t)

(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(use-package toc-org
  :ensure t)

(use-package markdown-toc
  :ensure t)
;; To add a table contents simply add a heading with the content, :TOC:, and
;; then save the file

(add-hook 'org-mode-hook 'toc-org-mode)
(add-hook 'markdown-mode-hook 'toc-org-mode)

;; Sensible defaults for the source code blocks
(setq org-src-preserve-indentation nil)
(setq org-edit-src-content-indentation 0)

;; Org-mode increase size of latex preview
(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.75))

;; Org roam
(use-package org-roam
 :ensure t
 :custom
  (org-roam-directory (file-truename "~/Documents/zettelkasten"))
 :bind (("C-c n l" . org-roam-buffer-toggle)
        ("C-c n f" . org-roam-node-find)
        ("C-c n g" . org-roam-graph)
        ("C-c n i" . org-roam-node-insert)
        ("C-c n c" . org-roam-capture))
 :config
(setq org-roam-node-display-template (concat "${title:*}" (propertize "${tags:10}" 'face 'org-tag)))
(org-roam-db-autosync-mode))

(use-package org-roam-ui
    :after org-roam
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

;; Delete trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'markdown-mode-hook (lambda () (add-hook 'before-save-hook 'delete-trailing-whitespace)))
(add-hook 'org-mode-hook (lambda () (add-hook 'before-save-hook 'delete-trailing-whitespace)))

;; Toggle between showing and hiding emphasis markers
(setq org-hide-emphasis-markers t)

(defun org-toggle-emphasis ()
  "Toggle hiding/showing of org emphasize markers."
  (interactive)
  (if org-hide-emphasis-markers
      (setq org-hide-emphasis-markers nil)
    (setq org-hide-emphasis-markers t))
 (org-mode-restart))
(define-key org-mode-map (kbd "C-c e") 'org-toggle-emphasis)

;; For <s TAB completions
(require 'org-tempo)

;; Support Adding UML diagrams in org-mode
(setq org-plantuml-exec-mode 'plantuml)
(setq org-plantuml-command "/usr/bin/plantuml")
(setq org-babel-plantuml-command "/usr/bin/plantuml")

(org-babel-do-load-languages
 'org-babel-load-languages
 '((plantuml . t)))

;; For encryption and decryption
(setq epa-file-cache-passphrase-for-symmetric-encryption t)

;; For encrypting files
(require 'epa-file)
(epa-file-enable)

;; Set up org agenda
(setq org-agenda-files '("~/Documents/emacs/agenda"))

;; Magit - the git porcelain
(use-package magit
  :ensure t)

(setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)
(setq magit-diff-refine-hunk t)
(setq magit-diff-refine-ignore-whitespace nil)

;; Better completion for minibuffer commands
(use-package vertico
  :ensure t
  :init (vertico-mode)
  :custom
  (vertico-cycle t))

(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)

(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless basic)
        orderless-matching-styles '(orderless-initialism
                                    orderless-literal
                                    orderless-regexp)))

;; Display annotations for the available commands in the minibuffer
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))

;; A better modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(custom-set-faces
  ;; '(mode-line ((t (:family "Iosevka Comfy Motion" :height 0.9)))))
  '(mode-line ((t (:family "BerkeleyMono" :height 1.0)))))

;; Haskell programming
(use-package haskell-mode
  :ensure t)

;; Make haskell-mode work with a ghcup install
(let ((my-ghcup-path (expand-file-name "~/.ghcup/bin")))
  (setenv "PATH" (concat my-ghcup-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-ghcup-path))

;; Enable literate programming using org-mode
(org-babel-do-load-languages
  'org-babel-load-languages
  '((haskell . t)))

(setq org-confirm-babel-evaluate nil)

(setenv "PATH" (concat (getenv "PATH") ":/usr/bin/"))

;; Clojure setup
(use-package clojure-mode
  :ensure t)

(use-package cider
  :ensure t)
