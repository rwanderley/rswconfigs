;;; my-twit.el: rwanderley's twit.el configuration.  Interface to twitter.com
;;

(require 'twit)

(load-file "~/.twitter")

(setq twit-user twitter-user
      twit-pass twitter-pass)

(provide 'my-twit)
