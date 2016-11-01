(defmodule sortedList
  (export
   (insert 2)
   (insert 3)))

(defun insert (x ys)
  (insert x ys #'>/2))

(defun insert
  ((x () p)
   (list x))
  ((x (cons y ys) p)
   (if (funcall p x y)
     (cons y (insert x ys p))
     (cons x (cons y ys)))))