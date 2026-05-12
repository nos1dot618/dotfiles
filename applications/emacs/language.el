(dolist (pkg '(;; major-modes
               nix-mode
               markdown-mode
               clojure-mode
               powershell
               haskell-mode
               go-mode
               d-mode
               fish-mode
               zig-mode
               ;; lsp related packages
               eglot
               company
               ))
  (eval `(use-package ,pkg :defer t)))

(require 'eglot)
(setq eglot-report-progress nil)

;; Indentation settings
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default c-basic-offset 2)

;; pylsp must be provided by the virtual environment
;; pip install 'python-lsp-server[all]'
(add-to-list 'eglot-server-programs '((python-mode) "pylsp"))
(add-hook 'python-mode-hook #'eglot-ensure)
(add-hook 'python-mode-hook #'company-mode)

;; clangd for c-mode and c++-mode
(add-to-list 'eglot-server-programs '((c-mode c++-mode) "clangd"))
(add-hook 'c-mode-hook #'eglot-ensure)
(add-hook 'c-mode-hook #'company-mode)
(add-hook 'c++-mode-hook #'eglot-ensure)
(add-hook 'c++-mode-hook #'company-mode)

;; gopls for go-mode
;; go install golang.org/x/tools/gopls@latest
(add-to-list 'eglot-server-programs '((go-mode) "gopls"))
(add-hook 'go-mode-hook #'eglot-ensure)
(add-hook 'go-mode-hook #'company-mode)

;; serve-d for d-mode
(add-to-list 'eglot-server-programs '((d-mode) "serve-d"))
(add-hook 'd-mode-hook #'eglot-ensure)

(defun my-d-style ()
  ;; Fixes the bsd-style indentation for d-mode.
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'statement-block-intro '+)
  (c-set-offset 'block-close 0))
(add-hook 'd-mode-hook #'my-d-style)

;; hls for haskell-mode
(add-to-list 'eglot-server-programs
             '((haskell-mode haskell-literate-mode)
               . ("haskell-language-server-wrapper" "--lsp")))
(add-hook 'haskell-mode-hook #'eglot-ensure)
(add-hook 'haskell-mode-hook #'company-mode)
(setenv "PATH" (concat (getenv "PATH") ":/home/YOUR_USERNAME/.ghcup/bin"))
(setq exec-path (append exec-path '("/home/YOUR_USERNAME/.ghcup/bin")))

;; zls for zig-mode
(add-to-list 'eglot-server-programs '((zig-mode) "zls"))
(add-hook 'zig-mode-hook #'eglot-ensure)
(add-hook 'zig-mode-hook #'company-mode)

;; js-mode
(setq js-indent-level 2)

;; Custom Key bindings
;; Calls lsp-format-buffer when in java-mode,
;; and calls eglot-format everywhere else
(global-set-key (kbd "M-RET")
                (lambda ()
                  (interactive)
                  (if (eq major-mode 'java-mode)
                      (call-interactively 'lsp-format-buffer)
                    (call-interactively 'eglot-format))))

(global-set-key (kbd "C-c E") #'flymake-show-buffer-diagnostics)
