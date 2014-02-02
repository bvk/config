(require 'mu4e)
(require 'smtpmail)

(setq mu4e-drafts-folder "/home/bvk/Maildir/Drafts"
      mu4e-sent-folder   "/home/bvk/Maildir/Sent Mail"
      mu4e-trash-folder  "/home/bvk/Maildir/Trash"
      mu4e-sent-messages-behavior 'delete
      mu4e-get-mail-command "offlineimap"
      mu4e-update-interval 60
      user-mail-address "bvkchaitanya@gmail.com"
      user-full-name  "BVK Chaitanya"
      mu4e-maildir-shortcuts
            '( ("/home/bvk/Maildir/Personal/[Gmail].All Mail"  . ?i)
               ("/home/bvk/Maildir/Personal/[Gmail].Sent Mail" . ?s)
               ("/home/bvk/Maildir/Personal/Trash"             . ?t))

     message-send-mail-function 'smtpmail-send-it
     smtpmail-stream-type 'starttls
     smtpmail-default-smtp-server "smtp.gmail.com"
     smtpmail-smtp-server "smtp.gmail.com"
     smtpmail-smtp-service 587
     message-kill-buffer-on-exit t)

;; define only variables that differ for the two accounts
(defvar my-mu4e-account-alist
  '(("Personal"
     (mu4e-drafts-folder "/home/bvk/Maildir/Personal/[Gmail].Drafts")
     (mu4e-sent-folder   "/home/bvk/Maildir/Personal/[Gmail].Sent Mail")
     (mu4e-trash-folder  "/home/bvk/Maildir/Personal/Trash")
     (user-mail-address  "bvkchaitanya@gmail.com")
     (smtpmail-default-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-service 587))

  '(("Nutanix"
     (mu4e-drafts-folder "/home/bvk/Maildir/Nutanix/[Gmail].Drafts")
     (mu4e-sent-folder   "/home/bvk/Maildir/Nutanix/[Gmail].Sent Mail")
     (mu4e-trash-folder  "/home/bvk/Maildir/Nutanix/Trash")
     (user-mail-address  "bvk@nutanix.com")
     (smtpmail-default-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-server "smtp.gmail.com")
     (smtpmail-smtp-service 587)))))

(defun my-mu4e-set-account ()
  "Set the account for composing a message."
  (let* ((account
    (if mu4e-compose-parent-message
      (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
        (string-match "/\\(.*?\\)/" maildir)
        (match-string 1 maildir))
        (completing-read (format "Compose with account: (%s) "
          (mapconcat #'(lambda (var) (car var)) my-mu4e-account-alist "/"))
          (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
          nil t nil nil (caar my-mu4e-account-alist))))
        (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
        (mapc #'(lambda (var)
                  (set (car var) (cadr var)))
              account-vars)
      (error "No email account found"))))

(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)

(setq mu4e-view-show-images t)
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))
(setq mu4e-view-prefer-html t)
(setq mu4e-html2text-command "html2text -utf8 -width 72")
(setq mail-user-agent 'mu4e-user-agent)
