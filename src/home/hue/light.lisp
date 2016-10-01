(in-package #:chronoton/home)

(defclass light ()
  ((id :accessor :id)
   (lockedp :initform nil
            :accessor :lockedp)))

(defmethod switch-light ((light light) mode)
  "Turn the `LIGHT' :ON or :OFF, depending on `MODE'."
  ;; TODO
  )

(defmethod set-light-lock ((light light) lock)
  "Set the `LOCK' state of `LIGHT'.
T means no automatic changes should be performed (locked).
NIL means locking is allowed."
  ;; TODO
  )

;;; TODO print-object


;;; TODO ??? how to make the API?
;;; Goals:
;;; - pack as much into one request as possible
;;; - do not pass things that don't change / you don't need to pass

(defmethod get-light-brightness ()
  )

(defmethod set-light-color ((light light) color)
  )

(defmethod set-light-ct ((light light) color-temperature)
  )

(defmethod set-light-ct-xxx ((light light) that-other-magic-unit-for-ct)
  )

(defmethod flash-light ((light light)))
