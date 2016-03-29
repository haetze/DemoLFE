(defmodule find
    (export
     (findBiggest 1)
     (findSmallest 1)
     (find 2)))


(defun findBiggest
  (( () )
   ())
  (((cons h t))
   (findBiggest h t)))

(defun findBiggest
  ((tB ())
   tB)
  ((tB (cons h t))
   (if (> h tB)
       (findBiggest h t)
       (findBiggest tB t))))

(defun findSmallest
  ((())
   ())
  (( (cons h t) )
   (findSmallest h t)))

(defun findSmallest
  ((tB ())
   tB)
  ((tB (cons h t))
   (if (< h tB)
       (findSmallest h t)
       (findSmallest tB t))))


(defun find
  (('small l)
   (findSmallest l))
  (('big l)
   (findBiggest l)))
