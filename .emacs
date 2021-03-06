;;; .emacs: rwanderley's Emacs configurations
;;
;; This configurations are for GNU Emacs 23, but should work with any
;; recent Emacs version with few modifications.
;;
;; I've split the code this way:
;;
;; - .emacs:    This file contains configuration that should be common to
;;              all modes
;;
;; - .emacs.d/: This directory contains mode specific configurations,
;;              usually one file per mode.  The naming follows the
;;              my-<modename>.el convention
;;
;; - .elisp.d/: Contains mode surces.  I prefer to put the path here
;;              instead at the system /usr/share/emacs folder

(add-to-list 'load-path "/home/rwanderley/.elisp.d")
(add-to-list 'load-path "/home/rwanderley/.emacs.d")

;; load my module configurations
(require 'my-ratpoison)
(require 'my-flyspell)
(require 'my-erc)
(require 'my-twit)

;; Remove some non-usefull graphical elements
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; let us support colors
(ansi-color-for-comint-mode-on)

;; Set default browser to firefox
(setq browse-url-browser-function 'browse-url-firefox
      browse-url-new-window-flag t
      browse-url-firefox-new-window-is-tab t)

;; This is for ratpoison.  Do not let ediff open other windows
(setq ediff-windows-setup-function 'ediff-setup-winows-plain)

;; scroll output automatically as it apears on the *compilation*
;; buffer
(setq compilation-scroll-output t)

;; nice having the time displayed on the mini bar.
(display-time)

;; start emacs server, in order to be able to use emacsclient command
(server-start)

;; A better way to handle backups IMO
(setq backup-directory-alist
      (list
       (cons ".*"
	     (expand-file-name  "~/.emacsbackup/"))))

;; Had a problem with that one, having to redefine it here
(global-set-key "\C-x\C-c" 'save-buffers-kill-emacs)

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))
