(add-to-list 'load-path "~/tools/xelb.git/")
(add-to-list 'load-path "~/tools/exwm.git/")

(require 'exwm)
(require 'exwm-config)

(setq exwm-workspace-number 10)
(exwm-config-ido)

;; "C-c o" is for switching workspaces.
(exwm-input-set-key
 (kbd "C-c o") #'exwm-workspace-switch)

;; Line-editing shortcuts
(exwm-input-set-simulation-keys
 '(([?\C-b] . left)
   ([?\C-f] . right)
   ([?\C-p] . up)
   ([?\C-n] . down)
   ([?\C-a] . home)
   ([?\C-e] . end)
   ([?\M-v] . prior)
   ([?\C-v] . next)
   ([?\C-d] . delete)))

;; Make class name the buffer name
(add-hook 'exwm-update-class-hook
	  (lambda ()
	    (exwm-workspace-rename-buffer exwm-class-name)))

;; "C-c t" is for terminal.
(exwm-input-set-key
 (kbd "C-c t")
 (lambda () (interactive)
   (start-process "urxvt" "*Messages*"
		  "urxvt"
		  "-pe" "tabbed"
		  "-fn" "xft:Ubuntu Mono-10:hintstyle=hintslight"
		  "-e" "bash")))

;; "C-c i" is for internet browser.
(exwm-input-set-key
 (kbd "C-c i")
 (lambda () (interactive)
   (start-process "browser" "*Messages*"
		  "google-chrome")))

;; "C-c l" is for lock.
(exwm-input-set-key
 (kbd "C-c l")
 (lambda () (interactive)
   (start-process "slock" "*Messages*" "slock")))

;; Enable exwm.
(exwm-enable)

;; Enable exwm system tray.
(require 'exwm-systemtray)
(exwm-systemtray-enable)

;; start network-manager system-tray applet.
(defun my-nm-applet ()
  "Starts nm-applet process in the background."
  (interactive)
  (start-process "network-manager" "*Messages*" "nm-applet" "-n"))

;; adjust keyboard repeat rate.
(defun my-keyboard-rate ()
  "Adjusts keyboard repeat rate to 200."
  (interactive)
  (start-process "xset" "*Messages*" "xset" "r" "rate" "200" "60"))

;; restart network manager.
(defun my-restart-network-manager ()
  "Restart network-manager service."
  (interactive)
  (start-process "nm" "*Messages*"
		 "sudo"
		 "service" "network-manager" "restart"))
