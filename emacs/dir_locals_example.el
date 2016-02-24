((nil . ((fill-column . 79)
         (eval . (progn (setq compile-command (format "make -C %s -k "
                                                      (locate-dominating-file
                                                       default-directory
                                                       "Makefile")))))))

 (c-mode . ((indent-tabs-mode . nil)
	    (mode . gtags)
            (eval . (progn
		      (add-hook 'before-save-hook
				'delete-trailing-whitespace nil t))))))
