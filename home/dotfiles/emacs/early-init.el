(setq gc-cons-threshold most-positive-fixnum)
(setq package-enable-at-startup nil)

(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message (user-login-name))

(setq byte-compile-warnings '(not obsolete))
(setq warning-suppress-log-types '((comp) (bytecomp)))
(setq native-comp-async-report-warnings-errors 'silent)

(setq default-frame-alist 
      '((menu-bar-lines . 0)
        (tool-bar-lines . 0)
        (undecorated . t)
        (vertical-scroll-bars . nil)
        (fullscreen . maximized)
        (background-color . "#000000")
        (foreground-color . "#ffffff")))

(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold 16777216)))
