(defmodule distributed
  (export
   (send 2)))


(defun send (pid message)
  (io:format "process spawned,sending message ~p to process ~p ~n"
	     (list pid message))
  (! pid message))