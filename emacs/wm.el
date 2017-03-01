(add-to-list 'load-path "~/tools/xelb.git/")
(add-to-list 'load-path "~/tools/exwm.git/")

(require 'exwm)
(require 'exwm-config)
(require 'exwm-randr)
(require 'exwm-systemtray)

;; Define number of workspaces.
(setq exwm-workspace-number 10)

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

;; Setup external monitor.
(setq exwm-randr-workspace-output-plist
      '(0 "eDP1"
	 1 "HDMI2"
	 2 "HDMI2"
	 3 "HDMI2"
	 4 "HDMI2"
	 5 "HDMI2"
	 6 "HDMI2"
	 7 "HDMI2"
	 8 "HDMI2"
	 9 "HDMI2"))
(setq my-laptop-output "eDP1")
(setq my-monitor-output "HDMI2")
(setq exwm-randr-screen-change-hook
      (lambda ()
	(start-process-shell-command
	 "xrandr" nil "xrandr --output " my-monitor-output
	 " --right-of " my-laptop-output " --auto")))

;; Pick some height for the system tray. Some applet icons don't appear
;; otherwise.
(setq exwm-systemtray-height 24)

;; Enable exwm.
(exwm-enable)
(exwm-systemtray-enable)
(exwm-randr-enable)

;; "C-c t" is for terminal.
(exwm-input-set-key
 (kbd "C-c t")
 (lambda () (interactive)
   (start-process "urxvt" "*Messages*"
		  "urxvt"
		  "-pe" "tabbed"
		  "-fn" "xft:Ubuntu Mono-10:hintstyle=hintslight"
		  "-e" "bash")))

;; "C-c T" is for terminal.
(exwm-input-set-key
 (kbd "C-c T")
 (lambda () (interactive)
   (start-process "urxvt" "*Messages*"
		  "urxvt"
		  "-pe" "tabbed"
		  "-fn" "xft:Ubuntu Mono-16:hintstyle=hintslight"
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

;; "C-c r" is for xrandr setup.
(exwm-input-set-key
 (kbd "C-c r")
 (lambda () (interactive)
   (start-process "xrandr" "*Messages*" "xrandr" "-q")))

;; "C-c k" is to adjust keyboard repeat rate.
(exwm-input-set-key
 (kbd "C-c k")
 (lambda () (interactive)
  (start-process "xset" "*Messages*" "xset" "r" "rate" "200" "60")))

;; restart network manager.
(defun my-restart-network-manager ()
  "Restart network-manager service."
  (interactive)
  (start-process "nm" "*Messages*"
		 "sudo"
		 "service" "network-manager" "restart"))

(add-hook 'exwm-floating-setup-hook
	  (lambda ()
	    (progn
	      (setq mode-line-format
		    (list mode-line-modes mode-line-buffer-identification))
	      (exwm-layout-show-mode-line))))
