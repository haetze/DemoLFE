(defmodule awk
  (export all))


(defun test (file-name)
  (let* (((tuple 'ok f) (file:open file-name (list 'read))))
    (lists:filter (lambda (x) (/= x ())) (for-lines f))))

(defun for-lines (f)
  (let ((next-line (file:read_line f)))
    (if (=:= next-line 'eof) ()
	(cons (for-line next-line)
	      (for-lines f)))))

(defun for-line
  (((tuple 'ok line))
   (let (((tuple 'ok (tuple _ q))  (lfe_io:read_string (lists:append (list "#( " line ")")))))
     (if (< q 10)
       ()
       line))))

