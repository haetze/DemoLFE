(defmodule universalServer
    (export
     (universalServer 0)
     (start 0)
     (numberServer 1)
     (fibServer 0)
     ;;(addServer 0)
     (factorialServer 0)))

;;joe armstrongs favorite program
;;the universal server
;;with the syntax of the an awesome language

(defun universalServer ()
  (receive
   ((tuple 'become f)
    (funcall f))
   (other
    (universalServer))))

(defun fibServer ()
  (numberServer #'fib:fib/1))

(defun factorialServer ()
  (numberServer #'fib:factorial/1))

;;(defun addServer ()
;;  (numberServer #'add/2))

;;(defun add (a b)
;;  (+ a b))

(defun numberServer (f)
  (receive 
   ((tuple from numbers)
    (! from (apply f numbers))
    (numberServer f))))



(defun start ()
  (let ((pid (spawn 'universalServer 'universalServer ())))
    (! pid (tuple 'become #'fibServer/0))
    (! pid (tuple (self) 5))
    (receive
     (n
      (io:format "~p" (list n))))))

  
