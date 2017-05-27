;; @author Richard Stewing <richy.sting@gmail.com>
;; @doc Example module to use with edoc 
;; @copyright 2017 Richard Stewing 

(defmodule Example
  (export
   (example 1)))


;; @doc Adds one to a number.
;; @spec example(integer()) -> integer()
(defun example
  "adds one to each integer put in"
  ((0) 1)
  ((n) (+ n 1)))