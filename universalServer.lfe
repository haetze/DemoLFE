(defmodule universalServer
    (export
     (universalServer 0)
     (start 0)
     (applyServer 1)
     (fibServer 0)
     (echoServer 0)
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
  (applyServer #'fib:fib/1))

(defun factorialServer ()
  (applyServer #'fib:factorial/1))

(defun echoServer ()
  (applyServer (lambda (n) n)))

;;adds abstraction to the function apply server
;;creates a server expecting messages of the form
;;(tuple sender_pid list_of_args)
;;(sends the resulting value to the sender_pid)
(defun applyServer (f) 
  (receive 
   ((tuple from numbers)
    (! from (apply f numbers))
    (applyServer f))))



(defun start ()
  (let ((pid (spawn 'universalServer 'universalServer ())))
    (! pid (tuple 'become #'fibServer/0))
    (! pid (tuple (self) (list 5))) ;; the numbers send have to be in a list
    (receive                        ;; but the number of arguments can vary 
     (n
      (io:format "~p" (list n))))))

  
