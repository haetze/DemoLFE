(defmodule tcp
    (export
     (server 1)
     (server 0)
     (client 1)
     (wait-connect 1)
     (req 1)
     ))

(defun server ()
  (server 8080))

(defun server (port)
  (let (((tuple 'ok socket) (gen_tcp:listen port (list 'binary))))
  (spawn 'tcp 'wait-connect (list socket))))


(defun wait-connect (socket)
  (let (((tuple 'ok sock) (gen_tcp:accept socket)))
    (spawn 'tcp 'wait-connect (list socket))
    (req sock)))


(defun req (socket)
  (receive 
    ((tuple 'tcp _R bin)
     (io:format "~p~n" (list (binary_to_list bin)))
     (req socket))
    ((tuple 'tcp_closed _p)
     (io:format "connection closed~n" ()))
    (n
     (io:format "~p~n" (list n)))))


(defun client (data)
  (let (((tuple 'ok socket) (gen_tcp:connect (tuple 127 0 0 1)
					     8080 (list 'binary))))
    (send socket data)
    (gen_tcp:close socket)))

(defun send
  ((socket (binary (h (size 100)) r))
   (gen_tcp:send socket h)
   (send socket r))
  ((socket r)
   (gen_tcp:send socket r)))
