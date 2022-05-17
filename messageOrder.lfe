(defmodule messageOrder
  (export all))

(defun test ()
  (receive
    (0
     (io:format "Got 0~n" '())
     (test2))
    (1
     (io:format "Got 1~n" '())
     (test3)))
  (test))

(defun test2 ()
  (receive
    (2
     (io:format "Got 2~n" '()))))

(defun test3 ()
  (receive
    (3
     (io:format "Got 3~n" '()))))



(defun showing-message-reorder ()
  (let ((p (spawn (MODULE) 'test '())))
    (! p 2)
    (! p 3)
    (! p 1)
    (! p 0)))