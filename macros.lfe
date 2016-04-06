(defmodule macros
    (export
     (test 0)))

;;macros are not exported yet
;; will be exported in version 1.0
;;
(defmacro example (n)
  `(io:format "~p~n" (list n)))


(defmacro range-macro (n)
  `(if (=:= ,n 1)
       (list 1)
       (listLib:append ,(range-macro (- n 1)) ,n)))
       
(defun test ()
  (io:format "~p~n" (range-macro 1)))



