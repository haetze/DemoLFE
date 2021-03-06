
(defmodule uno_supervisor
  (behavior supervisor)
  (export
   (start_link 0)
   (init 1)))


(defun start_link ()
  (supervisor:start_link (tuple 'local 'uno_supervisor)
			 'uno_supervisor
			 'null))

(defun init (f)
  (tuple 'ok
	 (tuple (tuple 'simple_one_for_one 1 1)
		(list (tuple 'uno_supervised
			     (tuple 'supervised 'start_link ())
			     'temporary 2000 'worker (list 'supervised 'server 'handler))))))
