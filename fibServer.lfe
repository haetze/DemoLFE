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
    ((tuple 'list_update new-list)
     (if (> (length l) (length new-list))
       (server l)
       (server new-list)))
    ((tuple n pid)
     (spawn (lambda () (responder n pid l (self))))
     (server l))))
     
(defun responder (n pid l server)
  (let (((tuple fib fib-list) (funcall (fibServer:create-fib l) n)))
    (! pid fib)
    (! server (tuple 'list_update fib-list))))
  

(defun create-fib (l)
  (let* ((f
	  (lambda (x)
	    (if (< (length l) x)
	      (let* ((first (lists:nth 1 l))
		     (second (lists:nth 2 l)))
		(funcall (create-fib (cons (+ first second) l)) x))
	      (tuple (lists:nth (+ (- (length l) x) 1) l) l)))))
    f))
	     