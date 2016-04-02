(defmodule fib
    (export
     (fib 1)
     (factorial 1)
     (con-fib 2)
     (start 1)))


(defun fib
  ((0 a b)
   a)
  ((n a b)
   (fib (- n 1) b (+ a b))))

(defun fib (n)
  (fib n 0 1))

(defun factorial
  ((0)
   1)
  ((n)
   (* n (factorial (- n 1)))))

(defun con-fib
  ((0 p)
   (! p 0))
  ((1 p)
   (! p 1))
  ((n p)
   (let ((pid1 (spawn_link 'fib 'con-fib (list (- n 1) (self))))
	 (pid2 (spawn_link 'fib 'con-fib (list (- n 2) (self)))))
     (receive
      (n
       (receive
	(m
	 (! p (+ n m)))))))))


(defun start (n)
  (spawn_link 'fib 'con-fib (list n (self)))
  (process_flag 'trap_exit 'true)
  (receive
   ((tuple 'EXIT pid2 reason)
    (io:format "The calculation failed because ~p"
	       (list reason)))
   (m
    (io:format "~p~n" (list m)))))
