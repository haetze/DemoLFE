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

;;example server
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
  (let ((pid (spawn_link 'universalServer 'universalServer ())))
    (process_flag 'trap_exit 'true) ;;added linking and exit trapping
    ;;(! pid (tuple 'become #'applyServer/1))
    (! pid (tuple 'become #'fibServer/0)) ;;in case the process dies
    ;;the process gets notified and doesn't
    ;;stay in the receive statement
    (! pid (tuple (self) (list 5))) ;; the numbers send have to be in a list
    (receive                        ;; but the number of arguments can vary
     ((tuple 'EXIT pid2 reason)
      (io:format "process ~p just died" (list pid)))
     (n
      (io:format "~p~n" (list n))
      n))))

  
