(defmodule sort
  (export
   (sort 1)))



(defun sort
  ((())
   ())
  (((cons h ()))
   (list h))
  (((cons h t))
   (findPlace h (sort t))))


(defun findPlace
  ((x ())
   (list x))
  ((x (cons h ()))
   (if (< x h)
     (list x h)
     (list h x)))
  ((x (cons h t))
   (if (< x h)
     (cons x (cons h t))
     (cons h (findPlace x t)))))