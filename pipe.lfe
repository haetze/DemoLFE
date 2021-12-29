(defmodule pipe
  (export
   (var 0)
   ))

(defmacro mean args
  `(/ (lists:sum ,args)
      ,(length args)))

(defmacro pipe
  (()
   '())
  ((list n)
   n)
  ((cons val (cons (cons f args)  rest))
   `(pipe (,f ,val ,@args) ,@rest)))


(defun var ()
  (pipe
   1
   (+ 1)
   (/ 2)))

  