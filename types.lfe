(defmodule types
  (export
   (test 1)))


(deftype foo (lambda ((integer)) (string)))

(defspec (test 1)
  ([(integer)] (string)))

(defun test (x)
  "renames integer_to_list to test"
  (integer_to_list x))

