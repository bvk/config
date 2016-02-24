(add-to-list 'load-path "~/tools/xelb.git/")
(add-to-list 'load-path "~/tools/exwm.git/")

(require 'exwm)
(require 'exwm-config)
(require 'exwm-systemtray)

(exwm-config-default)
(setq exwm-workspace-number 10)
(exwm-enable)
(exwm-systemtray-enable)

;; start network-manager system-tray applet.
(start-process "network-manager" "*Messages*" "nm-applet" "-n")

;; "C-c t" is for terminal.
(exwm-input-set-key
 (kbd "C-c t")
 (lambda () (interactive)
   (start-process "urxvt" "*Messages*"
		  "urxvt"
		  "-fn" "xft:Ubuntu Mono-10:hintstyle=hintslight"
		  "-e" "bash" "-l")))

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

;; "C-c o" is for switching workspaces.
(exwm-input-set-key
 (kbd "C-c o")
 'exwm-workspace-switch)
