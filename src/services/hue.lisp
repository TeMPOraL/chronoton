(in-package #:chrono/hue)

(defparameter *bridge-endpoint* "" "Endpoint of the Hue Bridge.")
(defparameter *username* "" "Hue API user to pass in API calls.")

(defparameter *default-transition-time* 4 "Default transition time (in 1/10ths of the second).")

(defvar *bridge* nil "Hue Bridge instance.")
(defvar *lights* nil "Cached list of Hue lights.")

(defun initialize ()
  (log:info "Initializing Hue service.")
  (load-configuration)
  (setup-bridge)
  (fetch-lights)
  (blink-all-lights))

(defun deinitialize ()
  (log:info "Deinitializing Hue service.")
  (save-configuration))

(defun load-configuration ()
  (log:debug "No configuration to load.")
  ;; TODO fetch lights / rooms defaults
  
  )

(defun save-configuration ()
  (log:debug "No configuration to save.")
  ;; TODO fetch lights / rooms defaults
  )

(defun setup-bridge ()
  (log:info "Setting up a Hue bridge at ~A." *bridge-endpoint*)
  (setf *bridge* (cl-hue:make-bridge *bridge-endpoint* *username*)))

(defun fetch-lights ()
  (setf *lights* (cl-hue:get-lights *bridge*))
  (log:debug *lights*))

;;; utility functions / playing around
;;; TODO make -all- functions utilize Group API instead

(defmethod light-on ((light cl-hue:light) &optional (transition-time *default-transition-time*))
  (log:info "Turning on light #~A (~A) over ~A ms." (cl-hue::light-number light) (cl-hue::light-name light) (* 100 transition-time))
  (cl-hue:set-light-state-by-number *bridge* (cl-hue::light-number light) :on t :transitiontime transition-time))

;;; FIXME this method is broken - somehow it sets the light brightness to 1. Probably transition time issue.
(defmethod light-off ((light cl-hue:light) &optional (transition-time *default-transition-time*))
  (log:info "Turning off light #~A (~A) over ~A ms." (cl-hue::light-number light) (cl-hue::light-name light) (* 100 transition-time))
  (cl-hue:set-light-state-by-number *bridge* (cl-hue::light-number light) :on nil :transitiontime transition-time))

(defun lights-all-off ()
  (mapc #'light-off *lights*))

(defun lights-all-on ()
  (mapc #'light-on *lights*))

(defmethod blink-light ((light cl-hue:light))
  (log:info "Blinking light #~A (~A)." (cl-hue::light-number light) (cl-hue::light-name light))
  (cl-hue:set-light-state-by-number *bridge* (cl-hue::light-number light) :alert "select"))

(defun blink-all-lights ()
  (mapc #'blink-light *lights*))

;;; printer

(defmethod print-object ((light cl-hue:light) stream)
  (print-unreadable-object (light stream :type t :identity t)
    (format stream "#~A (~A)" (cl-hue::light-number light) (cl-hue::light-name light))))
