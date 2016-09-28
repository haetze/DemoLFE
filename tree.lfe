(defmodule tree
  (export
   (print 1)
   (create 4)
   (create 5)
   (sort-kids 1)
   (insert 2)
   (binary-tree-order 2)
   (binary-tree-deep 2)
   ))


(defun print
  (((tuple 'tree e () p-o p-d c))
   (io:format "~p~n" (list e)))
  (((tuple 'tree e l p-o p-d c))
   (io:format "~p~n" (list e))
   (lists:map #'print/1 l)
   'ok))

(defun create (x p-o p-d c)
  (create x () p-o p-d c))

(defun create (x l p-o p-d c)
  (tuple 'tree x l p-o p-d c))

(defun sort-kids
  (((tuple 'tree e l p-o p-d c))
   (tuple 'tree e (sort:sort l p-o) p-o p-d c)))


(defun check-list
  ((() 0 p-o p-d c)
   (list (tuple 'tree 'nil () p-o p-d c)))
  ((l 0 p-o p-d c)
   l)
  (((cons h t) n p-o p-d c)
   (cons h (check-list t (- n 1) p-o p-d c)))
  ((() n p-o p-d c)
   (cons (create 'nil p-o p-d c) (check-list () (- n 1) p-o p-d c))))


(defun insert
  ((x (tuple 'tree e l p-o p-d c))
   (cond ((=:= (funcall p-d (tuple 'tree e l p-o p-d c) x) 'dont-insert)
	  'ok)
	 ((=:= (funcall p-d (tuple 'tree e l p-o p-d c) x) 'insert-here)
	  (tuple 'tree e (sort:sort (cons (create x p-o p-d c)
					  l) p-o) p-o p-d c))
	 ((=:= (funcall p-d (tuple 'tree e l p-o p-d c) x) 'combine)
	  (tuple 'tree (funcall c e x) l p-o p-d c))
	 ((=:= (funcall p-d (tuple 'tree e l p-o p-d c) x) 'replace)
	  (tuple 'tree x l p-o p-d c))
	 ('true
	  (let  ((n (funcall p-d (tuple 'tree e l p-o p-d c) x)))
	    (tuple 'tree e (listLib:apply-to n (check-list l n p-o p-d c) (lambda (y) (insert x y))) p-o p-d c))))))
						   
		   
;;example p-o and p-d for binary trees
;;code above only tested with binary trees
   
(defun binary-tree-order
  (((tuple 'tree e l p-o p-d c)
    (tuple 'tree f k q-o q-d d))
   (< e f)))

(defun binary-tree-deep
  (((tuple 'tree 'nil l p-o p-d c) x)
   'replace)
  (((tuple 'tree e l p-o p-d c) x) (when (=:= e x))
   'dont-insert)
  (((tuple 'tree e l p-o p-d c) x)
   (when (< x e))
   0)
  (((tuple 'tree e l p-o p-d c) x)
   (when (> x e))
   1))


;;(set x (tree:create 50 #'tree:binary-tree-order/2 #'tree:binary-tree-deep/2 'nil))
;;(set y (tree:insert 20 x))
;;(set c (tree:insert 60 y))
;;(set v (tree:insert 30 c))