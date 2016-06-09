(defmodule echo_service_sup
  (behavoir supervisor)
  (export
   (start_link 2)
   (init 1)
   (service 2)))


(defun start_link (from data)
  (supervisor:start_link 'echo_service_sup
			 (tuple from data)))

(defun init
  (((tuple from data))
	   (tuple 'ok
		  (tuple
		   (tuple 'one_for_all 1 1)
		   (list
		    (tuple 'service_sup
			   (tuple 'echo_service_sup 'service (list from data))
			   'transient 2000 'worker (list 'echo_service_sup)))))))


(defun service (from data)
  (gen_server:reply from data)
  (tuple 'ok (self)))