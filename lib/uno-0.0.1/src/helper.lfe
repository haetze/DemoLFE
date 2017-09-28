(defmodule helper
  (export
   (split 2)
   (spawn_map_void 2)
   (shuffel 2)))




(defun split (str sep)
  (case (string:split str sep)
    ((list s)
     (list s))
    ((list s1 s2 )
     (cons s1 (split s2 sep)))))


(defun spawn_map_void
  ([f ()]
   ())
  ([f (cons h t)]
   (spawn (lambda () (funcall f h)))
   (spawn_map_void f t)))




(defun shuffel
  ([() st]
   st)
  ([s st]
   (let* ((ran (random:uniform (length s)))
	  (ran_th (lists:nth ran s))
	  (rest (lists:delete ran_th s)))
     (shuffel rest (cons ran_th st)))))
		  