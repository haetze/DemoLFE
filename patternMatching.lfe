(defmodule patternMatching
    (export
     (matching 2)))
;;this code doesn't compile
;;no eq in function head
(defun matching
    ((n n)
     'true))
