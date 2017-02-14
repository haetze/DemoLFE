(defmodule InfList
  (export
   (gen-fib 2)
   (get-nth-fib 1)
   (get-nth-fib 2)
   (gen-root-function 2)
   (gen 2)
   (fib-create 1)
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

(defun gen-root-function (q-0 create-function)
  (lambda () (gen q-0 create-function)))

(defun gen (q-0 create-function)
  (let (((tuple fst q-1) (funcall create-function q-0)))
    (tuple fst (lambda () (gen q-1 create-function)))))

(defun fib-create
  ((()) (tuple 0
	       (list 0)))
  (((list 0)) (tuple 1
		     (list 1 0)))
  (((cons b (cons a t)))
   (let ((ab (+ b a)))
     (tuple ab
	    (cons ab (cons b (cons a t)))))))