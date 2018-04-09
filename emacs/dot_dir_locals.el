;; This file defines .dir-locals.el for all projects.  Users are
;; expected to link $HOME/.dir-locals.el to this file.

((nil . ((tab-width . 2)
	 (fill-column . 79)))

 (c++-mode . ((mode . electric-indent)
	      (mode . gtags)
              (eval . (progn
			(google-set-c-style)
			(add-hook 'before-save-hook
				  'delete-trailing-whitespace nil t)))))

 (go-mode . ((eval . (add-hook 'before-save-hook 'gofmt-before-save))))

 (protobuf-mode . ((tab-width . 2)
		   (indent-tabs-mode . nil)))

 (js-mode . ((js-indent-level . 2)
	     (tab-width . 2)
	     (indent-tabs-mode . nil)))

 ;;
 ;; Directory path specific settings
 ;;

 ("zion.sh/code.repo"
  . ((nil
      . ((tab-width . 2)
         (fill-column . 79)
	 (eval
	  . (set (make-local-variable 'compile-command)
		 "make -k -C ~/zion.sh/code.repo check"))))

     (c++-mode
      . ((fill-column . 79)
         (mode . gtags)
         (mode . electric-indent)
         (eval . (progn
                   (google-set-c-style)
                   (add-hook 'before-save-hook
                             'delete-trailing-whitespace nil t)))))

     (protobuf-mode
      . ((tab-width . 2)
         (indent-tabs-mode . nil)))

     (js-mode
      . ((js-indent-level . 2)
	 (tab-width . 2)
         (indent-tabs-mode . nil)))

     (go-mode
      . ((eval
          . (add-hook 'before-save-hook 'gofmt-before-save)))))))
