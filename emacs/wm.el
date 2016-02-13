(add-to-list 'load-path "~/tools/xelb.git/")
(add-to-list 'load-path "~/tools/exwm.git/")

(require 'exwm)
(require 'exwm-config)
(exwm-config-default)

(setq exwm-workspace-number 10)

(exwm-input-set-simulation-keys
 '(([?\C-b] . left)
   ([?\C-f] . right)
   ([?\C-p] . up)
   ([?\C-n] . down)
   ([?\C-a] . home)
   ([?\C-e] . end)
   ([?\M-v] . prior)
   ([?\C-v] . next)))

(exwm-enable)

;; s-t for terminal.
(exwm-input-set-key
 (kbd "s-t")
 (lambda () (interactive)
   (start-process "urxvt" "*Messages*"
		  "urxvt"
		  "-fn" "xft:Ubuntu Mono-12:hintstyle=hintslight"
		  "-e" "bash" "-l")))

;; s-l for lock.
(exwm-input-set-key
 (kbd "s-l")
 (lambda () (interactive)
   (start-process "slock" "*Messages*" "slock")))
