(defmodule Counter
  (export
   (new-counter 0)
   (counter 1)
   (inc 1)
   (dec 1)
   (reset 1)
   (get 1)
   (set-to 2)))


(defun counter (n)
  (receive
    ('inc
     (counter (+ n 1)))
    ('dec
     (counter (- n 1)))
    ('reset
     (counter 0))
    ((tuple 'set m)
     (counter m))
    ((tuple 'get pid)
     (! pid n)
     (counter n))
    (other
     (counter n))))

(defun new-counter ()
  (spawn 'Counter 'counter (list 0)))

(defun inc (c)
  (! c 'inc))

(defun dec (c)
  (! c 'dec))

(defun reset (c)
  (! c 'reset))

(defun set-to (c n)
  (! c (tuple 'set n)))

(defun get (c)
  (! c (tuple 'get (self)))
  (receive
    (n
     n)
    (after 1000
      'error)))