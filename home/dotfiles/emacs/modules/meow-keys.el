(defvar my-wrap-map (make-sparse-keymap)
  "Keymap for Meow wrapping commands. Activated by pressing P.")

;; Bind specific brackets to their Meow commands inside our new map
(define-key my-wrap-map (kbd "(") 'puni-wrap-round)
(define-key my-wrap-map (kbd ")") 'puni-wrap-round)
(define-key my-wrap-map (kbd "[") 'puni-wrap-square)
(define-key my-wrap-map (kbd "]") 'puni-wrap-square)
(define-key my-wrap-map (kbd "{") 'puni-wrap-curly)
(define-key my-wrap-map (kbd "}") 'puni-wrap-curly)
(define-key my-wrap-map (kbd "<") 'puni-wrap-angle)
(define-key my-wrap-map (kbd ">") 'puni-wrap-angle)

(use-package meow
  :demand t
  :config
  
  ;; ==========================================
  ;; 1. ВЕРСІЯ ДЛЯ QWERTY (Ваш попередній Helix-стайл)
  ;; ==========================================
  (defun meow-setup-qwerty ()
    (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
    
    (meow-motion-overwrite-define-key
     '("j" . meow-next) 
     '("k" . meow-prev) 
     '("<escape>" . ignore))
     
    (meow-leader-define-key
     '("SPC" . execute-extended-command)
     '("?" . meow-cheatsheet)
     '("1" . meow-digit-argument) '("2" . meow-digit-argument)
     '("3" . meow-digit-argument) '("4" . meow-digit-argument)
     '("5" . meow-digit-argument) '("6" . meow-digit-argument)
     '("7" . meow-digit-argument) '("8" . meow-digit-argument)
     '("9" . meow-digit-argument) '("0" . meow-digit-argument))

    (meow-normal-define-key
     '("0" . meow-expand-0) '("1" . meow-expand-1) '("2" . meow-expand-2)
     '("3" . meow-expand-3) '("4" . meow-expand-4) '("5" . meow-expand-5)
     '("6" . meow-expand-6) '("7" . meow-expand-7) '("8" . meow-expand-8)
     '("9" . meow-expand-9)
     '("-" . negative-argument)
     '(";" . meow-reverse)
     '("," . meow-inner-of-thing)
     '("." . meow-bounds-of-thing)
     '("[" . meow-beginning-of-thing)
     '("]" . meow-end-of-thing)
     '("a" . meow-append)           ; Ідеальний Helix append
     '("A" . meow-open-below)
     '("b" . meow-back-word)
     '("B" . meow-back-symbol)
     '("c" . meow-change)
     '("d" . meow-kill)
     '("D" . meow-backward-delete)
     '("e" . meow-next-word)
     '("E" . meow-next-symbol)
     '("f" . meow-find)
     '("g" . meow-cancel-selection)
     '("G" . meow-grab)
     '("h" . meow-left)
     '("H" . meow-left-expand)
     '("i" . meow-insert)           ; Ідеальний Helix insert
     '("I" . meow-open-above)
     '("j" . meow-next)
     '("J" . meow-next-expand)
     '("k" . meow-prev)
     '("K" . meow-prev-expand)
     '("l" . meow-right)
     '("L" . meow-right-expand)
     '("m" . meow-join)
     '("n" . meow-search)
     '("O" . meow-to-block)
     '("p" . meow-yank)
     (cons "P" my-wrap-map)         ; Наше меню дужок
     '("q" . meow-quit)
     '("Q" . meow-goto-line)
     '("r" . meow-replace)
     '("R" . meow-swap-grab)
     '("s" . meow-delete)
     '("t" . meow-till)
     '("u" . meow-undo)
     '("U" . undo-redo)
     '("v" . meow-visit)
     '("w" . meow-mark-word)
     '("W" . meow-mark-symbol)
     '("x" . meow-line)
     '("X" . meow-goto-line)
     '("y" . meow-save)
     '("Y" . meow-sync-grab)
     '("z" . meow-pop-selection)
     '("'" . repeat)
     '("C-o" . xref-go-back)        ; Стрибки по коду
     '("C-i" . xref-go-forward)
     '("<escape>" . ignore)))

  ;; ==========================================
  ;; 2. ВЕРСІЯ ДЛЯ COLEMAK (Нова ергономіка)
  ;; ==========================================
  (defun meow-setup-colemak ()
    (setq meow-cheatsheet-layout meow-cheatsheet-layout-colemak)
    
    (meow-motion-define-key
     '("e" . meow-prev)
     '("<escape>" . ignore))
    
    (meow-leader-define-key
     '("SPC" . execute-extended-command)
     '("?" . meow-cheatsheet)
     '("1" . meow-digit-argument) '("2" . meow-digit-argument)
     '("3" . meow-digit-argument) '("4" . meow-digit-argument)
     '("5" . meow-digit-argument) '("6" . meow-digit-argument)
     '("7" . meow-digit-argument) '("8" . meow-digit-argument)
     '("9" . meow-digit-argument) '("0" . meow-digit-argument))
    
    (meow-normal-define-key
     '("0" . meow-expand-0) '("1" . meow-expand-1) '("2" . meow-expand-2)
     '("3" . meow-expand-3) '("4" . meow-expand-4) '("5" . meow-expand-5)
     '("6" . meow-expand-6) '("7" . meow-expand-7) '("8" . meow-expand-8)
     '("9" . meow-expand-9)
     '("-" . negative-argument)
     '(";" . meow-reverse)
     '("," . meow-inner-of-thing)
     '("." . meow-bounds-of-thing)
     '("[" . meow-beginning-of-thing)
     '("]" . meow-end-of-thing)
     '("/" . meow-visit)
     '("a" . meow-append)
     '("A" . meow-open-below)
     '("b" . meow-back-word)
     '("B" . meow-back-symbol)
     '("c" . meow-change)
     '("e" . meow-prev)
     '("E" . meow-prev-expand)
     '("f" . meow-find)
     '("g" . meow-cancel-selection)
     '("G" . meow-grab)
     '("h" . meow-left)
     '("H" . meow-left-expand)
     '("i" . meow-right)
     '("I" . meow-right-expand)
     '("j" . meow-join)
     '("k" . meow-kill)
     '("l" . meow-line)
     '("L" . meow-goto-line)
     '("m" . meow-mark-word)
     '("M" . meow-mark-symbol)
     '("n" . meow-next)
     '("N" . meow-next-expand)
     '("o" . meow-block)
     '("O" . meow-to-block)
     '("p" . meow-yank)
     (cons "P" my-wrap-map)         ; Наше меню дужок
     '("q" . meow-quit)
     '("r" . meow-replace)
     '("s" . meow-insert)
     '("S" . meow-open-above)
     '("t" . meow-till)
     '("u" . meow-undo)
     '("U" . undo-redo)
     '("v" . meow-search)
     '("w" . meow-next-word)
     '("W" . meow-next-symbol)
     '("x" . meow-delete)
     '("X" . meow-backward-delete)
     '("y" . meow-save)
     '("z" . meow-pop-selection)
     '("'" . repeat)
     '("<escape>" . ignore)))

  ;; ==================================
  ;; 3. ВИБІР АКТИВНОЇ РОЗКЛАДКИ
  ;; ==========================================
  ;; Щоб змінити розкладку, просто закоментуйте один рядок і розкоментуйте інший.
  
  ;; (meow-setup-qwerty)   ;<-- Увімкнути QWERTY
  (meow-setup-colemak)     ;<-- Увімкнути COLEMAK

  ;; (meow-global-mode 1)
  )

(use-package meow-tree-sitter
  :ensure t
  :after meow
  :config
  (meow-tree-sitter-register-defaults)
  (meow-normal-define-key
   '("o" . meow-tree-sitter-node)))
