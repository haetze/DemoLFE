(defmodule guards
    (export
     (guard-example 2)))



;;guards are used for eq tests instead of
;;using the same variable twice while pattern matching
(defun guard-example
  ((x y) (when (=:= x y))
   (io:format "~p~n" (list x))
   'yes)
  ((x y)
   (io:format "~p~n~p~n" (list x y))
   'no))
