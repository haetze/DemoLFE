(defmodule StateTest
  (export
   (state-process-test 0)
   (state-handler 0)))


(defun state-process-test ()
  (let ((pid (spawn 'State 'state (list 12))))
    (! pid (tuple 'get (self)))
    (receive
      (n
       (io:format "~p~n" (list n)))
      (after 1000
	(io:format "nothing received ~n" ())))
    (! pid (tuple 'put (lambda (x) (+ 1 x))))
    (! pid (tuple 'get (self)))
    (receive
      (n
       (io:format "~p~n" (list n)))
      (after 1000
	(io:format "nothing received ~n" ())))))

(defun state-handler ()
  (State:init-state-handler)
  (! 'state-handler (tuple 'create 'x (self)))
  (receive
    ('done
     ())
    ('error
     ()))
  (! 'x (tuple 'get (self)))
  (receive
    (n
     (io:format "~p~n" (list n))))
  (! 'x (tuple 'put (lambda (x) (+ 1))))
  (! 'x (tuple 'get (self)))
  (receive
    (n
     (io:format "~p~n" (list n)))))