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
    (gen_udp:close s)))

