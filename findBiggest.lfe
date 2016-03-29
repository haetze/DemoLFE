(defmodule find
    (export
     (findBiggest 1)))


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
