(defmodule listLib
    (export
     (findBiggest 1)
     (findSmallest 1)
     (find 2)
     (sum 1)
     (range 1)
     (append 2)
     (separator 2)
     (reverse 1)
     (take 2)
     (dotimes 2)
     (dolist 2)
     (drop 2)))


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


(defun append
  ((lst ())
   lst)
  ((lst (cons h t))
   (append (append lst h) t))
  ((lst val)
   (reverse (cons val (reverse lst)))))

(defun reverse (lst)
   (reverse lst ()))

(defun reverse
  (( () reverse-list)
   reverse-list)
  (( (cons h t) reverse-list)
   (reverse t (cons h reverse-list))))

;;deletes the elements that separates
;;the different parts
(defun separator (str sep)
  (separator () () str sep))

(defun separator
  ((word-list current-word () sep)
   (append word-list current-word))
  
  ((word-list current-word (cons h t) sep) (when (=:= sep h))
   (separator (append word-list current-word) () t sep))
  
  ((word-list current-word (cons h t) sep)
   (separator word-list (append current-word h) t sep)))


(defun take
  ((n ())
   ())
  ((1 (cons h t))
   (list h))
  ((n (cons h t))
   (cons h (take (- n 1) t))))

(defun drop
  ((n ())
   ())
  ((1 (cons h t))
   t)
  ((n (cons h t))
   (drop (- n 1) t)))

  
(defun dotimes 
  ((0 f)
   ())
  ((n f)
   (funcall f n)
   (dotimes (- n 1) f)))

(defun dolist
  (( () f)
   ())
  (( (cons h t) f)
   (cons (funcall f h) (dolist t f))))