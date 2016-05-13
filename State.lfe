(defmodule State
  (export
   (state 1)
   ))


(defun init-state-handler ()
  (let ((pid (spawn 'state 'handler ())))
    (register 'state-handler pid)))


(defun state-handler ()
  (receive
    ((tuple 'create name)
     ;;create Code
     )
    ((tuple 'create name init-value)
     ;;create Code
     )
    ))


(defun state(x)
  (receive
    ((tuple 'put f)
     (state (funcall f x)))
    ((tuple 'get pid)
     (! pid x)
     (state x))
    (other
     (state x))))



