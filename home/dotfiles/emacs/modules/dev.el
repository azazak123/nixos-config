;;; Emacs Bedrock
;;;
;;; Extra config: Development tools

;;; Usage: Append or require this file from init.el for some software
;;; development-focused packages.
;;;
;;; It is **STRONGLY** recommended that you use the base.el config if you want to
;;; use Eglot. Lots of completion things will work better.
;;;
;;; This will try to use tree-sitter modes for many languages. Please run
;;;
;;;   M-x treesit-install-language-grammar
;;;
;;; Before trying to use a treesit mode.

;;; Contents:
;;;
;;;  - Built-in config for developers
;;;  - Version Control
;;;  - Common file types
;;;  - Eglot, the built-in LSP client for Emacs
;;;  - Templating

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Built-in config for developers
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package emacs
  :config
  ;; Treesitter config

  ;; Tell Emacs to prefer the treesitter mode
  ;; You'll want to run the command `M-x treesit-install-language-grammar' before editing.
  (setq major-mode-remap-alist
        '((yaml-mode . yaml-ts-mode)
          (bash-mode . bash-ts-mode)
          (js2-mode . js-ts-mode)
          (typescript-mode . typescript-ts-mode)
          (json-mode . json-ts-mode)
          (css-mode . css-ts-mode)
          (python-mode . python-ts-mode)))
  :hook
  ;; Auto parenthesis matching
  ((prog-mode . electric-pair-mode)))

(use-package project
  :custom
  (when (>= emacs-major-version 30)
    (project-mode-line t)))         ; show project name in modeline

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Version Control
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Magit: best Git client to ever exist
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Common file types
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package markdown-mode
  :ensure t
  :hook ((markdown-mode . visual-line-mode)))

(use-package yaml-mode
  :ensure t)

(use-package json-mode
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Modes
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Emacs ships with a lot of popular programming language modes. If it's not
;; built in, you're almost certain to find a mode for the language you're
;; looking for with a quick Internet search.

(use-package nix-ts-mode
  :mode "\\.nix\\'")

(use-package rust-ts-mode
  :ensure nil
  :mode "\\.rs\\'"
  :init
  (defvar-local my/rust-format-on-save t
    "Enable or disable Rust auto-formatting before saving.")

  :config
  (setq-default eglot-workspace-configuration
                '((rust-analyzer .
                                 (:check (:command "clippy")))))

  (defun my/rust-setup-format-hook ()
    "Add a local hook for formatting before save."
    (add-hook 'before-save-hook
              (lambda ()
                (when my/rust-format-on-save
                  (eglot-format-buffer)))
              nil t))

  :hook 
  ((rust-ts-mode . eglot-ensure)
   (rust-ts-mode . my/rust-setup-format-hook)))

(use-package d-mode
  :ensure t
  :mode "\\.d\\'"
  :init
  (defvar-local my/d-format-on-save t
    "Enable or disable D auto-formatting before saving.")
  
  :config
  (setq c-basic-offset 4)
  
  (defun my/d-format-buffer ()
    "Format the current buffer using the 'dfmt' CLI tool."
    (when (and my/d-format-on-save
               (executable-find "dfmt"))
      (let ((orig-point (point)))
        (shell-command-on-region (point-min) (point-max) "dfmt" nil t)
        (goto-char orig-point))))
  
  (defun my/d-setup-format-hook ()
    "Add a local hook for formatting before save."
    (add-hook 'before-save-hook #'my/d-format-buffer nil t))

  :hook
  ((d-mode . eglot-ensure)
   (d-mode . my/d-setup-format-hook)))

(use-package erlang
  :ensure t
  :mode (("\\.erl\\'" . erlang-mode)
         ("\\.hrl\\'" . erlang-mode)
         ("\\.app\\.src\\'" . erlang-mode)
         ("rebar\\.config\\'" . erlang-mode))
  :hook ((erlang-mode . (lambda () (setq indent-tabs-mode nil)))
         (erlang-mode . eglot-ensure))
  :config
  (setq erlang-compile-use-rebar t))

(use-package clojure-ts-mode
  :ensure t
  :mode (("\\.clj\\'" . clojure-ts-mode)
         ("\\.cljs\\'" . clojurescript-ts-mode)
         ("\\.cljc\\'" . clojurec-ts-mode)
         ("\\.edn\\'"  . clojure-ts-mode))
  :hook ((clojure-ts-mode . eglot-ensure)
         (clojurescript-ts-mode . eglot-ensure)
         (clojurec-ts-mode . eglot-ensure)))

(use-package cider
  :ensure t
  ;; :custom
  ;; (cider-repl-display-help-banner nil)
  ;; (cider-eldoc-display-for-symbol-at-point nil)
  )

(use-package idris-mode
  :ensure t
  :custom
  (idris-interpreter-path "idris2"))

(use-package racket-mode
  :ensure t
  :mode "\\.rkt\\'")

(use-package nim-mode
  :ensure t
  :mode "\\.nim\\'"

  :init
  (defvar-local my/nim-format-on-save t
    "Enable or disable Nim auto-formatting before saving.")

  :config
  (defun my/nim-setup-format-hook ()
    "Add a local hook for formatting before save."
    (add-hook 'before-save-hook
              (lambda ()
                (when my/nim-format-on-save
                  (eglot-format-buffer)))
              nil t))

  :hook 
  ((nim-mode . tree-sitter-hl-mode)
   (nim-mode . eglot-ensure)
   (nim-mode . my/nim-setup-format-hook)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Eglot, the built-in LSP client for Emacs
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Helpful resources:
;;
;;  - https://www.masteringemacs.org/article/seamlessly-merge-multiple-documentation-sources-eldoc

(use-package eglot
  ;; no :ensure t here because it's built-in

  ;; Configure hooks to automatically turn-on eglot for selected modes
  ;; :hook
  ;; (((python-mode ruby-mode elixir-mode) . eglot-ensure))

  :custom
  (eglot-send-changes-idle-time 0.1)
  (eglot-extend-to-xref t)              ; activate Eglot in referenced non-project files

  :bind (:map eglot-mode-map
              ("C-c l a" . eglot-code-actions)
              ("C-c l r" . eglot-rename)
              ("C-c l f" . eglot-format)
              ("C-c l h" . eldoc-doc-buffer))
  
  :config
  (fset #'jsonrpc--log-event #'ignore)  ; massive perf boost---don't log every event

  ;; Sometimes you need to tell Eglot where to find the language server
  ;; (add-to-list 'eglot-server-programs
  ;;              '(haskell-mode . ("haskell-language-server-wrapper" "--lsp")))
  (add-to-list 'eglot-server-programs
               '(erlang-mode . ("elp" "server")))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Templating
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package tempel
  :ensure t
  ;; By default, tempel looks at the file "templates" in
  ;; user-emacs-directory, but you can customize that with the
  ;; tempel-path variable:
  ;; :custom
  ;; (tempel-path (concat user-emacs-directory "custom_template_file"))
  :bind (("M-*" . tempel-insert)
         ("M-+" . tempel-complete)
         :map tempel-map
         ("C-c RET" . tempel-done)
         ("C-<down>" . tempel-next)
         ("C-<up>" . tempel-previous)
         ("M-<down>" . tempel-next)
         ("M-<up>" . tempel-previous))
  :init
  ;; Make a function that adds the tempel expansion function to the
  ;; list of completion-at-point-functions (capf).
  (defun tempel-setup-capf ()
    (add-hook 'completion-at-point-functions #'tempel-expand -1 'local))
  ;; Put tempel-expand on the list whenever you start programming or
  ;; writing prose.
  (add-hook 'prog-mode-hook 'tempel-setup-capf)
  (add-hook 'text-mode-hook 'tempel-setup-capf))
