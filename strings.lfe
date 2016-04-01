(defmodule strings
    (export
     (words 1) ;;specialized seperater
     (separator 2)))

;;spaces will disappeare from the list of list
(defun words (str)
  (listLib:separator str 32))

(defun separator (str sep)
  (separator () () str sep))

(defun separator
  ((word-list current-word () sep)
   (listLib:append word-list current-word))
  
  ((word-list current-word (cons h t) sep) (when (=:= sep h))
   (separator (listLib:append word-list current-word) () t sep))
  
  ((word-list current-word (cons h t) sep)
   (separator word-list (listLib:append current-word h) t sep)))
  
