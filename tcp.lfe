;;example module for tcp
;;host is hardcoded in as local host
(defmodule tcp
    (export
     (server 1)
     (server 0) ;;uses standart port 8080
     (client 1) ;;uses standart port 8080
     (client 2)
     (wait-connect 1)
     (wait-for-messages 1)
     ))

(defun server ()
  (server 8080))

(defun server (port)
  (let (((tuple 'ok socket) (gen_tcp:listen port (list 'binary))))
  (spawn 'tcp 'wait-connect (list socket))))


(defun wait-connect (socket)
  (let (((tuple 'ok sock) (gen_tcp:accept socket)))
    (spawn 'tcp 'wait-connect (list socket))
    (wait-for-messages sock)))

;;messages received over utp are in the normal message box of
;;the process only in a tuple
(defun wait-for-messages (socket)
  (receive 
    ((tuple 'tcp _R bin)
     (io:format "~p~n" (list (binary_to_list bin)))
     (wait-for-messages socket))
    ((tuple 'tcp_closed _p)
     (io:format "connection closed~n" ()))
    (n
     (io:format "~p~n" (list n)))))


;;simple client that sends the messages given to it and then closes the
;;connection
(defun client (data port)
  (let (((tuple 'ok socket) (gen_tcp:connect (tuple 127 0 0 1)
					     port (list 'binary))))
    ;;(send sockeet data)
    (gen_tcp:send socket data)
    (gen_tcp:close socket)))

(defun client (data)
  (client data 8080))

;;send function that sends a messages in packages of <=100 byte
(defun send
  ((socket (binary (h (size 100)) r))
   (gen_tcp:send socket h)
   (send socket r))
  ((socket r)
   (gen_tcp:send socket r)))
