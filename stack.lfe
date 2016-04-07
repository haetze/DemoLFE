(defmodule stack
    (export
     (create-stack 0)
     (stack-handler 1)
     ))


(defun create-stack ()
  (case (whereis 'stack)
    ('undefined
     (spawn 'stack 'stack-handler (list () )))
    (pid
     (! pid 'close)
     (spawn 'stack 'stack-handler (list () )))))

  

(defun stack-handler (stack)
  (if (=:= (self) (whereis 'stack))
      ()
      (register 'stack (self)))
  (receive
   ((tuple 'push l)
    (stack-handler (listLib:append (listLib:reverse l) stack)))
   ((tuple 'funcall f n)
    (if (>= n (lists:flatlength stack))
	(stack-handler stack)
	(let ((new (apply f (listLib:take n stack)))
	      (newStack (listLib:drop n stack)))
	  (io:format "~p~n~p~n" (list new newStack))
	  (stack-handler (listLib:append (list new) newStack)))))
   ('close
    ())
   ('print
    (io:format "~p~n" (list stack))
    (stack-handler stack))
   (other
    (stack-handler stack))))
