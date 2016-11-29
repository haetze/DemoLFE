(defmodule Color
  (export
   (color-to-code 1)
   (set-background 1)
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
   (list_to_binary "\e[37m"))
  (('black)
   (list_to_binary "\e[30m"))
  ((color)
   (list_to_binary color)))

(defun set-background
   (('red)
   (list_to_binary "\e[41m"))
  (('green)
   (list_to_binary "\e[42m"))
  (('yellow)
   (list_to_binary "\e[43m"))
  (('blue)
   (list_to_binary "\e[44m"))
  (('magenta)
   (list_to_binary "\e[45m"))
  (('cynage)
   (list_to_binary "\e[46m"))
  (('white)
   (list_to_binary "\e[47m"))
  (('black)
   (list_to_binary "\e[40m"))
  ((color)
   (list_to_binary color)))

(defun reset ()
  (list_to_binary "\e[0m"))

(defun print-in-color
  ((text (tuple 'background background-color))
   (print-in-color text (tuple 'black background-color)))
  ((text (tuple 'text-color text-color))
   (print-in-color text (tuple text-color 'white)))
  ((text (tuple text-color background-color))
   (io:format "~s" (list (list (color-to-code text-color)
			       (set-background background-color)
			       text
			       (reset))))))


