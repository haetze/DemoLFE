(defmodule read_write
  (behavior application)
  (export
   (start 2)
   (stop 1)
   (create 1)
   (read 2)
   (write 2)
   (terminate 1)
   (delete 2)))

(defun start (_type startArgs)
  (read_write_sup:start_link))

(defun stop (_state)
  'ok)


(defun create (name)
  (gen_server:call 'read_write_gen (tuple 'create name)))

(defun read (name key)
  (gen_server:call name (tuple 'read key)))

(defun write (name data)
  (gen_server:cast name (tuple 'write data)))

(defun delete (name key)
  (gen_server:call name (tuple 'delete key)))

(defun terminate (name)
  (gen_server:cast name 'stop))