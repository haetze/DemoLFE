(defmodule strings
    (export
     (words 1)))

;;spaces will disappeare from the list of list
(defun words (str)
  (listLib:separator str 32))
