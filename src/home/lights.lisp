(in-package #:chronoton/home/lights)

(defun start-system ()
  (log:info "Starting Light Control system.")
  ;; TODO configuration
  (cs/hue:start-heartbeat))

(defun stop-system ()
  (log:info "Stopping Light Control system.")
  (cs/hue:stop-heartbeat))
