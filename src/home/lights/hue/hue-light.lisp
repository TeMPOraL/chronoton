(in-package #:chronoton/home/lights)

(defclass hue-light (light)
  ((number :initform (error "Need to provide a valid Hue light number.")
           :initarg :number
           :accessor :number)
   (hue-state :initform nil
              :initarg :hue-state
              :accessor :hue-state)))

;;; FIXME Hue state needs to be refreshed!
;;; Probably should add a callback to the heartbeat!
;;; TODO Also need to figure out how to store hue-light instances so that their
;;; references won't break during lifetime of the application!

(defmethod light-state ((light hue-light))
  (cl-hue::light-on-p (hue-state light)))

(defmethod set-light-state ((light hue-light) on-state)
  ;; TODO
  )

(defmethod light-color-rgb ((light hue-light))
  ;; TODO
)

(defmethod set-light-color-rgb ((light hue-light) r g b)
  ;; TODO
)

(defmethod light-color-hsv ((light hue-light))
  ;; TODO
)

(defmethod set-light-color-hsv ((light hue-light) h s v)
  ;; TODO
)

(defmethod light-color-temperature ((light hue-light))
  (cl-hue::light-ct (hue-state light)))

(defmethod set-light-color-temperature ((light hue-light) ct)
  ;; TODO
)

(defmethod light-brightness ((light hue-light))
  (cl-hue::light-brightness (hue-state light)))

(defmethod set-light-brightness ((light hue-light) brightness)
  ;; TODO
)

(defmethod light-color-mode ((light hue-light))
  (let ((color-mode (cl-hue::light-colormode (hue-state light))))
    ;; TODO
    ))

(defmethod set-light-color-mode ((light hue-light) color-mode)
  ;; TODO
)

(defmethod print-object ((light hue-light) stream)
  (print-unreadable-object (light stream :type t :identity t)
    (format stream "#~A (~A)" (number light) (light-name light))))
