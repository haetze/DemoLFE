(defmodule sort
  (export
   (sort 2)
   (sort 1)
   (startSort 1)
   (counter 2)))

(defun sort (l)
  (sort l #'</2))
  ;(! 'counter 'send))

;;sorts with the predicate as the order giving function
;;the predicate HAS to take TWO (2) arguments
(defun sort
  ((() p)
   ())
  (((cons h ()) p)
   (list h))
  (((cons h t) p)
   (findPlace h (sort t p) p)))

(defun startSort (l)
  (register 'counter (spawn 'sort 'counter (list 0 (self))))
  (sort l)
  (receive
   (n
    (io:format "~p~n" (list n)))))

(defun counter (n ppid)
  (receive
   ('addOne
    (counter (+ n 1) ppid))
   ('send
    (! ppid n))))


(defun findPlace
  ((x () p)
   (list x))
  ((x (cons h ()) p)
   ;(! 'counter 'addOne)
   (if (funcall p x h)
     (list x h)
     (list h x)))
  ((x (cons h t) p)
   ;(! 'counter 'addOne)
   (if (funcall p x h)
     (cons x (cons h t))
     (cons h (findPlace x t p)))))
