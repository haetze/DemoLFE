(defmodule echo_gen_server
  (behavior gen_server)
  (export all))

(defun init (i)
  (tuple
   'ok
   i))

(defun handle_cast (mes state)
  (tuple
   'noreply
   state))


(defun handle_call (mes caller state)
  (tuple
   'reply
   mes
   state))

(defun terminate (_reason _state)
  'ok)

(defun handle_info
  (((tuple pid mes) i)
   (! pid mes)
   (tuple
    'noreply
    i))
  ((_ i)
   (tuple
    'noreply
    i)))


(defun start ()
  (gen_server:start
   (tuple 'local 'echo)
   'test
   0
   '()))

(defun call (mes)
  (gen_server:call 'echo mes))

(defun cast (mes)
  (gen_server:cast 'echo mes))

(defun info (mes)
  (! 'echo (tuple (self) mes)))
