;;;; chronoton.asd

(asdf:defsystem #:chronoton
  :serial t

  :long-name "Chronoton - backend of a home automation system."
  :author "Jacek Złydach"
  :version (:read-file-from "version.lisp" :at (1 2 2))
  :description "Backend of a home automation system with StarTrek-like interfaces."

  :license "MIT"
  :homepage "https://github.com/TeMPOraL/chronoton"
  :bug-tracker "https://github.com/TeMPOraL/chronoton/issues"
  :source-control (:git "https://github.com/TeMPOraL/chronoton.git")
  :mailto "temporal.pl+chronoton@gmail.com"

  :encoding :utf-8
  
  :depends-on (#:alexandria
               #:log4cl
               #:drakma
               #:local-time)
  
  :components ((:file "packages")
               (:file "version")

               (:module "core"
                        :components ((:file "logger")))

               (:file "main")))
