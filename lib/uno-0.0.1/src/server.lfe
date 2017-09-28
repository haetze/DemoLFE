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
  ([reason (tuple name socket state hand rn)]
   (io:format "~p~n" (list reason))
   (gen_server:cast 'handler (tuple rn 'terminate))
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
    (tuple name socket state hand rn)]
   (case (helper:split message " ")

     ((list _ "pull" _)
      (if (=:= state 'pulled)
	(progn 
	  (gen_tcp:send socket (io_lib_format:fwrite "~p ~p ~p ~p\n" (list (list_to_atom name)
									   (self)
									   'denied
									   'null)))
	  (gen_server:cast 'handler (tuple rn (tuple (self) 'pass)))
	  (tuple 'noreply (tuple name socket 'in_game hand rn)))
	(progn
	  (gen_server:cast 'handler (tuple rn (tuple (self) 'pull)))
	  (tuple 'noreply (tuple name socket 'pulled hand rn)))))
     
     ((list _ "start" _)
      (gen_server:cast 'handler (tuple rn (tuple (self) 'start)))
      (tuple 'noreply  (tuple name socket state hand rn)))
     
     ((list _ "put" c t)
      ;(io:format "~p ~p ~n" (list c t))
      (gen_server:cast 'handler (tuple rn (tuple (self) 'put (tuple (list_to_atom c)
							  (list_to_integer  (string:trim t))))))
      (tuple 'noreply  (tuple name socket state hand rn)))
     
     ((list _ "pass" _)
      (gen_server:cast 'handler (tuple rn (tuple (self) 'pass)))
      (tuple 'noreply (tuple name socket state hand rn)))
     (_
      (tuple 'noreply (tuple name socket state hand rn)))))

  ([(tuple 'tcp p_socket message) socket]
     (case (helper:split message " ")
       ((list name "connect" room_name)
	(gen_server:cast 'handler (tuple room_name (tuple (self) 'connect 'null)))
	(tuple 'noreply (tuple name socket 'connects 'nil room_name)))))

  ([(tuple 'tcp_closed p_socket)
    (tuple name socket state hand rn)]
   (gen_server:cast 'handler (tuple rn 'terminate))
   (gen_tcp:close socket)
   (tuple 'stop 'normal
	  (tuple name socket state hand rn)))

  ([(tuple 'tcp_closed p_socket) socket]
					;(gen_server:cast 'handler (tuple rn 'terminate))
   (gen_tcp:close socket)
   (tuple 'stop 'normal 'nil))
  
  ([_ socket]
    (io:format "Got something else~n" '())
    (tuple 'stop 'unexpected_message socket)))
	      


(defun handle_cast
  (['game_in_progress (tuple _ s _ _ _)]
   (gen_tcp:send s (io_lib_format:fwrite "~p\n" (list 'game_in_progress)))
   (tuple 'stop 'normal 'game_in_progress))
  
  (['ok (tuple name socket 'connects  hand rn)]
   (gen_tcp:send socket (io_lib_format:fwrite "~p ~p ~p ~p\n" (list (list_to_atom name)
							       (self)
							       'accepted
							       'null)))
   (tuple 'noreply (tuple name socket 'connected 0 rn)))
  (['started (tuple name socket 'connected  hand rn)]
   (gen_tcp:send socket (io_lib_format:fwrite "~p ~p ~p ~p\n" (list (list_to_atom name)
							       (self)
							       'started
							       'null)))
   (tuple 'noreply (tuple name socket 'in_game hand rn)))
  ([(tuple c t) (tuple name socket 'connected hand rn)]
    (gen_tcp:send socket (io_lib_format:fwrite "~p ~p ~p ~p ~p\n" (list (list_to_atom name)
							       (self)
							       'cards
							       c
							       t)))
    (tuple 'noreply (tuple name socket 'connected (+ hand 1) rn)))

  ([(tuple c t) (tuple name socket 'pulled hand rn)]
    (gen_tcp:send socket (io_lib_format:fwrite "~p ~p ~p ~p ~p\n" (list (list_to_atom name)
							       (self)
							       'cards
							       c
							       t)))
    (tuple 'noreply (tuple name socket 'pulled (+ hand 1) rn)))

  ([(tuple (tuple color type) 'next next)
    (tuple name socket state hand rn)]
   (if (=:= (self) next)
     (progn 
       (gen_tcp:send socket  (io_lib_format:fwrite "~p ~p ~p ~p ~p\n" (list (list_to_atom name)
									next
									'next
									color
									type)))
       (tuple 'noreply (tuple name socket 'in_turn hand rn)))       
   (progn
     (gen_tcp:send socket  (io_lib_format:fwrite "~p ~p ~p ~p ~p\n" (list (list_to_atom "unkown")
									next
									'next
									color
									type)))
     (tuple 'noreply (tuple name socket state hand rn)))))

  (['disapproved (tuple name socket 'in_turn hand rn)]
   (gen_tcp:send socket (io_lib_format:fwrite "~p ~p ~p ~p\n" (list (list_to_atom name)
									(self)
									'denied
									'null)))
   (tuple 'noreply (tuple name socket 'in_turn hand rn)))

  (['approved (tuple name socket 'in_turn hand rn)]
   (if (=:= 1 (- hand 1))
     (gen_server:cast 'handler (tuple rn (tuple 'uno name (self)))))
   (if (=:= 0 (- hand 1))
     (gen_server:cast 'handler (tuple rn (tuple 'won name (self)))))
   (gen_tcp:send socket (io_lib_format:fwrite "~p ~p ~p ~p\n" (list (list_to_atom name)
								       (self)
								       'approved
								       'null)))
   (tuple 'noreply (tuple name socket 'in_game (- hand 1) rn)))

  ([(tuple 'uno n p) (tuple name socket state hand rn)]
   (gen_tcp:send socket (io_lib_format:fwrite "~p ~p ~p ~p\n" (list (list_to_atom n)
								       p
								       'uno
								       'null)))
   (tuple 'noreply (tuple name socket state hand rn)))
  
   ([(tuple 'won n p) (tuple name socket state hand rn)]
    (gen_tcp:send socket (io_lib_format:fwrite "~p ~p ~p ~p\n" (list (list_to_atom n)
								     p
								     'won
								     'null)))
    (gen_tcp:close socket)
    (tuple 'stop 'normal 'state))

   (['terminate (tuple name socket state hand rn)]
    (gen_tcp:close socket)
    (tuple 'stop 'normal (tuple name socket state hand rn)))
   

  (('accept listen_socket)
   (let (((tuple 'ok socket) (gen_tcp:accept listen_socket)))
     (io:format "Got it~n" ())
     (supervisor:start_child 'uno_supervisor (list 'server listen_socket))
     (tuple 'noreply socket))))
