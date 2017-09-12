(defmodule sender
  (behavior gen_server)
  (export
   (start_link 0)
   (start_link 1)
   (init 1)
   (terminate 2)
   (handle_cast 2)
   (handle_call 2)
   (handle_info 2)))

(defmacro port ()
  8081)

(defun start_link ()
  (let (((tuple 'ok s) (gen_tcp:listen (port) '())))
    (gen_server:start_link 'sender s '())))

(defun start_link (args)
  (gen_server:start_link 'sender args '()))


(defun init (listen_socket)
  (gen_server:cast (self) 'accept)
  (tuple 'ok listen_socket))


(defun terminate (reason socket)
  (gen_tcp:close socket))

(defun handle_cast (message listen_socket)
   (let (((tuple 'ok socket) (gen_tcp:accept listen_socket)))
     (supervisor:start_child 'notifyHub_supervisor (list 'sender listen_socket))
     (tuple 'noreply socket)))


(defun handle_call (message socket)
  (tuple 'noreply socket))

(defun handle_info
  ([(tuple 'tcp p_socket packet)
    socket]
   (io:format "Got ~p from ~p~n" (list packet p_socket))
   (tuple 'noreply socket))
  ([_ socket]
   (io:format "Got something else~n" '())
   (tuple 'stop 'unexpected_message socket)))
	      
