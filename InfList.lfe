(defmodule InfList
  (export
   (gen-fib 2)
   (get-nth-fib 1)
   (nth-fib 1)))

(defun gen-fib (x y)
  (lambda ()
    (tuple x
	   (gen-fib y (+ x y)))))


(defun get-nth-fib (n)
  (get-nth-fib n (gen-fib 0 1)))

(defun get-nth-fib
  ((0 f)
   (let (((tuple fib _) (funcall f)))
     fib))
  ((n f)
   (let (((tuple _ new-f) (funcall f)))
     (get-nth-fib (- n 1) new-f))))


(defun nth-fib
  ((0) 0)
  ((1) 1)
  ((n) (+ (nth-fib (- n 1))
	  (nth-fib (- n 2)))))