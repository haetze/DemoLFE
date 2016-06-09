(defmodule echo_gen
  (behavoir gen_server)
  (export
   (start_link 0)
   (stop 0)
   (init 1)
   (terminate 2)
   (handle_cast 2)
   (handle_call 3)
   (handle_info 2)))


(defun start_link ()
  (gen_server:start_link (tuple 'local 'echo)
			 'echo_gen
			 'null
			 ()))

(defun stop ()
  (gen_server:cast 'echo 'stop))

(defun init (_)
  (tuple 'ok 'null))

(defun terminate (_reason _loo-data)
  'ok)

(defun handle_cast
  (('stop loop-data)
   (tuple 'stop 'normal loop-data))
  ((data loop-data)
   (tuple 'noreply loop-data)))

(defun handle_call (data from loop-data)
  (echo_service_sup:start_link from data)
  (tuple 'noreply loop-data))

(defun handle_info (info state)
  ;(io:format "~p~n" (list info))
  (tuple 'noreply state))