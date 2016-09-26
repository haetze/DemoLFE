(defmodule tree
  (export
   (print 1)
   
   ))


(defun print
  (((tuple 'node x _))
   (io:format "~p~n" (list x)))
  (((tuple 'tree children _))
   (lists:map #'tree:print/1 children)))

;work in progress
(defun insert-under
  (((tuple 'tree children p) x w pivot-calc) (when (=:= w (tuple 'tree children p)))
   (tuple 'tree (sort:qsort (cons x children)
			    p pivot-calc)))
  (((tuple 'tree children p) x w pivot-calc)
  (((tuple 'node e p) x _ pivot-calc)
   (tuple 'tree (sort:qsort (list (tuple 'node e p) x) p pivot-calc) p)))


