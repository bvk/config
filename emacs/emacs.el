;; add local packages directory to the elisp load path
(when (file-exists-p "~/config/emacs/emacs.d")
  (add-to-list 'load-path "~/config/emacs/emacs.d"))

;; set user full name
(setq user-full-name "BVK Chaitanya")

;; set user email address
(setq user-mail-address "bvkchaitanya@gmail.com")

;; load the window manager.
(add-to-list 'load-path "~/tools/xelb.repo/")
(add-to-list 'load-path "~/tools/exwm.repo/")
;(require 'exwm)
;(require 'exwm-config)
;(exwm-config-default)
;(exwm-input-set-key
; (kbd "C-c o") #'exwm-workspace-switch)
;(setq debug-on-error t)
;(setq edebug-all-forms t)
;(setq exwm-debug-on t)
(load-file "~/config/emacs/wm.el")

;; don't make noise; use visible bell
(setq visible-bell t)

;; mail auto save directory
(setq message-auto-save-directory "~/Mail/drafts")

;; save customizations in a separate file
(setq custom-file "~/.emacs-custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

;; unset suspend-emacs on C-z
(global-unset-key (kbd "C-z"))

;; use X11 primary
(setq select-active-regions nil)
(setq mouse-drag-copy-region t)
(setq x-select-enable-primary t)
(setq x-select-enable-clipboard t)

;; do not show the menu bar
(menu-bar-mode 0)

;; do not show tooltips
(tooltip-mode nil)
(setq show-help-function nil)

;; do not show the tool bar ;; emacs-nox has no tool-bar-mode
(when (functionp 'tool-bar-mode)
  (tool-bar-mode 0))

;; do not show the scroll bar ;; emacs-nox has no scroll-bar-mode
(when (functionp 'scroll-bar-mode)
  (scroll-bar-mode 0))

;; do not blink the cursor
(blink-cursor-mode 0)

;; save emacs session on exit ;; run desktop-read manually to load the session
(require 'desktop)
(setq desktop-save 1
      desktop-load-locked-desktop t
      desktop-dirname user-emacs-directory
      desktop-restore-frames nil
      ; Don't save remote files and/or *gpg files.
      desktop-files-not-to-save "\\(^/[^/:]*:\\|(ftp)$\\)\\|\\(\\.gpg$\\)")
(desktop-save-mode 1)

;; use fixed font
(add-to-list 'default-frame-alist
             '(font . "Ubuntu Mono-12:hintstyle=hintslight"))

;; do not display the right-fringe
(add-to-list 'default-frame-alist '(right-fringe . 0))

;; set cursor color to green
(add-to-list 'default-frame-alist '(cursor-color . "green"))

;; use short hands for yes or no questions
(fset 'yes-or-no-p 'y-or-n-p)

;; highlight unnecessary spaces and long lines with more than 79 characters
;; (except in term buffers)
(require 'whitespace)
(global-whitespace-mode 1)
(setq whitespace-style '(face trailing empty))
(setq whitespace-global-modes
      '(not term-mode erc-mode fundamental-mode))

;; display column number on the mode-line
(column-number-mode 1)

;; display date and time on the mode-line
(display-time-mode 1)

;; use unique buffer names with directory name prefix
(when (require 'uniquify nil 'noerror)
  (setq uniquify-buffer-name-style 'forward))

;; use ido-mode for opening files
(ido-mode t)

;; Use ido for M-x completion
(global-set-key
 "\M-x"
 (lambda ()
   (interactive)
   (call-interactively
    (intern
     (ido-completing-read
      "M-x "
      (all-completions "" obarray 'commandp))))))

;; enable password caching for encryption
;; (require 'epa-file)
;; (epa-file-enable)
(setq epa-file-cache-passphrase-for-symmetric-encryption t)

;; highlight matching parenthsis
(show-paren-mode 1)

;; enable melpa package repo
(when (require 'package nil 'noerror)
  (add-to-list 'package-archives
	       '("melpa-stablle" . "http://stable.melpa.org/packages/") t)
  (add-to-list 'package-archives
	       '("melpa" . "https://melpa.org/packages/")))

;; add google coding style
(require 'google-c-style)

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
;(when (string= system-name "copper.corp.nutanix.com")
;  (load-file "~/config/emacs/nutanix.el"))

;; disable bold fonts and underlines globally
(mapc
 (lambda (face)
   (set-face-attribute face nil :weight 'normal :underline nil))
 (face-list))

;; better window switching for large screens
(global-set-key [C-left] 'windmove-left)
(global-set-key [C-right] 'windmove-right)
(global-set-key [C-up] 'windmove-up)
(global-set-key [C-down] 'windmove-down)

;; set keybindings for magit
(when (require 'magit nil 'noerror)
  (global-set-key (kbd "C-c g") 'magit-status))

;; set keybinding for compile
(global-set-key (kbd "C-c c") 'recompile)

;; auto-scroll compilation output buffer.
(setq compilation-scroll-output t)

;; load support for protobuf mode.
(require 'protobuf-mode)
(add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode))

;; delete trailing whitespace on save.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; display flymake errors in the minibuffer.
(require 'flymake-cursor)

;; load gtags for gtags-mode.
(require 'gtags)

;; volume control for emacs.
(autoload 'volume "volume"
  "Tweak your sound card volume." t)

;; open the default org-mode file on startup.
(setq initial-buffer-choice "~/default.org")

;; read dir-locals.el from remote hosts also.
(setq enable-remote-dir-locals t)

;; if el-go is checked out, load it.
(when (file-exists-p "~/tools/el-go.git")
  (add-to-list 'load-path "~/tools/el-go.git"))

;; configure go environment.
(setq gofmt-command "goimports")

;; enable column-marker in certain modes; whitespace mode doesn't consider
;; tab-width when counting column numbers, so is not good enough.
(when (require 'column-marker nil 'noerror)
  (progn
    (add-hook 'protobuf-mode-hook (lambda() (column-marker-1 80)))
    (add-hook 'go-mode-hook (lambda() (column-marker-1 80)))
    (add-hook 'c-mode-hook (lambda() (column-marker-1 80)))
    (add-hook 'c++-mode-hook (lambda() (column-marker-1 80)))))
