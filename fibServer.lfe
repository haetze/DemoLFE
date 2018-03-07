(defmodule fibServer
  (export
   (create-fib 1)
   (start 0)))


(defun initial-list ()
  (list 1 1))

(defun start ()
  (let ((pid (spawn (lambda () (universal-server)))))
    (! pid (lambda () (server (initial-list))))
    pid))


(defun universal-server ()
  (receive
    (f
     (funcall f))))


(defun server (l)
  (receive
    ((tuple n pid)
     (let (((tuple fib fib-list) (funcall (create-fib l) n)))
       (! pid fib)
       (server fib-list)))))


(defun create-fib (l)
  (let* ((f
	  (lambda (x)
	    (if (< (length l) x)
	      (let* ((last-element (lists:last l))
		     (second-to-last (lists:last (lists:droplast l))))
		(funcall (create-fib (lists:append l (list (+ last-element second-to-last)))) x))
	      (tuple (lists:nth x l) l)))))
    f))
	     