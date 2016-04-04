(defmodule udp
    (export
     (start 1)

     ))

(defun start (port)
  (let (((tuple 'ok s) (gen_udp:open port)))
    (receive
     ((tuple 'udp from-socket host from-port msg)
      (gen_udp:send s host from-port "got the message"))
     (n
      (io:format "got something else~n" ())))
    (io:format "handled message~n" ())
    (gen_udp:close s)))

(defun start (port1 port2)
  (let (((tuple 'ok s) (gen_udp:open port))
	(pid (spawn 'udp 'start (list port2))))
    (gen_udp:send s (tuple 127 0 0 1) port2 "Hallo")
    (receive
     (n
      (io:format "~p~n" (list n))))
    (gen_udp:close s)))
