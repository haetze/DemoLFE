;;example module for tcp
;;host is hardcoded in as local host
(defmodule tcp
    (export
     (server 1)
     (server 0) ;;uses standart port 8080
     (wait-connect 1)
     (wait-for-messages 1)
     ))

(defun server ()
  (server 8080))

(defun server (port)
  (let (((tuple 'ok socket) (gen_tcp:listen port (list 'binary))))
  (tuple 'ok (spawn 'tcp 'wait-connect (list socket)))))


(defun wait-connect (socket)
  (let (((tuple 'ok sock) (gen_tcp:accept socket)))
    (spawn 'tcp 'wait-connect (list socket))
    (wait-for-messages sock)))

;;messages received over utp are in the normal message box of
;;the process only in a tuple
(defun wait-for-messages (socket)
  (receive 
    ((tuple 'tcp _R bin)
     (gen_tcp:send socket bin)
     (gen_tcp:close socket))
    ((tuple 'tcp_closed _p)
     (io:format "connection closed~n" ()))
    (n
     (io:format "~p~n" (list n)))))

