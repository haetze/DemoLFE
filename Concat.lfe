(defmodule Concat
  (export-macro concat concat-to-function)
  (export
   (appl 1)
   )) 

(defun appl (f1 f2 in)
  (Concat:concat f1 f2 in))

(defun appl (in)
  (Concat:concat (lambda (x) (+ x 5))  (lambda (x) (+ x 5))  (list in) ))


(defmacro concat
  ((list args)
   args)
  ((list f1 args)
   `(apply ,f1 ,args))
  ((list f1 f2 args)
   `(funcall ,f1 (apply ,f2 ,args)))
  (args
   `(funcall ,(car args) (Concat:concat ,@(cdr args)))))


;resulting function needs to be called with a list of arguments
(defmacro concat-to-function args
  `(lambda (xs) (Concat:concat ,@(lists:append args (list 'xs)))))

