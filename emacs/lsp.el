(require 'eglot)
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

;; Key bindings only for the terminal mode
(global-set-key (kbd "M-RET") 'eglot-format)

;; Odin LSP configuration
(load-file ".elsc/odin-mode.el")
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '((odin-mode) . ("/home/nosferatu/ThirdParty/ols/ols"))))
(add-hook 'odin-mode-hook #'eglot-ensure)
