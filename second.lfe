
(defmodule second
 (export
  (createDB 0)
  (db 0)
  (close 1)
  (insert 2)
  (lookup 2)))


;example module for using the dets tables


(defun createDB ()
 (spawn `second `db ()))

(defun insert (pid data)
  (! pid (tuple 'insert (self) data))
  (receive
   (other
    other)
   (after 1000 'noResult)
   ))

(defun close (pid)
  (! pid 'close))

(defun lookup (pid data)
  (! pid (tuple 'lookup (self) data))
  (receive
   (other
    other)
   (after 1000 'noResult)))



(defun db ()
  (let (((tuple 'ok ref) (dets:open_file `file (list (tuple 'file "./db")
						     (tuple 'type 'bag)))))
    (receive
     ((tuple `insert pid data)
      (! pid (list (dets:insert ref data)))
      (dets:close ref)
      (db))
     ((tuple 'lookup pid key)
      (! pid (list (dets:lookup ref key)))
      (dets:close ref)
      (db))
     ('close
      (dets:close ref))
     (other
      (dets:close ref)
      (db)))))
