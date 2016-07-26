(in-package #:chrono/hue)

(defparameter *bridge-endpoint* "" "Endpoint of the Hue Bridge.")
(defparameter *username* "" "Hue API user to pass in API calls.")

(defparameter *default-transition-time* 4 "Default transition time (in 1/10ths of the second).")

(defvar *bridge* nil "Hue Bridge instance.")
(defvar *lights* nil "Cached list of Hue lights.")

(defun load-configuration ()
  )

(defun save-configuration ()
  )

(defun initialize ()
  (log:debug "Initializing Hue connection to ~A." *bridge-endpoint*)
  (setf *bridge* (cl-hue:make-bridge *bridge-endpoint* *username*)))

(defun fetch-lights ()
  (setf *lights* (cl-hue:get-lights *bridge*))
  (log:debug *lights*))

;;; utility functions / playing around
(defmethod light-on ((light cl-hue:light) &optional (transition-time *default-transition-time*))
  (log:debug "Turning on light #~A (~A) over ~A ms." (cl-hue::light-number light) (cl-hue::light-name light) (* 100 transition-time))
  (cl-hue:set-light-state-by-number *bridge* (cl-hue::light-number light) :on t :brightness 255 :transitiontime transition-time))

(defmethod light-off ((light cl-hue:light) &optional (transition-time *default-transition-time*))
  (log:debug "Turning off light #~A (~A) over ~A ms." (cl-hue::light-number light) (cl-hue::light-name light) (* 100 transition-time))
  (cl-hue:set-light-state-by-number *bridge* (cl-hue::light-number light) :on nil :brightness 255 :transitiontime transition-time))

(defun lights-all-off ()
  (mapc #'light-off *lights*))

(defun lights-all-on ()
  (mapc #'light-on *lights*))

;;; printer

(defmethod print-object ((light cl-hue:light) stream)
  (print-unreadable-object (light stream :type t :identity t)
    (format stream "#~A (~A)" (cl-hue::light-number light) (cl-hue::light-name light))))
