(defmodule echo_tcp_sup
  (behavoir supervisor)
  (export
   (start_link 1)
   (server 1)
   (init 1)))


(defun start_link (port)
  (supervisor:start_link 'echo_tcp_sup
			 (tuple port))
  (tuple 'ok (self)))

(defun init
  (((tuple port))
	   (tuple 'ok
		  (tuple
		   (tuple 'one_for_all 1 1)
		   (list
		    (tuple 'tcp_sup
			   (tuple 'tcp 'server (list port))
			   'transient 2000 'worker (list 'echo_tcp_sup)))))))


(defun server (p)
  (io:format "jal~n" ())
  (tuple 'ok (self)))

