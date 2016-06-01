(defmodule distributed
  (export
   (send 2)))


(defun send (pid message)
  (case (file:open "tmp" (list 'read 'write))
    ((tuple 'ok dev)
     (let ((t (io:read dev "")))
       (io:format "~p~n" (list t))
       (io:write dev message)))
    (n
     (io:format "error~n" ())))
  (! pid message))