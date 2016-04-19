(defmodule sort
  (export
   (sort 2)))



(defun sort
  ((() p)
   ())
  (((cons h ()) p)
   (list h))
  (((cons h t) p)
   (findPlace h (sort t p) p)))


(defun findPlace
  ((x () p)
   (list x))
  ((x (cons h ()) p)
   (if (funcall p x h)
     (list x h)
     (list h x)))
  ((x (cons h t) p)
   (if (funcall p x h)
     (cons x (cons h t))
     (cons h (findPlace x t p)))))