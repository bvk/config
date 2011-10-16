(require 'smtpmail)
(require 'auth-source)

;; Force encrypted authinfo.
(setq auth-sources '("~/.authinfo.gpg"))

;; Returns the value in the 'from' field of a message-mode buffer.
(defun mysmtp-get-from-address ()
  (save-excursion
    (save-restriction
      (message-narrow-to-headers)
      (message-fetch-field "from"))))

;; Returns (username domain) list from an ADDRESS.
(defun mysmtp-get-username-domain (address)

  (let* ((ignored (string-match "\\<\\([A-Za-z.]+\\)\\(@[A-Za-z.]+\\)\\>"
				address))
	 (username (match-string 1 address))
	 (domain (match-string 2 address)))
    (list username domain)))

;; List of domain names that require the domain name suffix for smtp
;; login.
(setq mysmtp-domain-suffix-domains
      (list "@gmail.com" "@nutanix.com"))

;; List of domain names that ignore "." in the usernames.
(setq mysmtp-ignore-dot-domains
      (list "@gmail.com" "@nutanix.com"))

;; Returns the login name to be used for smtp login.
(defun mysmtp-get-smtp-login ()
  (let* ((address (mysmtp-get-from-address))
	 (p (mysmtp-get-username-domain address))
	 (username (nth 0 p))
	 (domain (nth 1 p))
	 (username-wo-dots (replace-regexp-in-string "\\." "" username)))
    (if (member domain mysmtp-domain-suffix-domains)
	(if (member domain mysmtp-ignore-dot-domains)
	    (concat username-wo-dots domain)
	  (concat username domain))
      (if (member domain mysmtp-ignore-dot-domains)
	  username-wo-dots
	username))))

(defun mysmtp-update-smtp-user ()
  (setq smtpmail-smtp-user (mysmtp-get-smtp-login)))

(add-hook 'message-send-hook 'mysmtp-update-smtp-user)
