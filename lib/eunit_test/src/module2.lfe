(defmodule module2
  (export
   (reverse 1)))



(defun reverse
  ((()) ())
  (((cons h t))
   (++ (reverse t) (list h))))