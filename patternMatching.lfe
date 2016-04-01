(defmodule patternMatching
    (export
     (eq 2)
     (or 2)))

;;no eq in function head
;;you have to use guards
;;(the when clause)
(defun eq
  ;;((n n) this code doesn't compile
  ((n n1) (when (=:= n n1))
     'true)
  ((n n1)
   'false))

;;example or-implementation
;;using guards
(defun or
  ((n _) (when (=:= n 'true))
   'true)
  ((_ n) (when (=:= n 'true))
   'true)
  ((_ _)
   'false))
