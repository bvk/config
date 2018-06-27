(setq extra-path-list '("~/bin" "~/go/bin" "~/opt/bin" "~/.local/bin"
			"/usr/local/bin"))


(setenv "PATH" (concat (getenv "PATH") ":"
		       (mapconcat 'expand-file-name extra-path-list ":")))
(setq exec-path (append exec-path (mapcar 'expand-file-name extra-path-list)))
