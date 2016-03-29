(defmodule find
    (export
     (findBiggest 1)
     (findSmallest 1)
     (find 2)))


(defun findBiggest
  ((())
   ())
  ((l)
   (findBiggest (hd l) (tl l))))

(defun findBiggest
  ((tB ())
   tB)
  ((tB tail)
   (if (> (hd tail) tB)
       (findBiggest (hd tail) (tl tail))
       (findBiggest tB (tl tail)))))

(defun findSmallest
  ((())
   ())
  ((l)
   (findSmallest (hd l) (tl l))))

(defun findSmallest
  ((tB ())
   tB)
  ((tB tail)
   (if (< (hd tail) tB)
       (findSmallest (hd tail) (tl tail))
       (findSmallest tB (tl tail)))))


(defun find
  (('small l)
   (findSmallest l))
  (('big l)
   (findBiggest l)))
