(defmodule universalServer
    (export
     (universalServer 0)
     (start 0)
     (fibServer 0)))

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
  (receive
   ((tuple from number)
    (! from (fib:fib number))
    (fibServer))))

(defun start ()
  (let ((pid (spawn 'universalServer 'universalServer ())))
    (! pid (tuple 'become #'fibServer/0))
    (! pid (tuple (self) 5))
    (receive
     (n
      (io:format "~p" (list n))))))

  
