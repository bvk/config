;; customize golang environment
(setq gofmt-command "goimports")
(setq godoc-command "godoc")

;; enable column-marker in certain modes; whitespace mode doesn't consider
;; tab-width when counting column numbers, so is not good enough.
(when (require 'column-marker nil 'noerror)
  (add-hook 'go-mode-hook (lambda() (column-marker-1 80))))
