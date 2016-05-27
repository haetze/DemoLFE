(defmodule b ;;simply a rapper around bif's
    (export
     (b_to_t 1)
     (t_to_b 1)
     (l_to_b 1)
     (binary-patterns 1)
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


;;binary pattern
;;(b:binary:patterns (binary 100 100))
;;a is 100 (8 byte is a number) for each number in binary
;;b is 0 (first byte of the number
;;c is 100 in 7 byte
(defun binary-patterns
  (((binary (a bitstring  (size 16))
	   (b (size 8))
	   (c (size 8))))
   (io:format "~p~n~p~n~p~n" (list (binary_to_list a) (list b) c)))
  ((b)
   (io:format "~p~n" (list b))))
   
