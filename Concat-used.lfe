(defmodule Concat-used
  (export
   (example 1)))


(defun example (x)
  (Concat:concat (lambda (x)
		   (+ x 1))
		 (lambda (x)
		   (+ x 2))
		 (lambda (x)
		   (* x 2))
		 (list x)))