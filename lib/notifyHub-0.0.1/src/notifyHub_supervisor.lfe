(defmodule notifyHub_supervisor
  (behavior supervisor)
  (export
   (start_link 0)
   (init 1)))


(defun start_link ()
  (supervisor:start_link (tuple 'local 'notifyHub_supervisor)
			 'notifyHub_supervisor
			 'null))

(defun init (f)
  (read_write:create 'notifications)
  (tuple 'ok
	 (tuple (tuple 'simple_one_for_one 1 1)
		(list (tuple 'notifyHub_supervised
			     (tuple 'supervised 'start_link ())
			     'permanent 2000 'worker (list 'supervised 'sender 'receiver))))))
