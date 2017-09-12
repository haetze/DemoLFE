(defmodule receiver
  (behavior gen_server)
  (export
   (start_link 0)
   (start_link 1)
   (init 1)
   (handle_cast 2)
   (handle_call 2)
   (terminate 2)
   (handle_info 2)))

(defmacro port ()
  8080)

(defun start_link ()
  (let (((tuple 'ok s) (gen_tcp:listen (port) '())))
    (gen_server:start_link 'receiver s '())))

(defun start_link (args)
  (gen_server:start_link 'receiver args '()))

(defun init (args)
  (gen_server:cast (self) 'accept)
  (tuple 'ok args))


(defun terminate (reason socket)
  (gen_udp:close socket)
  (tuple 'stop 'normal socket))


(defun handle_cast (message listen_socket)
   (let (((tuple 'ok socket) (gen_tcp:accept listen_socket)))
     (supervisor:start_child 'notifyHub_supervisor (list 'receiver listen_socket)) 
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
   (tuple 'noreply socket)))
