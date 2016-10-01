(in-package #:chronoton)

(defun initialize-system ()
  (init-core)
  (init-services)
  (log:info "Chronoton System up and running!"))

(defun deinitialize-system ()
  (log:info "Deinitializing Chronoton System.")

  (deinit-services)
  (deinit-core))

(defun init-core ()
  (chrono/core:configure-logger)
  (log:info "Initializing Chronoton System, version ~A." *version*)
  (chrono/core:database/connect))

(defun deinit-core ()
  (chrono/core:database/disconnect)
  (log:info "Chronoton System deinitialized.")
  (log:info "Goodbye."))

(defun init-services ()
  (chrono/hue:initialize)
  (chrono/pushover:initialize))

(defun deinit-services ()
  (chrono/pushover:deinitialize)
  (chrono/hue:deinitialize))

(defun run ()
  "The entry point to the whole system."

  (initialize-system)

  (as:with-event-loop ()
    ;; TODO
    )

  ;; TODO here stuff gets done.

  (deinitialize-system))
