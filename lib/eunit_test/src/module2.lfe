(defmodule module2
  (export
   (reverse 1)
   (test 0)))

(include-lib "eunit/include/eunit.hrl")


(defun reverse_test ()
  (if (=:= (reverse ()) ())
    'ok
    (tuple 'error (reverse ()) ())))

(defun reverse
  ((()) ())
  (((cons h t))
   (++ (reverse t) (list h))))