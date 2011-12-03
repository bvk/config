;; add local packages directory to the elisp load path
(when (file-exists-p "~/config/emacs/emacs.d")
  (add-to-list 'load-path "~/config/emacs/emacs.d"))

;; set user full name
(setq user-full-name "BVK Chaitanya")

;; set user email address
(setq user-mail-address "bvkchaitanya@gmail.com")

;; save customizations in a separate file
(setq custom-file "~/.emacs-custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

;; unset suspend-emacs on C-z
(global-unset-key (kbd "C-z"))

;; do not show the menu bar
(menu-bar-mode 0)

;; do not show the tool bar ;; emacs-nox has no tool-bar-mode
(when (functionp 'tool-bar-mode)
  (tool-bar-mode 0))

;; do not show the scroll bar ;; emacs-nox has no scroll-bar-mode
(when (functionp 'scroll-bar-mode)
  (scroll-bar-mode 0))

;; do not blink the cursor
(blink-cursor-mode 0)

;; save emacs session
; (desktop-save-mode 1)

;; use fixed font
(add-to-list 'default-frame-alist '(font . "inconsolata-12"))

;; do not display the right-fringe
(add-to-list 'default-frame-alist '(right-fringe . 0))

;; set cursor color to green
(add-to-list 'default-frame-alist '(cursor-color . "green"))

;; use short hands for yes or no questions
(fset 'yes-or-no-p 'y-or-n-p)

;; display trailing whitespace markers (except in ansi-term)
(setq-default show-trailing-whitespace t)
(add-hook 'ansi-term-mode-hook
	  (lambda () (set-variable 'show-trailing-whitespace nil)))

;; display column number on the mode-line
(column-number-mode 1)

;; display date and time on the mode-line
(display-time-mode 1)

;; use unique buffer names with directory name prefix
(when (require 'uniquify nil 'noerror)
  (setq uniquify-buffer-name-style 'forward))

;; use ido-mode for opening files
(ido-mode t)

;; use smex to enhance M-x
(when (require 'smex nil 'noerror)
  (smex-initialize)
  (global-set-key (kbd "M-x") 'smex))

;; enable password caching for encryption
;; (require 'epa-file)
;; (epa-file-enable)
(setq epa-file-cache-passphrase-for-symmetric-encryption t)

;; highlight matching parenthsis
(show-paren-mode 1)
(set-face-background 'show-paren-match-face "blue")

;; enable marmalade package repo
(when (require 'package nil 'noerror)
  (add-to-list 'package-archives
	       '("marmalade" . "http://marmalade-repo.org/packages/")))

;; set Nutanix customizations
(when (require 'google-c-style nil 'noerror)
  (google-set-c-style))

;; load my smtp settings
(when (file-exists-p "~/config/emacs/mysmtp.el")
  (load-file "~/config/emacs/mysmtp.el"))

;; load my irc setting
(when (file-exists-p "~/config/emacs/myirc.el")
  (load-file "~/config/emacs/myirc.el"))

;; geiser for guile
(when (file-exists-p "~/work/geiser/elisp")
  (add-to-list 'load-path "~/work/geiser/elisp")
  (require 'geiser-install))

;; load nutanix specific customizations
(when (file-exists-p "~/config/emacs/nutanix.el")
  (load-file "~/config/emacs/nutanix.el"))
