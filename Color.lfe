(defmodule Color
  (export
   (color-to-code 1)
   (reset 0)
   (print-in-color 2)))

(defun color-to-code
  (('red)
   (list_to_binary "\e[31m"))
  (('green)
   (list_to_binary "\e[32m"))
  (('yellow)
   (list_to_binary "\e[33m"))
  (('blue)
   (list_to_binary "\e[34m"))
  (('magenta)
   (list_to_binary "\e[35m"))
  (('cynage)
   (list_to_binary "\e[36m"))
  (('white)
   (list_to_binary "\e[37m")))

(defun reset ()
  (list_to_binary "\e[0m"))

(defun print-in-color (text color)
  (io:format "~s" (list (list (color-to-code color) text (reset)))))