(defmodule list
  (export
   (filter 2)
   (zip 2)
   (flip 3)
   (my-map 2)
   (reduce 2)))

(defun my-map
  ((_ ()) ())
  ((f (cons h t)) (cons (funcall f h) (my-map f t ))))

(defun flip (f a b) (funcall f b a))

(defun filter (p l) (list-comp ((<- x l) (funcall p x)) x))


(defun reduce (p l) (filter (lambda (x) (not (funcall p x))) l))


(defun zip
  ((() _) ())
  ((_ ()) ())
  (((cons h1 t1) (cons h2 t2)) (cons (tuple h1 h2) (zip t1 t2))))



  