(require 'eglot)
(use-package company
  :ensure t)

;; clangd configuration
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

;; pylsp must be provided by the virtual environment
(add-to-list 'eglot-server-programs '((python-mode) "pylsp"))
(add-hook 'python-mode-hook 'eglot-ensure)

;; Language modes
(require 'rust-mode)

;; clojure-lsp configuration
(use-package eglot
  :ensure t
  :hook ((clojure-mode . eglot-ensure)
         (clojurec-mode . eglot-ensure)
         (clojurescript-mode . eglot-ensure))
  :config
  (setenv "PATH" (concat "/usr/local/bin" path-separator (getenv "PATH")))
  (add-to-list 'eglot-server-programs '(clojure-mode . ("clojure-lsp")))
  (add-to-list 'eglot-server-programs '(clojurec-mode . ("clojure-lsp")))
  (add-to-list 'eglot-server-programs '(clojurescript-mode . ("clojure-lsp")))
  (add-to-list 'eglot-server-programs '(clojurex-mode . ("clojure-lsp"))))
