(dolist (pkg '(;; major-modes
               nix-mode
               markdown-mode
               clojure-mode
               powershell
               haskell-mode
               go-mode
               ;; lsp related packages
               eglot
               company
               ))
  (eval `(use-package ,pkg :defer t)))

(require 'eglot)
(setq eglot-report-progress nil)

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

;; gopls for go-mod
;; go install golang.org/x/tools/gopls@latest
(add-to-list 'eglot-server-programs '((go-mode) "gopls"))
(add-hook 'go-mode-hook #'eglot-ensure)
(add-hook 'go-mode-hook #'company-mode)

;; Custom Key bindings
;; Calls lsp-format-buffer when in java-mode,
;; and calls eglot-format everywhere else
(global-set-key (kbd "M-RET")
                (lambda ()
                  (interactive)
                  (if (eq major-mode 'java-mode)
                      (call-interactively 'lsp-format-buffer)
                    (call-interactively 'eglot-format))))
