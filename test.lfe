(defmodule test
   (export 
    (test 2)
    (test2 1)
    (test3 0)
    (test3 1)
    (test3 2)
    (spawner 1)
    (with-pattern 2)))

;;just a small function
(defun test (pid d)
  (! pid d))

;;shows pattern matching in a let
;;statement
(defun test2 (in)
  (let (((tuple a b c) in))
   (io:format "~p ~p ~p ~n" (list a b c))))

;;same function name with a different number of inputs
(defun test3 ()
   (io:format "0 inputs~n" ()))

(defun test3
 (((tuple a b c))
  (io:format "~p ~n" (list b))))

(defun test3 (a b)
  (io:format "~p ~p ~n" (list a b)))

;;shows the spawn function to create a new process
(defun spawner (in)
  (spawn 'test 'test (list (self) in ))
  (receive 
    (1 
      (io:format "One"))
    (d
      (io:format "some thing else ~p" (list d) ))))


;;patterns in function inputs 
(defun with-pattern
  ((`ok data)
    (io:format "OK: ~p " (list data))
     data)
  ((`warn data)
    (io:format "Warning: ~p" (list data))
    data)
  (( 'crit data)
    (io:format "Critical: ~p" (list data))
    data))

