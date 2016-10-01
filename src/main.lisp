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
  (cs/hue:initialize)
  (cs/pushover:initialize))

(defun deinit-services ()
  (cs/pushover:deinitialize)
  (cs/hue:deinitialize))

(defun setup-signal-handlers ()
  (as:signal-handler as:+sigint+
                     (lambda (signal)
                       (declare (ignore signal))
                       (as:clear-signal-handlers)
                       (log:info "Caught SIGINT.")
                       ;; FIXME temporary
                       (cs/hue:stop-heartbeat))
                     :event-cb (lambda (error)
                                 (log:error "Error processing SIGINT." error))))

(defun run ()
  "The entry point to the whole system."

  (initialize-system)

  (as:with-event-loop ()
    (setup-signal-handlers)
    
    ;; TODO

    ;; FIXME temporary
    (cs/hue:start-heartbeat))

  ;; TODO here stuff gets done.

  (deinitialize-system))
