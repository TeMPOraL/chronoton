(defpackage #:chronoton/service/hue
  (:nicknames #:chrono/serv/hue
              #:cs/hue)
  (:use #:cl
        #:chronoton
        #:chronoton/core)

  (:export #:initialize
           #:deinitialize

           #:get-light-by-number

           #:start-heartbeat
           #:stop-heartbeat
           #:reset-heartbeat
           #:heartbeat-running-p))

(defpackage #:chronoton/service/pushover
  (:nicknames #:chrono/serv/pushover
              #:cs/pushover)
  (:use #:cl
        #:chronoton)

  (:export #:initialize
           #:deinitialize

           #:send-info
           #:send-alert))


(defpackage #:chronoton/service/http-server
  (:nicknames #:chrono/serv/http-server
              #:cs/http-server)

  (:use #:cl
        #:chronoton
        #:chronoton/core)
  ;; TODO exports
  )
