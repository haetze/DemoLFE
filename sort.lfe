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

(defun sorter
  ((() p)
   ())
  (((cons h ()) p)
   (list h))
  (((cons h t) p)
   (findPlace-2 h (sorter t p) p)))



(defun findPlace-2
  ((x () p)
   (tuple 'single x))
  
  ((x (tuple 'single h) p)
   (if (funcall p x h)
     (tuple  (tuple 'single x) (tuple 'none) (tuple 'single h))
     (tuple  (tuple 'single h)(tuple 'none) (tuple 'single x))))
  
  ((x (tuple (tuple 'single y) (tuple 'none) (tuple 'single z)) p)
      (if (funcall p x y)
	(tuple (tuple 'single x) (tuple 'single y) (tuple 'single z))
	  (if (funcall p z x)
	    (tuple (tuple 'single y) (tuple 'single z) (tuple 'single x))
	    (tuple (tuple 'single y) (tuple 'single x) (tuple 'single z)))))

  ((x (tuple a (tuple 'single y) b) p)
   (if (funcall p x y)
     (tuple (findPlace-2 x a p) (tuple 'single y) b)
     (tuple a (tuple 'single y) (findPlace-2 x b p)))))



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