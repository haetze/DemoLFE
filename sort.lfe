(defmodule sort
  (export
   (sort 2)
   (sort 1)))

(defun sort (l)
  (sort l #'</2))

;;sorts with the predicate as the order giving function
;;the predicate HAS to take TWO (2) arguments
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