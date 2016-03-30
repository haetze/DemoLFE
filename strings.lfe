(defmodule strings
    (export
     (words 1)))


(defun words (str)
  (words () () str))


(defun words
  ((word-list current-word ())
   (append word-list current-word))
  ((word-list current-word (cons 32 t))
   (words (append word-list current-word) () t))
  ((word-list current-word (cons h t))
   (words word-list (append current-word h) t)))
  
(defun append (lst val)
  (reverse (cons val (reverse lst))))

(defun reverse (lst)
   (reverse lst ()))

(defun reverse
  (( () reverse-list)
   reverse-list)
  (( (cons h t) reverse-list)
   (reverse t (cons h reverse-list))))
