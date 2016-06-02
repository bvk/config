((nil . ((fill-column . 79)
         (eval . (progn
		   (make-local-variable 'compile-command)
		   (setq compile-command (format "make -C %s -k "
						 (locate-dominating-file
						  default-directory
						  "Makefile")))))))

 (c-mode . ((indent-tabs-mode . nil)
	    (mode . gtags)
            (eval . (progn
		      (add-hook 'before-save-hook
				'delete-trailing-whitespace nil t)))))
 (go-mode . ((fill-column . 79)
	     (delete-trailing-whitespace)
	     (mode . flyspell-prog)
	     (mode . electric-indent)
	     (tab-width . 2)
	     (eval . (progn
		       (make-local-variable 'process-environment)
		       (setenv "GOPATH" (locate-dominating-file
					 buffer-file-name
					 "src"))
		       (setq gofmt-command "goimports")
		       (local-set-key (kbd "M-.") 'godef-jump)
		       (local-set-key (kbd "C-c h") 'godoc)
		       (add-hook 'before-save-hook 'gofmt-before-save))))))
