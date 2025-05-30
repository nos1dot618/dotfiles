(require 'package)

(setq package-archives
      '(("melpa" . "http://melpa.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")))

;; Initialize package system
(package-initialize)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
;; Automatically install missing packages
(setq use-package-always-ensure t)

;; Visual Settings
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq inhibit-startup-screen t)
;; Fullscreen-mode default
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq resize-mini-windows t)

;; Indentation settings
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default c-basic-offset 2)

;; Install packages
(dolist (pkg '(zenburn-theme
               multiple-cursors
               eglot
               ;; Add more packages here
               ))
  (eval `(use-package ,pkg :defer t)))

;; Load other emacs configuration files
(setq default-directory "~/")
(load-file (expand-file-name "~/.config/emacs/lsp.el"))
(setq custom-file (expand-file-name "~/.config/emacs/custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

;; Displaying line number in relative mode
;; Reference: https://stackoverflow.com/a/54392862/22342267
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

;; Mouse scroll speed reduction
;; Reference: https://stackoverflow.com/a/26053341/22342267
(setq mouse-wheel-scroll-amount '(0.07))
(setq mouse-wheel-progressive-speed nil)
(setq ring-bell-function 'ignore)

(use-package smex
  :bind (("M-x" . smex))
  :config (smex-initialize))

(setq indo-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-show-dot-for-dired t)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Custom key bindings
;; Works with emacs >= 29.1
(global-set-key (kbd "C-,") 'duplicate-line)

;; Redirect backups to ~/.config/emacs/backup
(setq backup-directory-alist '(("." . "~/.config/emacs/backup"))
      backup-by-copying      t  ; Don't de-link hard links
      version-control        t  ; Use version numbers on backups
      delete-old-versions    t  ; Automatically delete excess backups:
      kept-new-versions      20 ; how many of the newest versions to keep
      kept-old-versions      5) ; and how many of the old

(put 'downcase-region 'disabled nil)

;; Custom functions
(defun open-in-browser()
  (interactive)
  (let ((filename (buffer-file-name)))
    (browse-url (concat "file://" filename))))

;; Key bindings for the terminal mode
(if (not (display-graphic-p))
    (progn
      (global-set-key (kbd "C-c d") 'kill-whole-line)
      (global-set-key (kbd "C-x /") 'comment-line)
      (global-set-key (kbd "C-q") 'backward-kill-word)
	    (global-set-key (kbd "C-c >") 'mc/mark-next-like-this)
	    (global-set-key (kbd "C-c <") 'mc/mark-previous-like-this)
	    (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)))
