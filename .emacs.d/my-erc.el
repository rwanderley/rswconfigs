;;; my-erc.el: rwanderley's erc configuration file
;;
;; I use erc mostly to connect to a bitlebee channel and to freenode.
;; Some keybidings are global.

(require 'erc)
(require 'my-flyspell)
(require 'erc-spelling)
(require 'erc-services)
(require 'erc-log)

(erc-services-mode 1)

;; Set encoding to utf-8
(setq erc-server-coding-system 'utf-8
      erc-encoding-coding-alist nil
      erc-server-coding-system nil)

(erc-spelling-enable)

;; Should change this to hook.
(defadvice erc-spelling-init (after erc-spelling-init-choose-dict)
  (when (and erc-server-announced-name
   (string-match "localhost" erc-server-announced-name))
    (ispell-change-dictionary "brasileiro")))
(ad-activate 'erc-spelling-init)

(setq erc-spelling-dictionaries
      '(("#archlinux.br" "brasileiro")))

;; Ignore messages from the server that are not channel activity
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                "324" "329" "332" "333" "353" "477"))
(setq erc-track-exclude '("&bitlbee"))

;; set up nickserv
(load "~/.ercpass")
(setq erc-prompt-for-nickserv-password nil)
(setq erc-nickserv-passwords
      `((freenode (("rwanderley" . ,freenodepass)))))

(setq erc-autojoin-channels-alist '(("freenode.net"
				     "#emacs"
				     "#archlinux.br")))

;; Conect to freenode with C-c e f
(global-set-key "\C-cef" (lambda ()
			   (interactive)
			   (erc :server "irc.freenode.net"
				:port "6667"
				:nick "rwanderley")))
 
;; Conect to Bitlbee with C-c e b
(global-set-key "\C-ceb" (lambda ()
			   (interactive)
			   (erc :server "localhost"
				:port "6667"
				:nick "rwanderley")))

(add-hook 'erc-join-hook 'bitlbee-identify)
(defun bitlbee-identify ()
  "If we're on the bitlbee server, send the identify command to the
 &bitlbee channel."
  (when (and (string= "localhost" erc-session-server)
	     (string= "&bitlbee" (buffer-name)))
    (erc-message "PRIVMSG" (format "%s identify %s"
				   (erc-default-target)
				   bitlbeepass))))

(defun rsw/erc-count-users ()
  "Count the users in current channel"
  (interactive)
  (let ((n 0))
    (maphash '(lambda (nick data) (incf n)) erc-channel-users)
    n))
 
(defun erc-cmd-COUNT ()
  "Count command just counts how many users are on the channel
showing the results on minibuffer"
  (message (format "%d users on this Channel." (rsw/erc-count-users))))
 
(setq erc-auto-query 'bury)
 
;; configure logging
(setq erc-enable-logging t
      erc-log-channels t
      erc-log-channels-directory "~/erc-log"
      erc-save-buffer-on-part nil
      erc-save-queries-on-quit nil
      erc-log-write-after-send t
      erc-log-write-after-insert t)
 
(defadvice save-buffers-kill-emacs (before save-logs (arg) activate)
  (save-some-buffers t (lambda () (when (and (eq major-mode 'erc-mode)
                                             (not (null buffer-file-name)))))))
 
(add-hook 'erc-insert-post-hook 'erc-save-buffer-in-logs)
(add-hook 'erc-mode-hook '(lambda () (when (not (featurep 'xemacs))
                                       (set (make-variable-buffer-local
                                             'coding-system-for-write)
                                            'emacs-mule))))
 
(provide 'my-erc)