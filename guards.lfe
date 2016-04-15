(defmodule guards
    (export
     (guard-example 2)
     (fib 1)))



;;guards are used for eq tests instead of
;;using the same variable twice while pattern matching
(defun guard-example
  ((x y) (when (=:= x y))
   (io:format "~p~n" (list x))
   'yes)
  ((x y)
   (io:format "~p~n~p~n" (list x y))
   'no))

;;fib entry
(defun fib (n)
  (fib 0 1 n))

(defun fib
  ((a b n) (when (=:= n 0)) ;;could be written with pattern matching
   a)
  ((a b n)
   (fib b (+ a b) (- n 1))))