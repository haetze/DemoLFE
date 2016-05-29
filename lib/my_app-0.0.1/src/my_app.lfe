(defmodule my_app
  (export
   (echo 0)
   (start 0)))

(defun start ()
  (let  ((pid (spawn 'my_app 'echo ())))
	 (register 'echo pid)
	 (tuple 'ok pid)))

(defun echo ()
  (receive
    ((tuple data pid)
     (! pid data)
     (echo))
    (_other
     (echo))))