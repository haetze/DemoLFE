
(defmodule supervised
  (export
   (start_link 1)
   (start_link 2)))


(defun start_link
  (('handler)
   (handler:start_link))
  (('server)
   (server:start_link))
  ((_)
   (tuple 'stop 'normal ())))



(defun start_link
  (('handler state)
   (handler:start_link state))
  (('server state)
   (server:start_link state))
  ((_ _)
   (tuple 'stop 'normal ())))
    