(defmodule Map
  (export
   (set 3)
   (get 2)))


(defun set (m k v)
  (-> m k v))

(defun get (m k)
  (<- m k))
