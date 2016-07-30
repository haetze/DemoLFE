(defmodule read_write_sup
  (behavior supervisor)
  (export
   (start_link 0)
   (init 1)))


(defun start_link ()
  (supervisor:start_link ;(tuple 'local 'read_write_sup)
			 'read_write_sup
			 'null))


(defun init (n)
  (tuple 'ok
	 (tuple (tuple 'one_for_all 1 1)
	  (list (tuple 'read_write_gen
		 (tuple 'read_write_gen 'start_link ())
		 'permanent 2000 'worker (list 'read_write_gen))))))
		       