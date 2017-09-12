(defmodule notifyHub
  (behavior application)
  (export
   (start 2)
   (stop 1)))

(defun start (type, args)
  (let ((ret (notifyHub_supervisor:start_link)))
    (supervisor:start_child 'notifyHub_supervisor (list 'sender))
    (supervisor:start_child 'notifyHub_supervisor (list 'receiver))
    ret))

(defun stop (state)
  'ok)


