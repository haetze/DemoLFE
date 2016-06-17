(defmodule read_write_gen
  (behavior gen_server)
  (export
   (start_link 0)
   (init 1)
   (terminate 2)
   (handle_cast 2)
   (handle_call 3)))


(defun start_link ()
  (gen_server:start_link (tuple 'local 'read_write_gen)
			 'read_write_gen
			 'null
			 ()))


(defun init (_args)
  (tuple 'ok 'null))

(defun terminate (_reason _loop_data)
  'ok)

(defun handle_cast
  (('stop data)
   (tuple 'stop 'normal data)))

(defun handle_call
  (((tuple 'create name) _from data)
   (tuple 'reply
	  (read_write_service_sup:start_link name)
	  data))
  ((_other _from data)
   (tuple 'noreply data)))
   
			     