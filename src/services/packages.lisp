(defpackage #:chrono/hue
  (:use #:cl
        #:chronoton
        #:chronoton/core)

  (:export #:initialize
           #:deinitialize))

(defpackage #:chrono/pushover
  (:use #:cl
        #:chronoton)

  (:export #:initialize
           #:deinitialize

           #:send-info
           #:send-alert))

