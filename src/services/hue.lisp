(in-package #:chronoton/service/hue)

(defparameter *bridge-endpoint* "" "Endpoint of the Hue Bridge.")
(defparameter *username* "" "Hue API user to pass in API calls.")

(defparameter *default-transition-time* 4 "Default transition time (in 1/10ths of the second).")

(defvar *bridge* nil "Hue Bridge instance.")
(defvar *lights* nil "Cached list of Hue lights.")

(defvar *heartbeat-canceller* nil "Closure used to cancel heartbeat event.")
(defvar *heartbeat-interval* 2.0 "Hue heartbeat interval in seconds.")
(defvar *heartbeat-changeset-callback* nil "Callback for the heartbeat to report on changed lights.")

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
  (log:debu1 *lights*))



(defun get-light-by-number (light-number)
  "Get Hue light data from lights cache."
  (find-if (lambda (light)
             (= (parse-integer (cl-hue::light-number light)) light-number))
           *lights*))


;;; utility functions / playing around

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



(defun start-heartbeat (&key (interval *heartbeat-interval*) (changeset-cb nil))
  (if (not *heartbeat-canceller*)
      (progn
          (log:info "Starting Hue heartbeat with interval = ~A second(s)." interval)
          (setf *heartbeat-canceller* (as:interval 'heartbeat :time interval))
          (setf *heartbeat-changeset-callback* changeset-cb))
      (log:error "Hue heartbeat is already running.")))

(defun stop-heartbeat ()
  (if *heartbeat-canceller*
      (progn
        (log:info "Stopping Hue heartbeat.")
        (funcall *heartbeat-canceller*)
        (setf *heartbeat-canceller* nil))
      (log:error "Hue heartbeat is not running.")))

(defun reset-heartbeat (&key (interval *heartbeat-interval*) (changeset-cb nil changeset-cb-provided-p))
  (stop-heartbeat)
  (start-heartbeat &key :interval interval (if changeset-cb-provided-p changeset-cb *heartbeat-changeset-callback*)))

(defun heartbeat-running-p ()
  (not (null *heartbeat-canceller*)))

(defun heartbeat ()
  (log:debug "Heartbeat...")
  (let ((last-light-state *lights*))
    (fetch-lights)
    (when *heartbeat-changeset-callback*
      (funcall *heartbeat-changeset-callback* (compute-changeset *lights* last-light-state)))))

(defun compute-changeset (current-state previous-state)
  ;; TODO
  current-state)


;;; printer

(defmethod print-object ((light cl-hue:light) stream)
  (print-unreadable-object (light stream :type t :identity t)
    (format stream "#~A (~A)" (cl-hue::light-number light) (cl-hue::light-name light))))
