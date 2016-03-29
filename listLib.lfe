(defmodule find
    (export
     (findBiggest 1)
     (findSmallest 1)
     (find 2)
     (sum 1)
     (range 1)
     (eq 2)))


(defun findBiggest
  (( () )
   ())
  (( (cons h t) )
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


(defun sum
  (( () )
   0)
  (( (cons h t) )
   (+ h (sum t)))) 

(defun range (n)
  (if (=< n 0)
      ()
      (range 0 n)))

(defun range (i n)
  (if (== i n)
      (list n)
      (cons i (range (+ i 1) n))))
