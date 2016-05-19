(defmodule State
  (export
   (state 1)
   (init-state-handler 0)
   (state-handler 0)
   ))


(defun init-state-handler ()
  (let ((pid (spawn 'State 'state-handler ())))
    (register 'state-handler pid)))


(defun state-handler ()
  (receive
    ((tuple 'create name pid)
     (case (whereis name)
       ('undefined
	(let ((pid (spawn 'State 'state (list 'nil))))
	  (register name pid))
	(! pid 'done))
       (else
	(! pid (tuple 'error 'AlreadyInUse)))))
    ((tuple 'create name init-value pid)
     (case (whereis name)
       ('undefined
	(let ((pid (spawn 'State 'state (list init-value)1)))
	  (register name pid))
	(! pid 'done))
       (else
	(! pid (tuple 'error 'AlreadyInUse)))))))


(defun state(x)
  (receive
    ((tuple 'put f pid)
     (let ((y (funcall f x)))
       (! pid y)
       (state y)))
    ((tuple 'get pid)
     (! pid x)
     (state x))
    ((tuple 'destroy pid)
     (! pid x))
    (other
     (state x))))



