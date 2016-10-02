(in-package #:chronoton/home/lights)

(defclass light ()
  ((name :initform "Unnamed Light"
         :initarg :name
         :accessor name)
   (lockedp :initform nil
            :initarg :lockedp
            :accessor :lockedp)
   (control-mode :initform :default
                 :initarg :control-mode
                 :accessor :control-mode)))


;;; TODO Figure out a good transition time API.
;;; Maybe a special variable and let clauses for calls?

(defgeneric light-control-mode (light)
  (:documentation "Get the `LIGHT' control mode.
Modes are:
:DEFAULT - user-controlled; can be auto-restored to default settings.
:DIRECT - user-controlled by incoming data stream; no auto-restore to default settings.
:DYNAMIC - algorithmically controlled; no auto-restore to default settings."))

(defgeneric set-light-control-mode (light control-mode)
  (:documentation "Set the `LIGHT' control mode to `CONTROL-MODE'.
Modes are:
:DEFAULT - user-controlled; can be auto-restored to default settings.
:DIRECT - user-controlled by incoming data stream; no auto-restore to default settings.
:DYNAMIC - algorithmically controlled; no auto-restore to default settings."))

(defgeneric light-locked-p (light)
  (:documentation "Is the `LIGHT' locked or not?"))

(defgeneric set-light-lock (light lockedp)
  (:documentation "Set the `LIGHT' lock to `LOCKEDP'."))

(defgeneric light-state (light)
  (:documentation "Is the `LIGHT' on (T) or off (NIL)?"))

(defgeneric set-light-state (light on-state)
  (:documentation "Set the `LIGHT' state to on (T) or OFF (NIL)."))

(defgeneric light-color-rgb (light)
  (:documentation "Get the `LIGHT' color as (VALUES R G B)."))

(defgeneric set-light-color-rgb (light r g b)
  (:documentation "Set the `LIGHT' color based on `R', `G' and `B' components.
This automatically switches the color mode to `:COLOR'."))

(defgeneric light-color-hsv (light)
  (:documentation "Get the `LIGHT' color as (VALUES H S V)."))

(defgeneric set-light-color-hsv (light h s v)
  (:documentation "Set the `LIGHT' color based on `H', `S' and `V' components.
This automatically switches the color mode to `:COLOR'."))

(defgeneric light-color-temperature (light)
  (:documentation "Get the `LIGHT' color temperature in mireds."))

(defgeneric set-light-color-temperature (light ct)
  (:documentation "Set the `LIGHT' color temperature to `CT' mireds.
This automatically switches the color mode to `:TEMPERATURE'."))

(defgeneric light-brightness (light)
  (:documentation "Get the `LIGHT' brightness, in range 0.0 to 1.0."))

(defgeneric set-light-brightness (light brightness)
  (:documentation "Set the `LIGHT' `BRIGHTNESS'."))

(defgeneric light-color-mode (light)
  (:documentation "Get the `LIGHT' color mode.
Modes are:
- :COLOR - direct color display.
- :TEMPERATURE - color temperature mode."))

(defgeneric set-light-color-mode (light color-mode)
  (:documentation "Set the `LIGHT' color mode to `COLOR-MODE'.
Allowed values are:
- :COLOR - direct color display.
- :TEMPERATURE - color temperature mode."))

(defgeneric light-name (light)
  (:documentation "Get the name of the `LIGHT'."))


;;; default implementation

(defmethod light-control-mode ((light light))
  (control-mode light))

(defmethod set-light-control-mode ((light light) control-mode)
  (setf (control-mode light) control-mode))

(defmethod light-locked-p ((light light))
  (lockedp light))

(defmethod set-light-lock ((light light) lockedp)
  (setf (lockedp light) light))

(defmethod light-name ((light light))
  (name light))



(defmethod print-object ((light light) stream)
  (print-unreadable-object (light stream :type t :identity t)
    (format stream "~A" (light-name light))))
