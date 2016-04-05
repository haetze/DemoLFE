(defmodule udp
    (export
     (start 1) ;;starts the receive loop
     (start 3))) ;;opens a port, sends the given message, waits 1000
                 ;;milliseconds for a respond

;;opens port and starts the receive loop
(defun start (port)
  (let (((tuple 'ok s) (gen_udp:open port)))
    (receive-loop s)))

;;receive loop
;;listens for the socket
(defun receive-loop (s)
  (receive
   ;;handles the closing message
   ((tuple 'udp from-socket host from-port "close")
    (gen_udp:send s host from-port "closed messages received~")
    (gen_udp:close s))
   ;;handles the standart pattern
   ((tuple 'udp from-socket host from-port msg)
    (gen_udp:send s host from-port (listLib:append "got the message: "
						   msg))
    (receive-loop s))
   ;;everything that is not a udp message
   (n
    (io:format "got something else~n" ())
    (receive-loop s)))
  (io:format "handled message~n" ()))


;;sends a message to port to
;;and waits for the respond 1000 milliseconds
(defun start (port1 port2 msg)
  ;;port is opend
  (let (((tuple 'ok s) (gen_udp:open port1)))
    (gen_udp:send s (tuple 127 0 0 1) port2 msg)
    (receive
     (n
      ;;prints the message (a tuple )
      (io:format "~p~n" (list n)))
     (after 1000
	    (io:format "no message received~n" ())))
    (gen_udp:close s))) ;; socket gets closed again
