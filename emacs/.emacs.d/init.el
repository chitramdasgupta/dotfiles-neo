;; Diasble the initial splash screen
(setq inhibit-splash-screen t)

;; Makes *scratch* empty.
(setq initial-scratch-message "")

;; Change scratch buffer to org mode
(setq initial-major-mode 'org-mode)

;; Setup emacs default package manager: package.el
(require 'package)
(add-to-list 'package-archives
        '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; Disable creating backup files (the ones ending with ~)
(setq make-backup-files nil)

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
(set-frame-font "Iosevka Comfy Motion 16" nil t)

;; Theme
(use-package modus-themes
  :ensure t)

;; Make the mode-line border of the same color as the background
(setq modus-themes-common-palette-overrides
      '((border-mode-line-active unspecified)
        (border-mode-line-inactive unspecified)))

(load-theme 'modus-vivendi-tinted)

;; I prefer to use an orange cursor with the modus-vivendi theme
;; (setq evil-normal-state-cursor '("orange" box))
;; (setq evil-insert-state-cursor '("orange" bar))
;; (setq evil-visual-state-cursor '("orange" hbar))
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

(setq column-number-mode t)

;; Setup markdown and org-mode
(use-package markdown-mode
  :ensure t)

;; Hard text-wrapping occurs after 80 characters for git commits
(add-hook 'text-mode-hook (lambda () (setq fill-column 80)))

(use-package visual-fill-column
  :ensure t)

;; Soft text-wrapping occurs after 80 characters
(setq-default visual-fill-column-width 80)

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

(add-hook 'org-mode-hook 'toc-org-mode)
(add-hook 'markdown-mode-hook 'toc-org-mode)

;; Sensible defaults for the source code blocks
(setq org-src-preserve-indentation nil)
(setq org-edit-src-content-indentation 0)

;; Grammar and spellcheck
;; Set up vale for spell-check and grammar-check
(use-package flycheck
  :ensure t)

(add-hook 'org-mode-hook 'flycheck-mode)
(add-hook 'markdown-mode-hook 'flycheck-mode)
(add-hook 'text-mode-hook 'flycheck-mode)

(flycheck-define-checker vale
  "A checker for prose"
  :command ("vale" "--output" "line" source)
  :standard-input nil
  :error-patterns
  ((error line-start (file-name) ":" line ":" column ":" (id (one-or-more (not (any ":")))) ":" (message) line-end))
  :modes (markdown-mode org-mode text-mode)
 )

(add-to-list 'flycheck-checkers 'vale 'append)

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

;; Better completion for minibuffer commands
(use-package vertico
  :ensure t
  :init (vertico-mode)
  :custom
  (vertico-cycle t))

(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)

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
  '(mode-line ((t (:family "Iosevka Comfy Motion" :height 0.9)))))
