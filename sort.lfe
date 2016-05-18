(defmodule sort
  (export
   (sort 2)
   (sort 1)
   (sorter 1)
   (sorter 2)
   (startSort 1)
   (qsort 1)
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

(defun sorter (l)
  (sorter l #'</2))

(defun sorter
  ((() p)
   (tuple 'none))
  (((cons h ()) p)
   (tuple 'single  h))
  (((cons h t) p)
   (findPlace-2 h (sorter t p) p)))



(defun findPlace-2
  ((x (tuple 'none) p)
   (tuple 'single x))
  
  ((x (tuple 'single h) p)
   ;(! 'counter 'addOne)
   (if (funcall p x h)
     (tuple  (tuple 'single x) (tuple 'none) (tuple 'single h))
     (tuple  (tuple 'single h)(tuple 'none) (tuple 'single x))))
  
  ((x (tuple (tuple 'single y) (tuple 'none) (tuple 'single z)) p)
      ;(! 'counter 'addOne)
      (if (funcall p x y)
	(tuple (tuple 'single x) (tuple 'single y) (tuple 'single z))
	(progn
	  ;(! 'counter 'addOne)
	  (if (funcall p z x)
	    (tuple (tuple 'single y) (tuple 'single z) (tuple 'single x))
	    (tuple (tuple 'single y) (tuple 'single x) (tuple 'single z))))))

  ((x (tuple a (tuple 'single y) b) p)
   ;(! 'counter 'addOne)
   (if (funcall p x y)
     (tuple (findPlace-2 x a p) (tuple 'single y) b)
     (tuple a (tuple 'single y) (findPlace-2 x b p)))))

(defun startSort (l)
  (register 'counter (spawn 'sort 'counter (list 0 (self))))
  (sort l #'</2)
  (! 'counter 'send)
  (receive
   (n
    (io:format "~p~n" (list n))))
  (register 'counter (spawn 'sort 'counter (list 0 (self))))
  (sorter l #'</2)
  (! 'counter 'send)
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


(defun qsort
  ((()) ())
  (((cons h ())) (cons h ()))
  ((l) (let ((p (avg l)))
	 (listLib:append (qsort (listLib:reduce (lambda (x) (=< x p)) l))
			 (qsort (listLib:filter (lambda (x) (=< x p)) l))))))


(defun avg
  ((()) 0)
  (((cons h ())) h)
  (((cons h t)) (/ (+ h (avg t)) 2)))