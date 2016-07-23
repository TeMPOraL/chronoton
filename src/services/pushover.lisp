(in-package #:chrono/pushover)

(defparameter *api-token* "" "API token for Pushover service to use.")
(defparameter *admin-user-token* "" "Pushover token of the user to send the messages to.")
(defparameter *default-title* "Chronoton")

(defun load-configuration ()
  )

(defun save-configuration ()
  )

(defun send-info (&key message (title *default-title*) (destination *admin-user-token*))
  (log:debug "Sending Pushover info message." destination title message)
  (send-untracked-message *api-token* destination title message cl-pushover:+priority-low+))

(defun send-alert (&key message (title *default-title*) (destination *admin-user-token*))
  (log:debug "Sending Pushover alert message." destination title message)
  (send-untracked-message *api-token* destination title message cl-pushover:+priority-high+))

(defun send-untracked-message (from to title message priority)
  (cl-pushover:send-pushover :destination-key to
                             :token from
                             :message message
                             :title title
                             :priority priority))
