(defmodule InfList
  (export
   (gen-fib 2)
   (get-nth-element 1)
   (get-nth-element 2)
   (gen-root-function 2)
   (gen 2)
   (fib-create 1)
   (fib-create-opt 1)
   (nth-fib 1)))

(defun gen-fib (x y)
  (lambda ()
    (tuple x
	   (gen-fib y (+ x y)))))


(defun get-nth-element (n)
  (get-nth-element n (gen-fib 0 1)))

(defun get-nth-element
  ((0 f)
   (let (((tuple e _) (funcall f)))
     e))
  ((n f)
   (let (((tuple _ new-f) (funcall f)))
     (get-nth-element (- n 1) new-f))))

;;Comparison function
;;Calc the fib num the usual way
(defun nth-fib
  ((0) 0)
  ((1) 1)
  ((n) (+ (nth-fib (- n 1))
	  (nth-fib (- n 2)))))

;;Helper function that creates a "step function"
;;without changing/applying the first step
(defun gen-root-function (q-0 create-function)
  (lambda () (gen q-0 create-function)))

;;Basically a step function
;; where create function is returning a Pair beta(q) and the "step function"
;;abstracting from a delta(q) function.
;;In this sense it's only abstracting from an Automat.
(defun gen (q-0 create-function)
  (let (((tuple fst q-1) (funcall create-function q-0)))
    (tuple fst (lambda () (gen q-1 create-function)))))

;;O(n) mem use
;;as the elements are taken from the list
;; the state grows linearly 
(defun fib-create
  ((()) (tuple 0
	       (list 0)))
  (((list 0)) (tuple 1
		     (list 1 0)))
  (((cons b (cons a t)))
   (let ((ab (+ b a)))
     (tuple ab
	    (cons ab (cons b (cons a t)))))))

;;O(1) mem use
;;as elements are taken from the list, the state is not increased
;;as soon as the tuple is created 
(defun fib-create-opt
  ((()) (tuple 0 0))
  ((0) (tuple 1 (tuple 0 1)))
  (((tuple a b))
   (let ((ab (+ a b)))
     (tuple ab (tuple b ab)))))