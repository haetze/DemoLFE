(defmodule distributed
  (export
   (send 2)))


(defun send (pid message)
  (case (file:open "tmp" (list 'read 'append))
    ((tuple 'ok dev)
     (let ((t (lfe_io:read dev "")))
       (lfe_io:format "~p~n" (list t))
       (lfe_io:format dev "~p~n" (list message))))
    (n
     (io:format "error~n" ())))
  (! pid message))