(defmodule listLib
    (export
     (findBiggest 1)
     (findSmallest 1)
     (find 2)
     (sum 1)
     (range 1)
     (append 2)
     (reverse 1)))


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


(defun append (lst val)
  (reverse (cons val (reverse lst))))

(defun reverse (lst)
   (reverse lst ()))

(defun reverse
  (( () reverse-list)
   reverse-list)
  (( (cons h t) reverse-list)
   (reverse t (cons h reverse-list))))
