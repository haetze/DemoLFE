(defmodule b
    (export
     (b_to_t 1)
     (t_to_b 1)
     (l_to_b 1)
     (b_to_l 1)))

;;transforms binarys to the according term
(defun b_to_t (b)
  (binary_to_term b))

;;transforms terms to the binary representation
(defun t_to_b (t)
  (term_to_binary t))

;;transfroms list to binary
(defun l_to_b (l)
  (list_to_binary l))

(defun b_to_l (b)
  (binary_to_list b))




