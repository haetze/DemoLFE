(defmodule read_write_service_sup
  (behavior supervisor)
  (export
   (start_link 1)
   (init 1)))


(defun start_link (n)
  (supervisor:start_link 'read_write_service_sup
			 n))


(defun init (n)
  (tuple 'ok
	 (tuple (tuple 'one_for_all 1 1)
	  (list (tuple n
		 (tuple 'read_write_service 'start_link (list n))
		 'temporary 2000 'worker (list 'read_write_service))))))
		       