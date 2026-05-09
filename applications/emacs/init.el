(require 'package)

(setq package-archives
      '(("melpa" . "http://melpa.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")))

;; Initialize package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

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
(cond
 ((eq system-type 'windows-nt)
  ;; Windows configuration
  (setq default-directory (getenv "USERPROFILE"))
  (defvar my-config-dir (expand-file-name "Dotfiles/applications/emacs/" (getenv "USERPROFILE")))
  (load-file (expand-file-name "language.el" my-config-dir))
  (setq custom-file (expand-file-name "custom.el" my-config-dir)))
 ((eq system-type 'gnu/linux)
  ;; Linux configuration
  (setq default-directory "~/")
  (load-file (expand-file-name "~/.config/emacs/language.el"))
  (setq custom-file (expand-file-name "~/.config/emacs/custom.el"))))
(when (file-exists-p custom-file)
  (load custom-file))

;; Add to path
(cond
 ((eq system-type 'windows-nt)
  (add-to-list 'exec-path "C:/Program Files/Git/bin")
  (add-to-list 'exec-path "C:/Program Files/Git/usr/bin")))

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
(setq backup-directory-alist
      `(("." . ,(cond
                 ((eq system-type 'windows-nt)
                  (expand-file-name "~/.emacs.d/backup"))
                 ((eq system-type 'gnu/linux)
                  (expand-file-name "~/.config/emacs/backup")))))
      backup-by-copying      t   ; Don't de-link hard links
      version-control        t   ; Use version numbers on backups
      delete-old-versions    t   ; Automatically delete excess backups
      kept-new-versions      20  ; How many of the newest versions to keep
      kept-old-versions      5)  ; And how many of the old

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

;; Reference: https://www.emacswiki.org/emacs/basic-edit-toolkit.el
(defun move-text-internal (arg)
  "Move region (transient-mark-mode active) or current line."
  (let ((remember-point (point)))
    ;; Can't get correct effect of `transpose-lines'
    ;; when `point-max' is not at beginning of line
    ;; So fix this bug.
    (goto-char (point-max))
    (if (not (bolp)) (newline))         ;add newline to fix
    (goto-char remember-point)
    ;; logic code start
    (cond ((and mark-active transient-mark-mode)
           (if (> (point) (mark))
               (exchange-point-and-mark))
           (let ((column (current-column))
                 (text (delete-and-extract-region (point) (mark))))
             (forward-line arg)
             (move-to-column column t)
             (set-mark (point))
             (insert text)
             (exchange-point-and-mark)
             (setq deactivate-mark nil)))
          (t
           (let ((column (current-column)))
             (beginning-of-line)
             (when (or (> arg 0) (not (bobp)))
               (forward-line 1)
               (when (or (< arg 0) (not (eobp)))
                 (transpose-lines arg))
               (forward-line -1))
             (move-to-column column t))
           ))))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line ARG lines up."
  (interactive "*p")
  (move-text-internal (- arg)))

(defun move-text-down (arg)
  "Move region (transient-mar-mode active) or current line (ARG lines) down."
  (interactive "*p")
  (move-text-internal arg))

(global-set-key (kbd "M-<down>") 'move-text-down)
(global-set-key (kbd "M-<up>") 'move-text-up)

(global-set-key (kbd "C-j") (lambda () (interactive) (join-line -1)))

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

;; Display ruler for hard line wraps.
(setq-default fill-column 120)
(global-display-fill-column-indicator-mode 1)
