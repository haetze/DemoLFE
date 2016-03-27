(defmodule fib
    (export
     (fib 1)
     (factorial 1)))


(defun fib
  ((0 a b)
   a)
  ((n a b)
   (fib (- n 1) b (+ a b))))

(defun fib (n)
  (fib n 0 1))

(defun factorial
  ((0)
   1)
  ((n)
   (* n (factorial (- n 1)))))

