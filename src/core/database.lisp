(in-package #:chronoton/core)

(defvar *core-database-connection* nil)
(defparameter *core-db-file* "core.db" "Name of the SQLite database used by the system.")

(defparameter *core-db-schema*
  '("CREATE TABLE IF NOT EXISTS configuration (
    package_name TEXT NOT NULL,
    variable_name TEXT NOT NULL,
    value TEXT,
    created_at TEXT,
    updated_at TEXT,
    PRIMARY KEY (package_name, variable_name))"))

(defun database/connect (&optional (db-file *core-db-file*))
  "Connect to the core database."
  (unless *core-database-connection*
    (log:info "Connecting to SQLite database ~A." db-file)
    (setf *core-database-connection* (dbi:connect :sqlite3
                                                  :database-name db-file)))
  *core-database-connection*)

(defun database/disconnect ()
  (when *core-database-connection*
    (prog1
        (dbi:disconnect *core-database-connection*)
      (setf *core-database-connection* nil)
      (log:info "Core database disconnected."))))

;;; TODO maybe set up condition handler for lost database connection with a restart of rebooting the connection.
(defun db/do-sql (query &rest params)
  (let* ((prepared-query (dbi:prepare *core-database-connection* query))
         (results (apply #'dbi:execute prepared-query params)))
    results))

(defun db/do-sql-fetch-all (query &rest params)
  (dbi:fetch-all (apply #'db/do-sql query params)))

(defun db/fetch-full-table-raw (table)
  (db/do-sql-fetch-all (concatenate 'string "SELECT * FROM " table ";"))) ;



(defun ensure-database-structure ()
  "Ensure all tables in the database exist."
  ;; FIXME Make it do it from file instead of list of strings; hint - split by #\;.
  (handler-case (mapc (curry #'dbi:do-sql *core-database-connection*)
                      *core-db-schema*)
    (error (e)
      (log:error "Error executing schema." e))))
