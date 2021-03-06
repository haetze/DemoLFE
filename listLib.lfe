(defmodule listLib
  (export
   (filter 2)
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
   (reduce 2)
   (snoc 2)
   (lines 2)
   (apply-to 3)
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

(defun reverse 
  ((())
   ())
  (((cons h t))
   (snoc (reverse t) h)))

(defun snoc
  ((() x)
   (list x))
  (((cons h ()) x)
   (cons h (cons x ())))
  (((cons h t) x)
   (cons h (snoc t x))))

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


(defun filter
  ((_ ())
   ())
  ((f (cons h ()))
   (if (funcall f h)
     ()
     (cons h ())))
  ((f (cons h t))
   (if (funcall f h)
     (filter f t)
     (cons h (filter f t)))))

(defun reduce (f l)
  (filter (lambda (x) (not (funcall f x))) l))


(defun lines (str)
  (lines () str))

(defun lines (xs str)
  (let (((tuple x y) (lists:splitwith
		      (lambda (x) (/= x 10)) str)))
    (if (/= (length y) 0)
      (lines (snoc xs x) (tl y))
      (snoc xs x))))

(defun apply-to
  ((n () f)
   ())
  ((0 (cons h t) f)
   (cons (funcall f h) t))
  ((n (cons h t) f)
   (cons h (apply-to (- n 1) t f))))