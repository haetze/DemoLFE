;Richard Stewing
(defmodule create_boot
  (export
   (create 1)))


(defun create (name)
  (systools:make_script (hd name) (list 'local)))