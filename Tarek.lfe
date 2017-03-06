(defmodule Tarek
  (export
   (f 1)))



(defun f (l)
  (lists:foldl
   (lambda (x xs) (lists:append xs (list x x)))
   ()
   l))