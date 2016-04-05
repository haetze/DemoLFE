(defmodule udp
    (export
     (start 1)
     (start 3)))

(defun start (port)
  (let (((tuple 'ok s) (gen_udp:open port)))
    (receive-loop s)))

(defun receive-loop (s)
  (receive
   ((tuple 'udp from-socket host from-port "close")
    (gen_udp:send s host from-port "closed messages received~")
    (gen_udp:close s))
   ((tuple 'udp from-socket host from-port msg)
    (gen_udp:send s host from-port (listLib:append "got the message: "
						   msg))
    (receive-loop s))
   (n
    (io:format "got something else~n" ())
    (receive-loop s)))
  (io:format "handled message~n" ()))

(defun start (port1 port2 msg)
  (let (((tuple 'ok s) (gen_udp:open port1)))
    (gen_udp:send s (tuple 127 0 0 1) port2 msg)
    (receive
     (n
      (io:format "~p~n" (list n)))
     (after 1000
	    (io:format "no message received~n" ())))
    (gen_udp:close s)))
