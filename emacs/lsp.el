(require 'eglot)

;; clangd
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

;; ols (odin-language-server)
(load-file ".elsc/odin-mode.el")
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '((odin-mode) . ("/home/nosferatu/ThirdParty/ols/ols"))))
(add-hook 'odin-mode-hook #'eglot-ensure)

;; pylsp must be provided by the virtual environment
;; pip install 'python-lsp-server[all]'
(add-to-list 'eglot-server-programs '((python-mode) "pylsp"))
(add-hook 'python-mode-hook 'eglot-ensure)

;; rust-mode
(require 'rust-mode)
(add-hook 'rust-mode-hook
          (lambda ()
            (setq tab-width 2)
            (setq rust-indent-offset 2)
            (setq indent-tabs-mode nil)))
;; rust-analyzer
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               `(rust-mode . ("/home/nosferatu/ThirdParty/rust-analyzer/rust-analyzer"))))
(add-hook 'rust-mode-hook #'eglot-ensure)
(setq eglot-workspace-configuration
      '((:rust-analyzer
         (:check (:command "clippy")
				 :diagnostics (:enable t)
				 :completion (:autoimport t)
				 :hover (:actions t)
				 :inlayHints (:enable t)
				 :format (:enable t)))))

;; clojure-lsp
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

;; java-mode
(add-hook 'java-mode-hook
          (lambda ()
            (setq tab-width 2)
            (setq c-basic-offset 2)
            (setq indent-tabs-mode nil)))

;; groovy-mode
(add-hook 'groovy-mode-hook
          (lambda ()
            (setq tab-width 2)
            (setq groovy-indent-offset 2)
            (setq indent-tabs-mode nil)))

;; Key bindings only for the terminal mode
(global-set-key (kbd "M-RET") 'eglot-format)
