(defmodule read_write_service
  (behavior gen_server)
  (export
   (init 1)
   (start_link 1)
   (terminate 2)
   (handle_cast 2)
   (handle_call 3)))

(defun init (name)
  (let (((tuple 'ok name) (dets:open_file name
					  (list (tuple 'file
						       (atom_to_list name))
						(tuple 'type 'bag)))))
    (tuple 'ok name)))

(defun start_link (name)
  (gen_server:start_link (tuple 'local name)
			 'read_write_service
			 name
			 ()))

(defun terminate (_reason table)
  (dets:close table))

(defun handle_cast
  (('stop table)
   (tuple 'stop 'normal table))
  (((tuple 'write data) table)
   (dets:insert table data)
   (tuple 'noreply table)))

(defun handle_call
  (((tuple 'read key) _from table)
   (tuple 'reply (dets:lookup table key) table))
  (((tuple 'delete key) _from table)
   (tuple 'reply (dets:delete table key) table)))

