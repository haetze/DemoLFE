(defmodule binary
    (export
     (b_to_term 1)
     (term_to_b 1)

     ))


(defun b_to_term (b)
  (binary_to_term b))

(defun term_to_b (t)
  (term_to_binary t))
