
(defun insert
  ((x (tuple 'tree e l p-o p-d))
   (when (=:= (funcall p-d (tuple 'tree e l p-o p-d) x)
	      'dont-insert))
   'ok)
  ((x (tuple 'tree e l p-o p-d))
   (when (=:= (funcall p-d (tuple 'tree e l p-o p-d) x)
	      'insert-here))
   (tuple 'tree e (sort:sort (cons (create x p-o p-d)
				   l) p-o) p-o p-d))
  ((x (tuple 'tree e l p-o p-d))
   (let  ((n (funcall p-d (tuple 'tree e l p-o p-d) x)))
     (tuple 'tree e (listLib:apply-to n l
				      (lambda (y)
					(insert x y)))
	    p-o p-d))))