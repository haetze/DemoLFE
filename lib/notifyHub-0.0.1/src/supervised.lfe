(defmodule supervised
  (export
   (start_link 1)
   (start_link 2)))


(defun start_link
  (('receiver)
   (receiver:start_link))
  (('sender)
   (sender:start_link))
  ((_)
   (tuple 'stop 'normal ())))



(defun start_link
  (('receiver state)
   (receiver:start_link state))
  (('sender state)
   (sender:start_link state))
  ((_ _)
   (tuple 'stop 'normal ())))
    