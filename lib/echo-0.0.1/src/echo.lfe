(defmodule echo
  (behavoir application)
  (export
   (start 2)
   (stop 1)
   (stop 0)
   (call 1)
   (cast 1)))



(defun start (_type start-args)
  (echo_sup:start_link))

(defun stop (_state)
  'ok)

(defun call (n)
  (gen_server:call 'echo n))

(defun cast (n)
  (gen_server:cast 'echo n))


(defun stop ()
  (cast 'stop))