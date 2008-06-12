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
