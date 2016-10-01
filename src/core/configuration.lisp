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

(defmacro configure-variables (&rest vars)
  "Use this to set values of one or more `VARS' to what is stored in config.
If a variable is not found in the configuration, it will be set to its current Lisp value and stored in config."
  `(progn
     ,@(mapcar (lambda (var)
                 `(get-value-from-config (package-name (symbol-package ',var))
                                         (symbol-name ',var)
                                         :default-value ,var
                                         :store-default-if-not-found t))
               vars)))

(defun get-value-from-config (package-name variable-name &key (default-value nil default-value-supplied-p) (store-default-if-not-found t))
  (log:trace "Getting value ~A::~A (default: ~A, default supplied: ~A, store ~A)."
             package-name
             default-value
             default-value-supplied-p
             store-if-not-found)
  ;; TODO fetch it from database
  )

(defun set-value-in-config (package-name variable-name value)
  (log:trace "Setting value ~A::~A to ~A." package-name variable-name value)
  ;; TODO stroe it in the database
  )
