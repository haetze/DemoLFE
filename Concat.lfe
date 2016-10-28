(defmodule Concat
  (export-macro concat)
  (export
   (appl 3)
   )) 

(defun appl (f1 f2 in)
  (Concat:concat f1 f2 in))

(defmacro concat
  ((list args)
   args)
  ((list f1 args)
   `(apply ,f1 ,args))
  ((list f1 f2 args)
   `(funcall ,f1 (apply ,f2 ,args)))
  (args
   `(funcall ,(car args) (Concat:concat ,@(cdr args)))))



