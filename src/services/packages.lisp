(defpackage #:chrono/hue
  (:use #:cl
        #:chronoton)

  (:export #:load-configuration
           #:save-configuration))

(defpackage #:chrono/pushover
  (:use #:cl
        #:chronoton)

  (:export #:load-configuration
           #:save-configuration

           #:send-info
           #:send-alert))

