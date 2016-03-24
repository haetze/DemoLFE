(defmodule third
    (export all ))

(defmacro te ()
  `(list 1 2 3 4 5))


(defun test ()
  `(+ ,@(te)))
