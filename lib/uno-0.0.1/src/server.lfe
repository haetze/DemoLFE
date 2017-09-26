(defmodule server
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
    (gen_server:start_link (tuple 'local 'server)'server s '())))

(defun start_link (args)
  (gen_server:start_link 'server args '()))


(defun init (listen_socket)
  (gen_server:cast (self) 'accept)
  (tuple 'ok listen_socket))


(defun terminate
  ([reason (tuple name socket state hand)]
   (io:format "~p~n" (list reason))
   (gen_server:cast 'handler 'terminate)
   (gen_tcp:close socket))
  ([reason socket]
   (io:format "~p~n" (list reason))
   (gen_tcp:close socket)
   (tuple 'stop 'normal)))



(defun handle_call
  (['name (tuple name socket state hand)]
   (tuple 'reply name (tuple name socket state hand))))

(defun handle_info
  ([(tuple 'tcp p_socket message)
    (tuple name socket state hand)]
   (case (helper:split message " ")

     ((list _ "pull" _)
      (if (=:= state 'pulled)
	(progn 
	  (gen_tcp:send socket (io_lib_format:fwrite "~p ~p ~p ~p\n" (list (list_to_atom name)
									   (self)
									   'denied
									   'null)))
	  (gen_server:cast 'handler (tuple (self) 'pass))
	  (tuple 'noreply (tuple name socket 'in_game hand)))
	(progn
	  (gen_server:cast 'handler (tuple (self) 'pull))
	  (tuple 'noreply (tuple name socket 'pulled hand)))))
     
     ((list _ "start" _)
      (gen_server:cast 'handler (tuple (self) 'start) )
      (tuple 'noreply  (tuple name socket state hand)))
     
     ((list _ "put" c t)
      ;(io:format "~p ~p ~n" (list c t))
      (gen_server:cast 'handler (tuple (self) 'put (tuple (list_to_atom c)
							  (list_to_integer  (string:trim t)))))
      (tuple 'noreply  (tuple name socket state hand)))
     
     ((list _ "pass" _)
      (gen_server:cast 'handler (tuple (self) 'pass))
      (tuple 'noreply (tuple name socket state hand)))
     (_
      (tuple 'noreply (tuple name socket state hand)))))

  ([(tuple 'tcp p_socket message) socket]
     (case (helper:split message " ")
       ((list name "connect" n)
	(gen_server:cast 'handler (tuple (self) 'connect 'null))
	(tuple 'noreply (tuple name socket 'connects 'nil)))))

  ([(tuple 'tcp_closed p_socket)
    (tuple name socket state hand)]
   (gen_server:cast 'handler 'terminate)
   (gen_tcp:close socket)
   (tuple 'stop 'normal
	  (tuple name socket state hand)))

  ([(tuple 'tcp_closed p_socket) socket]
   (gen_server:cast 'handler 'terminate)
   (gen_tcp:close socket)
   (tuple 'stop 'normal 'nil))
  
  ([_ socket]
    (io:format "Got something else~n" '())
    (tuple 'stop 'unexpected_message socket)))
	      


(defun handle_cast
  (['ok (tuple name socket 'connects  hand)]
   (gen_tcp:send socket (io_lib_format:fwrite "~p ~p ~p ~p\n" (list (list_to_atom name)
							       (self)
							       'accepted
							       'null)))
   (tuple 'noreply (tuple name socket 'connected 0)))
  (['started (tuple name socket 'connected  hand)]
   (gen_tcp:send socket (io_lib_format:fwrite "~p ~p ~p ~p\n" (list (list_to_atom name)
							       (self)
							       'started
							       'null)))
   (tuple 'noreply (tuple name socket 'in_game hand)))
  ([(tuple c t) (tuple name socket 'connected hand)]
    (gen_tcp:send socket (io_lib_format:fwrite "~p ~p ~p ~p ~p\n" (list (list_to_atom name)
							       (self)
							       'cards
							       c
							       t)))
    (tuple 'noreply (tuple name socket 'connected (+ hand 1))))

  ([(tuple c t) (tuple name socket 'pulled hand)]
    (gen_tcp:send socket (io_lib_format:fwrite "~p ~p ~p ~p ~p\n" (list (list_to_atom name)
							       (self)
							       'cards
							       c
							       t)))
    (tuple 'noreply (tuple name socket 'pulled (+ hand 1))))

  ([(tuple (tuple color type) 'next next)
    (tuple name socket state hand)]
   (if (=:= (self) next)
     (progn 
       (gen_tcp:send socket  (io_lib_format:fwrite "~p ~p ~p ~p ~p\n" (list (list_to_atom name)
									next
									'next
									color
									type)))
       (tuple 'noreply (tuple name socket 'in_turn hand)))       
   (progn
     (gen_tcp:send socket  (io_lib_format:fwrite "~p ~p ~p ~p ~p\n" (list (list_to_atom "unkown")
									next
									'next
									color
									type)))
     (tuple 'noreply (tuple name socket state hand)))))

  (['disapproved (tuple name socket 'in_turn hand)]
   (gen_tcp:send socket (io_lib_format:fwrite "~p ~p ~p ~p\n" (list (list_to_atom name)
									(self)
									'denied
									'null)))
   (tuple 'noreply (tuple name socket 'in_turn hand)))

  (['approved (tuple name socket 'in_turn hand)]
   (if (=:= 1 (- hand 1))
     (gen_server:cast 'handler (tuple 'uno name (self))))
   (if (=:= 0 (- hand 1))
     (gen_server:cast 'handler (tuple 'won name (self))))
   (gen_tcp:send socket (io_lib_format:fwrite "~p ~p ~p ~p\n" (list (list_to_atom name)
								       (self)
								       'approved
								       'null)))
   (tuple 'noreply (tuple name socket 'in_game (- hand 1))))

  ([(tuple 'uno n p) (tuple name socket state hand)]
   (gen_tcp:send socket (io_lib_format:fwrite "~p ~p ~p ~p\n" (list (list_to_atom n)
								       p
								       'uno
								       'null)))
   (tuple 'noreply (tuple name socket state hand)))
  
   ([(tuple 'won n p) (tuple name socket state hand)]
    (gen_tcp:send socket (io_lib_format:fwrite "~p ~p ~p ~p\n" (list (list_to_atom n)
								     p
								     'won
								     'null)))
    (gen_tcp:close socket)
    (tuple 'stop 'normal 'state))
   (['terminate (tuple name socket state hand)]
    (gen_tcp:close socket)
    (tuple 'stop 'normal (tuple name socket state hand)))
   

  (('accept listen_socket)
   (let (((tuple 'ok socket) (gen_tcp:accept listen_socket)))
     (io:format "Got it~n" ())
     (supervisor:start_child 'uno_supervisor (list 'server listen_socket))
     (tuple 'noreply socket))))
