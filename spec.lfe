(defmodule spec
  (export
   (test 1)))

(spec test ((integer) string))
;(spec test ((integer) (any)))
(defun test (x)
  (integer_to_list x))