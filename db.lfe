(defmodule db
  (export
   (get_all 1)
   (get_id 2)
   (add 3)
   (destroy 1)
   (create-db 1)
   (db-loop 1)))


(defun create-db (name)
  "Creates a Database list with a name"
  (let ((p (spawn 'db 'db-loop (list ()))))
    (register name p)))

(defun db-loop (db)
  (receive
    ;; destroy db
    ((tuple pid (tuple 'destroy))
     (! pid 'ok))
    ;; Get record with id 
    ((tuple pid (tuple 'get id))
     (let ((result (lists:filter (lambda (x) (p id x)) db)))
     (! pid (tuple 'ok result))
     (db:db-loop db)))
    ;; Get complete db
    ((tuple pid (tuple 'get_all))
     (! pid (tuple 'ok db))
     (db:db-loop db))
    ;; Add record to db
    ((tuple pid (tuple 'add id rec))
     (! pid 'ok)
     (db:db-loop (cons (tuple id rec) db)))))

(defun get_all (name)
  (! name (tuple (self) (tuple 'get_all)))
  (receive
    ((tuple 'ok db)
     db)
    (_
     'error)
    (after 1000
      'timeout)))

(defun get_id (name id)
  (! name (tuple (self) (tuple 'get id)))
  (receive
    ((tuple 'ok db)
     db)
    (_
     'error)
    (after 1000
      'timeout)))

(defun add (name id rec)
  (! name (tuple (self) (tuple 'add id rec)))
  (receive
    ('ok
     'ok)
    (_
     'error)
    (after 1000
      'timeout)))

(defun destroy (name)
  (! name (tuple (self) (tuple 'destroy)))
  (receive
    ('ok
     'ok)
    (_
     'error)
    (after 1000
      'timeout)))


(defun p
  ([id (tuple id rec)] 'true)
  ([_ _] 'false))