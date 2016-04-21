;;Richard Stewing
;;21.04.2016


(defmodule stringAsList
  (export
   (firstWord 1)
   ))


(defun firstWord
  (( (cons 32 t) )
   ())
  (( (cons h   t) )
   (cons h (firstWord t))))