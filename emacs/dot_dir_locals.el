;; This file defines .dir-locals.el for all projects.  Users are
;; expected to link $HOME/.dir-locals.el to this file.

(("cloudsimple/storelink.repo"
  . ((nil
      . ((tab-width . 2)
	 (fill-column . 79)
	 (eval
	  . (set (make-local-variable 'compile-command)
		 "make -C ~/cloudsimple/storelink.repo builder-all"))))

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

     (go-mode
      . ((eval
	  . (add-hook 'before-save-hook 'gofmt-before-save))))))

 ("cloudsimple/control-plane.repo"
  . ((nil
      . ((tab-width . 2)
	 (fill-column . 79)))

     (go-mode
      . ((eval
	  . (add-hook 'before-save-hook 'gofmt-before-save)))))))
