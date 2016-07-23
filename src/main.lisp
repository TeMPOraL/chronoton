(in-package #:chronoton)

(defun initialize-system ()
  (configure-logger)
  (log:info "Initializing Chronoton System, version ~A." *version*))

(defun deinitialize-system ()
  (log:info "Chronoton System deinitialized."))

(defun run ()
  "The entry point to the whole system."

  (initialize-system)

  ;; TODO here stuff gets done.

  (deinitialize-system))
