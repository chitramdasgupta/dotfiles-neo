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

;; Enable auto-fill-mode for Markdown files and set fill column to 80
(add-hook 'markdown-mode-hook (lambda () (auto-fill-mode) (setq fill-column 80)))
(add-hook 'markdown-mode-hook 'auto-fill-mode)
(add-hook 'markdown-mode-hook (lambda () (setq fill-column 80)))

;; Enable auto-fill-mode for Org-mode files and set fill column to 80
(add-hook 'org-mode-hook (lambda () (auto-fill-mode 1) (setq fill-column 80)))
(add-hook 'org-mode-hook 'auto-fill-mode)
(add-hook 'org-mode-hook (lambda () (setq fill-column 80)))

;; Enable auto-fill-mode for text-mode files and set fill column to 80
(add-hook 'text-mode-hook (lambda () (auto-fill-mode 1) (setq fill-column 80)))
(add-hook 'text-mode-hook 'auto-fill-mode)
(add-hook 'text-mode-hook (lambda () (setq fill-column 80)))

(add-hook 'org-mode-hook 'org-indent-mode)

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
;; Requires languagetool to be installed and enabled as a systemd service
(use-package languagetool
  :ensure t)

;; Enable LanguageTool in markdown-mode and org-mode
(add-hook 'markdown-mode-hook (lambda () (languagetool-server-mode)))
(add-hook 'org-mode-hook (lambda () (languagetool-server-mode)))

;; Delete trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'markdown-mode-hook (lambda () (add-hook 'before-save-hook 'delete-trailing-whitespace)))
(add-hook 'org-mode-hook (lambda () (add-hook 'before-save-hook 'delete-trailing-whitespace)))

;; For <s TAB completions
(require 'org-tempo)

;; For encryption and decryption
(setq epa-file-cache-passphrase-for-symmetric-encryption t)

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
