(in-package #:chronoton/home/lights)

(defun start-system ()
  (log:info "Starting Light Control system.")
  ;; TODO configuration
  (cs/hue:start-heartbeat :changeset-cb (lambda (lights)
                                          (mapc (lambda (light)
                                                  (hack-reset-hue-light-if-on-factory-settings (hack-cl-hue-light-to-hue-light light))) lights))))

(defun stop-system ()
  (log:info "Stopping Light Control system.")
  (cs/hue:stop-heartbeat))

(defun hue-factory-settings-p (light)
  (and (light-state light)
       (= (light-color-temperature light) 370)
       (= (light-brightness light) 254)))

(defun hack-cl-hue-light-to-hue-light (light)
  (make-instance 'hue-light
                 :number (cl-hue::light-number light)
                 :hue-state light))

(defun hack-reset-hue-light-if-on-factory-settings (light)
  (when (hue-factory-settings-p light)
    (reset-hue-light light)))

(defun reset-hue-light (light)
  (log:debug "Resetting light" light)
  ;; hack hack hack
  (cl-hue::set-light-state-by-number cs/hue::*bridge* (light-number light)
                                     :on t
                                     :brightness 254
                                     :ct 233
                                     :transitiontime 2))
