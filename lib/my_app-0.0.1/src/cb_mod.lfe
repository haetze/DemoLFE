(defmodule cb_mod
  (behaviour application)
  (export
   (start 2)
   (stop 1)))


(defun start(_type _args)
  (my_app:start))

(defun stop (_state)
  'ok)

