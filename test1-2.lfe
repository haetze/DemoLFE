(defmodule test1-2
  (export-macro add))

(defmacro add (x y)
  (+ x y))