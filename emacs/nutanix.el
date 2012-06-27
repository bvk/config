;; Use as many characters as possible.
(setq-default fill-column 79)

;; Use nutanix email instead.
(setq user-mail-address "bvk@nutanix.com")

;; Don't use tabs for indentation.
(setq-default indent-tabs-mode nil)

;; Use 2 spaces indentation for python code.
(setq-default python-indent 2)

;; Open header files in C++ mode.
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; Use F7 to force a flymake syntax check.
(global-set-key (kbd "<f7>") 'flymake-start-syntax-check)

;; Enable some minor modes for C/C++ files.
(add-hook 'c-mode-common-hook
          '(lambda ()
             (progn
               (c-set-style "google")
               (flyspell-prog-mode)
               (flymake-mode 1)
               (c-toggle-hungry-state 1)
               )))

; (require 'flymake-cursor)
