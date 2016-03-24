(defmodule third
    ;(export all )
    (export-macro te))

(defmacro te ()
  '(list 1 2 3 4 5))


(defun test ()
  `(+ ,@(te)))
