(require 'make-theme)

(let
    ((patterns-alist
      '(("pattern"
         (inactive . "#000000")
         (focused . "#AAFFAA"))))

     (frames-alist
      '(("default"
         ((height . 1)
          (left-edge . -1)
          (top-edge . -1)
          (right-edge . -1)
          (background . "pattern")
          (class . top-border))
         ((width . 1)
          (bottom-edge . -1)
          (left-edge . -1)
          (top-edge . 0)
          (background . "pattern")
          (class . left-border))
         ((top-edge . 0)
          (right-edge . -1)
          (bottom-edge . -1)
          (width . 1)
          (background . "pattern")
          (class . right-border))
         ((bottom-edge . -1)
          (right-edge . -1)
          (left-edge . 0)
          (height . 1)
          (background . "pattern")
          (class . bottom-border)))))

     (mapping-alist
      '((default . "default")
        (unframed . "")))

     (theme-name 'zen))

  (add-frame-style
   theme-name (make-theme patterns-alist frames-alist mapping-alist))
  (when (boundp 'mark-frame-style-editable)
    (mark-frame-style-editable theme-name)))
