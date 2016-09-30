(in-package #:chronoton/core)

(defmacro defvar-configurable (name default-value docstring)
  `(defvar ,name
     (get-value-from-config (package-name *package*)
                            (symbol-name ',name)
                            :default-value ,default-value)
     ,docstring))

(defmacro defparameter-configurable (name default-value docstring)
  `(defparameter ,name
     (get-value-from-config (package-name *package*)
                            (symbol-name ',name)
                            :default-value ,default-value)
     ,docstring))

(defun get-value-from-config (package-name variable-name &key (default-value nil default-value-supplied-p) (store-default-if-not-found t))
  (log:trace "Getting value ~A::~A (default: ~A, default supplied: ~A, store ~A)"
             package-name
             default-value
             default-value-supplied-p
             store-if-not-found)
  ;; TODO fetch it from database
  )
