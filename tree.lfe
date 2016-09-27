(defmodule tree
  (export
   (print 1)
   (create 3)
   (create 4)
   (sort-kids 1)
   (binary-tree-order 2)
   (binary-tree-deep 2)
   (insert 2)
   (apply-to 3)
   ))


(defun print
  (((tuple 'tree e () p-o p-d))
   (io:format "~p~n" (list e)))
  (((tuple 'tree e l p-o p-d))
   (io:format "~p~n" (list e))
   (lists:map #'print/1 l)
   'ok))

(defun create (x p-o p-d)
  (create x () p-o p-d))

(defun create (x l p-o p-d)
  (tuple 'tree x l p-o p-d))

(defun binary-tree-order
  (((tuple 'tree e l p-o p-d)
    (tuple 'tree f k q-o q-d))
   (< e f)))

(defun binary-tree-deep
  (((tuple 'tree 'nil l p-o p-d) x)
   'replace)
  (((tuple 'tree e l p-o p-d) x) (when (=:= e x))
   'dont-insert)
  (((tuple 'tree e l p-o p-d) x)
   (when (< x e))
   0)
  (((tuple 'tree e l p-o p-d) x)
   (when (> x e))
   1))

(defun apply-to
  ((n () f)
   ())
  ((0 (cons h t) f)
   (cons (funcall f h) t))
  ((n (cons h t) f)
   (cons h (apply-to (- n 1) t f))))

      
  
(defun sort-kids
  (((tuple 'tree e l p-o p-d))
   (tuple 'tree e (sort:sort l p-o) p-o p-d)))


(defun check-list
  ((() 0 p-o p-d)
   (list (tuple 'tree 'nil () p-o p-d)))
  ((l 0 p-o p-d)
   l)
  (((cons h t) n p-o p-d)
   (check-list t (- n 1) p-o p-d))
  ((() n p-o p-d)
   (cons (create 'nil p-o p-d) (check-list () (- n 1) p-o p-d))))





(defun insert
  ((x (tuple 'tree e l p-o p-d))
   (cond ((=:= (funcall p-d (tuple 'tree e l p-o p-d) x) 'dont-insert)
	  'ok)
	 ((=:= (funcall p-d (tuple 'tree e l p-o p-d) x) 'insert-here)
	  (tuple 'tree e (sort:sort (cons (create x p-o p-d)
					  l) p-o) p-o p-d))
	 ((=:= (funcall p-d (tuple 'tree e l p-o p-d) x) 'replace)
	  (tuple 'tree x l p-o p-d))
	 ('true
	  (let  ((n (funcall p-d (tuple 'tree e l p-o p-d) x)))
	    (tuple 'tree e (apply-to n (check-list l n p-o p-d) (lambda (y) (insert x y))) p-o p-d))))))
						   
		   

   
