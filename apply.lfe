(defmodule apply
  (export
   (delta 1)
   (t 1)))


(defun t (f)
  (lambda (x) (+ 1 (funcall (funcall f x) x))))


(defun delta (f)
  (funcall f f))