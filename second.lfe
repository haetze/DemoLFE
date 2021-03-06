
(defmodule second
 (export
  (createDB 1) ;;personally choosen name
  (createDB 0) ;; default name db
  (db 1)
  (close 1)
  (insert 2)
  (lookup 2)))


;example module for using the dets tables


(defun createDB ()
 (spawn `second `db (list "./db")))

(defun createDB (name)
 (spawn `second `db (list name)))


(defun insert (pid data)
  (! pid (tuple 'insert (self) data))
  (receive
   (other
    other)
   (after 1000 'noResult)))

(defun close (pid)
  (! pid 'close))

(defun lookup (pid data)
  (! pid (tuple 'lookup (self) data))
  (receive
   (other
    other)
   (after 1000 'noResult)))



(defun db (name)
  (let* ((qq (dets:open_file (list_to_atom name) (list (tuple 'file name)
						       (tuple 'type 'set))))
	 ((tuple 'ok ref) qq))
    (receive
     ((tuple `insert pid data)
      (! pid (dets:insert ref data))
      (dets:close ref))
     ((tuple 'lookup pid key)
      (case (dets:lookup ref key) ;; since the module inits all tables to sets
	(()                       ;; is the result either an empty list or
	 (! pid ()))              ;; or a singloten
	(other
	 (! pid (hd other))))
      (dets:close ref))
     ('close
      (dets:close ref))
     (other
      (dets:close ref))))
  (db name))


      
