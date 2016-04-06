(defmodule macros
    (export
     (test 1)))

;;macros are not exported yet
;; will be exported in version 1.0
;;
(defmacro example (n)
  `(io:format "~p~n" (list (+ ,n 1))))

(defun test (n)
  (example n))





