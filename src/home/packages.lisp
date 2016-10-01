;;; packages.lisp
(defpackage #:chronoton/home/lights
  (:nicknames #:chrono/home/lights
              #:ch/lights)

  (:use #:cl
        #:chronoton
        #:chronoton/core)

  (:export #:start-system
           #:stop-system

           ;; CLOS
           #:light
           #:hue-light))
