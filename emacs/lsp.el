;; eglot
(require 'eglot)
(setq eglot-report-progress nil)

;; lsp-mode
(require 'lsp-mode)
(setq lsp-headerline-breadcrumb-enable nil)

;; lsp-java
(add-hook 'java-mode-hook #'lsp)

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
(add-hook 'python-mode-hook #'eglot-ensure)

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

;; dfmt
(defun my-d-format-func ()
  "Format the current D buffer using dfmt"
  (interactive)
  (let ((pos (point)))
	(shell-command-on-region (point-min) (point-max)
							 (concat "/home/nosferatu/ThirdParty/dfmt/bin/dfmt"
									 " --indent_size=2"
									 " --brace_style=otbs"
									 " --indent_style=space"
									 " --max_line_length=80")
							 t t)
    (goto-char (point-min))
    (while (re-search-forward "^stdin.*\\[\\(?:error\\|warn\\)\\]:.*\n" nil t)
      (replace-match ""))
	(goto-char pos)))
;; d-mode
(add-hook 'd-mode-hook (lambda () (local-set-key (kbd "M-RET") #'my-d-format-func)))

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

;; Calls lsp-format-buffer when in java-mode,
;; and calls eglot-format everywhere else
(global-set-key (kbd "M-RET")
                (lambda ()
                  (interactive)
                  (if (eq major-mode 'java-mode)
                      (call-interactively 'lsp-format-buffer)
                    (call-interactively 'eglot-format))))
