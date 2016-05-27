;;Richard Stewing
;;06.04.2016
;;just an example of macros
;;they behave differently than in vanilla erlang or
;;common lisp macros 

(defmodule macros
    (export
     (test 1)
     (mac-fun 0)))

;;macros are not exported yet
;; will be exported in version 1.0
;;
(defmacro example (n)
  `(io:format "~p~n" (list (+ 1 n))))

;;they don't compile
;;propably because they are recursive
(defmacro range-macro (n)
  `(if (=:= ,n 1)
       (list 1)
       (listLib:append ,(range-macro (- n 1)) ,n)))

;;just calls the example macro
(defun test (n)
  (example n))


;; macro with variable number of
;; arguments
(defmacro mac a
  `(io:format "~p~n"  (list ,a)))

(defun mac-fun ()
  (mac 1 2 3 4 5))

