(defmodule Concat
  (export-macro concat concat-to-function def)
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

;defines a function with ,name that takes one argument, the list of arguments for the first
;function in the concatination
(defmacro def
  ((cons name  functions)
  `(defun ,name (x)
     (funcall (Concat:concat-to-function ,@functions) x ))))

