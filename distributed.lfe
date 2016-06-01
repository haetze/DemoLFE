(defmodule distributed
  (export
   (send 2)))


(defun send (pid message)
  (case (file:open "tmp" (list 'read 'write))
    ((tuple 'ok dev)
     (let ((t (io:read dev "")))
       (lfe_io:format "~p~n" (list t))
       (lfe_io:write dev message)
       (lfe_io:format dev "~n" ())))
    (n
     (io:format "error~n" ())))
  (! pid message))