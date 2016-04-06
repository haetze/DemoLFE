(defmodule macros
    (export
     (test 1)))


(defmacro example (n)
  `(io:format "~p~n" (list (+ ,n 1))))


(defun test (n)
  (example n))
