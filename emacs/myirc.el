(require 'rcirc)

;; Do not display JOIN, QUIT, etc. messages
(add-hook 'rcirc-mode-hook (lambda () (rcirc-omit-mode)))

;; Show alerts on mode-line when messages are addressed to me
(add-hook 'rcirc-mode-hook (lambda () (rcirc-track-minor-mode 1)))