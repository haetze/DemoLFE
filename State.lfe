(defmodule State
  (export
   (destroy 1)
   (create 1)
   (get 1)
   (put 2)
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
	(! pid (tuple 'error 'AlreadyInUse))))
     (state-handler))
    ((tuple 'create name init-value pid)
     (case (whereis name)
       ('undefined
	(let ((pid (spawn 'State 'state (list init-value)1)))
	  (register name pid))
	(! pid 'done))
       (else
	(! pid (tuple 'error 'AlreadyInUse))))
     (state-handler))))


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

(defun destroy (name)
  (! name (tuple 'destroy (self)))
  (receive
    (n
     n)
    (after 1000
      (tuple 'error 'no-receive))))

(defun create (name)
  (! 'state-handler (tuple 'create 'x (self)))
  (receive
    ('done
     'done)
    (after 1000
      (tuple 'error 'no-receive))))


(defun put (name f)
  (! name (tuple 'put f (self)))
  (receive
    (n
     n)
    (after 1000
      (tuple 'error 'no-receive))))

(defun get (name)
  (! name (tuple 'get (self)))
  (receive
    (n
     n)
    (after 1000
      (tuple 'error 'no-receive))))
