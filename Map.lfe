(defmodule Map
  (export
   (update-function 3)
   (new-map 0)))

;; Map are functions
;; They take one arguments of two forms:
;;    a key
;;    a key-value pair


(defun update-function (f k v)
  (lambda (k-2)
    (if (=:= k k-2)
      v
      (funcall f k-2))))

(defun new-map ()
  (lambda (input)
    (case input
      ((tuple k v) (update-function (new-map) k v))
      (k (tuple 'error 'key-non-existent)))))


