(defmodule echo_sup
  (behavoir supervisor)
  (export
   (start_link 0)
   (init 1)))


(defun start_link ()
  (supervisor:start_link (tuple 'local 'echo_sup)
			 'echo_sup
			 ()))

(defun init (arg)
  (tuple 'ok
	 (tuple
	  (tuple 'one_for_all 1 1)
	  (list
	   (tuple 'echo
		  (tuple 'echo_gen 'start_link ())
		  'permanent 2000 'worker (list 'echo_gen))))))