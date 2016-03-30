(defmodule strings
    (export
     (words 1) ;;specialized seperater
     (seperater 2)))

;;spaces will disappeare from the list of list
(defun words (str)
  (seperater str 32))

(defun seperater (str sep)
  (seperater () () str sep))

(defun seperater
  ((word-list current-word () sep)
   (listLib:append word-list current-word))
  
  ((word-list current-word (cons h t) sep) (when (=:= sep h))
   (seperater (listLib:append word-list current-word) () t sep))
  
  ((word-list current-word (cons h t) sep)
   (seperater word-list (listLib:append current-word h) t sep)))
  
