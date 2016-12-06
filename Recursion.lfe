(defmodule Recursion
  (export
   (recursion 0)))


(defun recursion ()
  (recursion 0))

(defun recursion (n)
  ;(if (=:= (rem n 10) 0)
  ;(Color:print-in-color (io_lib:format "~p~n" (list n)) (tuple 'red 'blue)))
  (recursion (+ n 1)))