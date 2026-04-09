(setq gc-cons-threshold (* 100 1024 1024))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   custom.el
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Packages
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'use-package)
(setq use-package-always-ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Basic settings
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(electric-pair-mode 1)

;; Automatically reread from disk if the underlying file changes
(setopt auto-revert-avoid-polling t)
;; Some systems don't do file notifications well; see
;; https://todo.sr.ht/~ashton314/emacs-bedrock/11
(setopt auto-revert-interval 5)
(setopt auto-revert-check-vc-info t)
(global-auto-revert-mode)

(use-package savehist
  :ensure nil
  :init
  (setq savehist-additional-variables '(search-ring regexp-search-ring kill-ring))
  (savehist-mode)
  :config
  ;; Strip properties from kill-ring before saving to keep savehist file clean
  (add-hook 'savehist-save-hook
            (lambda ()
              (setq kill-ring
                    (mapcar #'substring-no-properties
                            (cl-remove-if-not #'stringp kill-ring))))))

(save-place-mode 1)

(advice-add 'save-place-find-file-hook :after
            (lambda (&rest _)
              (when buffer-file-name (ignore-errors (recenter)))))

;; Fix archaic defaults
(setopt sentence-end-double-space nil)
;; Clipboard
(setq select-enable-clipboard t)
;; credit: yorickvP on Github
(setq wl-copy-process nil)

(defun wl-copy (text)
  (let ((default-directory "~/"))
    (setq wl-copy-process (make-process :name "wl-copy"
                                        :buffer nil
                                        :command '("wl-copy" "-f" "-n")
                                        :connection-type 'pipe
                                        :noquery t))
    (process-send-string wl-copy-process text)
    (process-send-eof wl-copy-process)))

(defun wl-paste ()
  (let ((default-directory "~/"))
    (if (and wl-copy-process (process-live-p wl-copy-process))
        nil ; should return nil if we're the current paste owner
      (shell-command-to-string "wl-paste -n | tr -d \r"))))

(setq interprogram-cut-function 'wl-copy)
(setq interprogram-paste-function 'wl-paste)

(defun bedrock--backup-file-name (fpath)
  "Return a new file path of a given file path.
If the new path's directories does not exist, create them."
  (let* ((backupRootDir (concat user-emacs-directory "emacs-backup/"))
         (filePath (replace-regexp-in-string "[A-Za-z]:" "" fpath )) ; remove Windows driver letter in path
         (backupFilePath (replace-regexp-in-string "//" "/" (concat backupRootDir filePath "~") )))
    (make-directory (file-name-directory backupFilePath) (file-name-directory backupFilePath))
    backupFilePath))
(setopt make-backup-file-name-function 'bedrock--backup-file-name)

(with-eval-after-load 'eldoc
  (setq eldoc-idle-delay 0.5))

(with-eval-after-load 'flymake
  (setq flymake-no-changes-timeout 0.5))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Discovery aids
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Show the help buffer after startup
(add-hook 'after-init-hook 'org-agenda-list)

;; which-key: shows a popup of available keybindings when typing a long key
;; sequence (e.g. C-x ...)
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package helpful
  :bind
  (("C-h f" . helpful-function)
   ("C-h x" . helpful-command)
   ("C-h k" . helpful-key)
   ("C-h v" . helpful-variable)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Interface enhancements/defaults
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Mode line information
(setopt line-number-mode t)                        ; Show current line in modeline
(setopt column-number-mode t)                      ; Show column as well

(setopt x-underline-at-descent-line nil)           ; Prettier underlines
(setopt switch-to-buffer-obey-display-actions t)   ; Make switching buffers more consistent

(setopt indicate-buffer-boundaries 'left)  ; Show buffer top and bottom in the margin

;; Enable horizontal scrolling
(setopt mouse-wheel-tilt-scroll t)
(setopt mouse-wheel-flip-direction t)

;; We won't set these, but they're good to know about
;; (setopt indent-tabs-mode nil)
;; (setopt tab-width 4)

(use-package dtrt-indent
  :ensure t
  :config
  (dtrt-indent-global-mode 1))

;; Misc. UI tweaks
;; (blink-cursor-mode -1)                                ; Steady cursor
(pixel-scroll-precision-mode)                         ; Smooth scrolling
(setopt scroll-preserve-screen-position t)

; For terminal users, make the mouse more useful
(xterm-mouse-mode 1)

;; Display line numbers in programming mode
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(setopt display-line-numbers-width 3)           ; Set a minimum width

;; Nice line wrapping when working with text
(add-hook 'text-mode-hook 'visual-line-mode)

;; Modes to highlight the current line with
(let ((hl-line-hooks '(text-mode-hook prog-mode-hook)))
  (mapc (lambda (hook) (add-hook hook 'hl-line-mode)) hl-line-hooks))

(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)
(setq window-combination-resize t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Minibuffer/completion settings
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; For help, see: https://www.masteringemacs.org/article/understanding-minibuffer-completion

(setopt enable-recursive-minibuffers t)                ; Use the minibuffer whilst in the minibuffer
(setopt completion-cycle-threshold 1)                  ; TAB cycles candidates
(setopt completions-detailed t)                        ; Show annotations
(setopt tab-always-indent 'complete)                   ; When I hit TAB, try to complete, otherwise, indent
(setopt completion-styles '(basic initials substring)) ; Different styles to match input to candidates

(setopt completion-auto-help 'always)                  ; Open completion always; `lazy' another option
(setopt completions-max-height 20)                     ; This is arbitrary
(setopt completions-format 'one-column)
(setopt completions-group t)
(setopt completion-auto-select 'second-tab)            ; Much more eager
;(setopt completion-auto-select t)                     ; See `C-h v completion-auto-select' for more possible values

(keymap-set minibuffer-mode-map "TAB" 'minibuffer-complete) ; TAB acts more like how it does in the shell

;; For a fancier built-in completion option, try ido-mode,
;; icomplete-vertical, or fido-mode. See also the file extras/base.el

;(icomplete-vertical-mode)
;(fido-vertical-mode)
;(setopt icomplete-delay-completions-threshold 4000)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Theme
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t 
        doom-themes-enable-italic t)
  (load-theme 'doom-palenight t)

  (add-hook 'after-make-frame-functions
            (lambda (frame)
              (with-selected-frame frame
                (load-theme 'doom-palenight t)))))

(set-face-attribute 'default nil 
                    :family "JetBrainsMono Nerd Font" 
                    :height 160 
                    :weight 'regular)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Modules
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load-file (expand-file-name "modules/base.el" user-emacs-directory)) 
(load-file (expand-file-name "modules/dev.el" user-emacs-directory)) 
(load-file (expand-file-name "modules/org.el" user-emacs-directory))
(load-file (expand-file-name "modules/meow-keys.el" user-emacs-directory)) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Keybindings
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun my/save-without-format ()
  "Save the current buffer without calling formatters and other before-save hooks."
  (interactive)
  (let ((before-save-hook nil))
    (save-buffer))
  (message "Saved without formatting!"))

(defun my/insert-divider-centered (text)
  "Prompts for TEXT and generates a centered, commented divider using '==='."
  (interactive "sDivider text: ")
  (let* ((total-width 80)
         (mid-text (if (string= text "") "" (format " %s " text)))
         (text-len (length mid-text))
         (remaining-width (max 0 (- total-width text-len)))
         (left-width (/ remaining-width 2))
         (right-width (- remaining-width left-width))
         (left-dashes (make-string left-width ?=))
         (right-dashes (make-string right-width ?=))
         (start-pos (point)))
    
    (insert left-dashes mid-text right-dashes)
    (comment-region start-pos (point))
    (insert "\n")))

(defun my/select-line-and-move-down ()
  "Selects the current line and moves the cursor down."
  (interactive)
  (unless (region-active-p)
    (beginning-of-line)
    (push-mark (point) t t))
  (forward-line 1))

;; 1. Function for KILLING (C-w)
(defun my/kill-region-or-line (&optional arg)
  "Kills the selected region. If no region is active — kills the whole line.
Understands numeric prefixes (e.g., M-3 C-w will kill 3 lines)."
  (interactive "p")
  (if (use-region-p)
      (kill-region (region-beginning) (region-end))
    (kill-whole-line arg)))

;; 2. Function for COPYING (M-w)
(defun my/copy-region-or-line (&optional arg)
  "Copies the selected region. If no region is active — copies the whole line.
Understands numeric prefixes (e.g., M-3 M-w will copy 3 lines)."
  (interactive "p")
  (if (use-region-p)
      (kill-ring-save (region-beginning) (region-end))
    (let ((beg (line-beginning-position))
          (end (line-beginning-position (1+ (or arg 1)))))
      (kill-ring-save beg end)
      ;; Display a small message at the bottom to indicate successful copying
      (message "Copied %d line(s)" arg))))

(defun my/scroll-page-down ()
  (interactive)
  (scroll-up-command (/ (window-body-height) 3)))

(defun my/scroll-page-up ()
  (interactive)
  (scroll-down-command (/ (window-body-height) 3)))

(keymap-global-set "C-S-n" #'my/select-line-and-move-down)

(keymap-global-set "<remap> <kill-region>" #'my/kill-region-or-line)
(keymap-global-set "<remap> <kill-ring-save>" #'my/copy-region-or-line)
(keymap-global-set "<remap> <scroll-up-command>" #'my/scroll-page-down)
(keymap-global-set "<remap> <scroll-down-command>" #'my/scroll-page-up)

(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 16 1024 1024))))
