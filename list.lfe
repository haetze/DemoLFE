(defmodule list
  (export
   (filter 2)
   (reduce 2)))


(defun filter (p l)
  (list-comp ((<- x l) (funcall p x)) x))


(defun reduce (p l)
  (filter (lambda (x) (not (funcall p x))) l))