(in-package #:chronoton)

(defun initialize-system ()
  (chrono/core:configure-logger)
  (log:info "Initializing Chronoton System, version ~A." *version*)
  
  (chrono/hue:initialize)
  (chrono/pushover:initialize))

(defun deinitialize-system ()
  (log:info "Deinitializing Chronoton System.")

  (chrono/pushover:deinitialize)
  (chrono/hue:deinitialize)
  
  (log:info "Chronoton System deinitialized.")
  (log:info "Goodbye."))

(defun run ()
  "The entry point to the whole system."

  (initialize-system)

  (as:with-event-loop ()
    ;; TODO
    )

  ;; TODO here stuff gets done.

  (deinitialize-system))
