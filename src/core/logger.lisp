(in-package #:chronoton/core)

(define-constant +default-log-destination+ "system.log" :documentation "Default name / destination of the main log file." :test #'string=)
(defparameter *logging-condition* nil)

(defun configure-logger ()
  "Sets up log4cl for the system."
  (log:config :daily +default-log-destination+
              :nopretty
              :immediate-flush))

(defun log-condition (condition)
  (unless *logging-condition*
    (let ((*logging-condition* t))
      (typecase condition
        (warning (log:warn "Lisp warning: ~A." condition))
        (t (progn (log:fatal "Lisp condition: ~A" condition)
                  (log:fatal "~A" (with-output-to-string (s)
                                    (uiop/image:print-condition-backtrace condition :stream s)))))))))

(defun call-with-logging-conditions (func)
  (handler-bind ((t #'log-condition))
    (funcall func)))

(defmacro with-logging-conditions (&body forms)
  "Set up a passthrough condition handler that will log all signalled conditions."
  `(call-with-logging-conditions (lambda () ,@forms)))
