(defmodule MergeSort
  (export
   (mergeSort 2)
   (mergeSort 1)))

(defun mergeSort (l)
  (spawn 'MergeSort 'mergeSort (list l (self)))
  (receive
    (n
     n)))


(defun mergeSort
  ((() p) (! p ()))
  (((cons h ()) p) (! p (cons h ())))
  ((l p)
   (let* (((tuple f s) (lists:split (trunc (/ (length l) 2)) l))
	  (pid1 (spawn 'MergeSort 'mergeSort (list f (self))))
	  (pid2 (spawn 'MergeSort 'mergeSort (list s (self)))))
     (receive
       (l1
	(receive
	  (l2
	   (! p (lists:merge l1 l2)))))))))

