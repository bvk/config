(require 'exwm)
(require 'exwm-config)
(require 'exwm-randr)
(require 'exwm-systemtray)

;; Define number of workspaces.
(setq exwm-workspace-number 10)

;; "C-c o" is for switching workspaces.
(exwm-input-set-key
 (kbd "C-c o") #'exwm-workspace-switch)

;; "C-c m" is for moving the workspace number.
(exwm-input-set-key
 (kbd "C-c m") #'exwm-workspace-move)

;; Make class name the buffer name
(add-hook 'exwm-update-class-hook
	  (lambda ()
	    (exwm-workspace-rename-buffer exwm-class-name)))

;; Enable emacs keybindings in selected apps based on their window class name.
(setq my-simulation-key-window-classes '("Google-chrome" "Firefox"))
(add-hook 'exwm-manage-finish-hook
					(lambda ()
						(when (and exwm-class-name (member exwm-class-name my-simulation-key-window-classes))
							(exwm-input-set-local-simulation-keys
							 '(([?\C-b] . left)
								 ([?\C-f] . right)
								 ([?\C-p] . up)
								 ([?\C-n] . down)
								 ([?\C-a] . home)
								 ([?\C-e] . end)
								 ([?\M-v] . prior)
								 ([?\C-v] . next)
								 ([?\C-d] . delete))))))

;; Enable two xrandr outputs one named 'default' and another named 'other'.
(defun my-exwm-xrandr-two-outputs (default other)
  (shell-command
   (concat "xrandr --output " other " --right-of " default " --auto")))

;; Enable only one xrandr output named 'default'.
(defun my-exwm-xrandr-one-output (default)
  (shell-command (concat "xrandr --output " default " --auto")))

;; Disable xrandr output named 'output'.
(defun my-exwm-xrandr-off (output)
  (if output (shell-command (concat "xrandr --output " output " --off"))))

;; Update exwm-randr-workspace-output-plist with two outputs named
;; 'default' and 'other'.  If the 'other' output is same as 'default'
;; then all workspaces will be redirected to the 'default' output.
(defun my-exwm-xrandr-config (default other)
  (setq exwm-randr-workspace-output-plist
	(progn
	  (setq result (list 0 default))
	  (setq index 1)
	  (while (< index exwm-workspace-number)
	    (setq result (append result (list index other)))
	    (setq index (1+ index)))
	  result)))

;; Dynamically find the active xrandr outputs and update exwm
;; workspace configuration and enable xrandr outputs appropriately.
(defun my-exwm-xrandr-hook (default)
  (let* ((connected-cmd "xrandr -q|awk '/ connected/ {print $1}'")
	 (connected (process-lines "bash" "-lc" connected-cmd))
	 (previous (delete-dups (seq-remove
				 'integerp
				 exwm-randr-workspace-output-plist))))
    (cond ((member "DP-1" connected)
	   (progn (my-exwm-xrandr-config default "DP-1")
		  (my-exwm-xrandr-two-outputs default "DP-1")))
	  ((member "DP-2" connected)
	   (progn (my-exwm-xrandr-config default "DP-2")
		  (my-exwm-xrandr-two-outputs default "DP-2")))
	  ((member "HDMI-1" connected)
	   (progn (my-exwm-xrandr-config default "HDMI-1")
		  (my-exwm-xrandr-two-outputs default "HDMI-1")))
	  ((member "HDMI-2" connected)
	   (progn (my-exwm-xrandr-config default "HDMI-2")
		  (my-exwm-xrandr-two-outputs default "HDMI-2")))
	  (t (progn (my-exwm-xrandr-config default default)
		    (mapcar 'my-exwm-xrandr-off
			    (delete default previous)))))))

(setq exwm-randr-screen-change-hook
      (lambda () (my-exwm-xrandr-hook "eDP-1")))

;; Pick some height for the system tray. Some applet icons don't appear
;; otherwise.
(setq exwm-systemtray-height 24)

;; Disable floating windows completely.
;(setq exwm-manage-force-tiling t)

;; show mode-line on floating windows.
(add-hook 'exwm-floating-setup-hook #'exwm-layout-show-mode-line)

;; Enable exwm.
(exwm-enable)
(exwm-systemtray-enable)
(exwm-randr-enable)

;; "C-c t" is for terminal.
(exwm-input-set-key
 (kbd "C-c t")
 (lambda () (interactive)
	 (if (get-buffer "XTerm")
			 (switch-to-buffer "XTerm")
		 (start-process "xterm" "*Messages*"
		  "xterm"
		  "-fa" "xft:Ubuntu Mono-10:hintstyle=hintslight"
		  "-e" "bash"))))

;; "C-c T" is for terminal.
(exwm-input-set-key
 (kbd "C-c T")
 (lambda () (interactive)
   (start-process "xterm" "*Messages*"
		  "xterm"
		  "-fa" "xft:Ubuntu Mono-16:hintstyle=hintslight"
		  "-e" "bash")))

;; "C-c i" is for internet browser.
(exwm-input-set-key
 (kbd "C-c i")
 (lambda () (interactive)
   (start-process "browser" "*Messages*" "google-chrome")))

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
