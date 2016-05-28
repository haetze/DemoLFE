(defmodule sort
  (export
   (sort 2)
   (sort 1)
   (sorter 1)
   (sorter 2)
   (startSort 1)
   (qsort 1)
   (qsort 2)
   (qsort 3)
   (avg 1)
   (qsort-parallel 5)
   (qsort-parallel 3)
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
  ((l) (qsort l #'=</2 #'avg/1)))


(defun qsort
  ((() _) ())
  (((cons h ()) _) (cons h ()))
  ((l f) (qsort l f #'avg/1)))

(defun qsort
  ((() _ _) ())
  (((cons h ()) _ _) (cons h ()))
  ((l f pivot-calc)
   (let ((p (funcall pivot-calc l)))
     (listLib:append (qsort (listLib:reduce (lambda (x) (funcall f x p)) l) f pivot-calc)
		     (qsort (listLib:filter (lambda (x) (funcall f x p)) l) f
			    pivot-calc)))))

;;parallel quick-sort algorythm
;;spawns a new prozess for each step
(defun qsort-parallel
  ((() _ _ parent-pid kind)
   (! parent-pid (tuple kind ())))
  (((cons h ()) _ _ parent-pid kind)
   (! parent-pid (tuple (cons h ()) kind)))
  ((l f pivot-calc parent-pid kind)
    (let* ((p (funcall pivot-calc l))
	   (reduce (listLib:reduce (lambda (x) (funcall f x p)) l))
	   (filter (listLib:filter (lambda (x) (funcall f x p)) l))
	   (pid-reduce (spawn 'sort 'qsort-parallel (list reduce f pivot-calc (self) 'reduce)))
	   (pid-filter (spawn 'sort 'qsort-parallel (list filter f pivot-calc (self) 'filter))))
      (receive
	((tuple list-a kind-a)
	 (receive
	   ((tuple list-b kind-b)
	    (if (=:= 'reduce kind-a)
	      (! parent-pid (tuple (listLib:append list-a list-b) kind))
	      (! parent-pid (tuple (listLib:append list-b list-a) kind))))
	   (after 10000
	     (! parent-pid (tuple () kind)))))
	(after 10000
	  (! parent-pid (tuple () kind)))))))

;;helper function that handles the receive at the top level
(defun qsort-parallel (l f pivot-calc)
  (let ((pid (spawn 'sort 'qsort-parallel
		    (list l f pivot-calc (self) 'reduce))))
    (receive
      ((tuple l _)
       l))))
	 
    


(defun avg
  ((()) 0)
  (((cons h ())) h)
  (((cons h t)) (/ (+ h (avg t)) 2)))