
(defmodule uno
  (behavior application)
  (export
   (start 2)
   (stop 1)
   (send_hands_to_player 1)
   (stack 0)))

(defun start (type args)
  (let ((ret (uno_supervisor:start_link)))
    (supervisor:start_child 'uno_supervisor (list 'server))
    (supervisor:start_child 'uno_supervisor (list 'handler))
    ret))

(defun stop (state)
  'ok)


(defun send_hands_to_player (player) (send_hands_to_player player (stack)))

(defun send_hands_to_player
  ([() stack]
   stack)
  ([(cons p ps) (cons n1 (cons n2 (cons n3 (cons n4 (cons n5 (cons n6 (cons n7 stack)))))))]
   (gen_server:cast p n1)
   (gen_server:cast p n2)
   (gen_server:cast p n3)
   (gen_server:cast p n4)
   (gen_server:cast p n5)
   (gen_server:cast p n6)
   (gen_server:cast p n7)
   (send_hands_to_player ps stack)))


(defun stack ()
  (let* ((s (list-comp ((<- c (list 'r 'b 'y 'g)) (<- n (list 1 2 3 4 5 6 7 8 9 0 43 60))) (tuple c n)))
	 (st (lists:append (lists:merge s s) (list (tuple 'c 42)
					       (tuple 'c 42)
					       (tuple 'c 42)
					       (tuple 'c 42)
					       (tuple 'c 42)
					       (tuple 'c 42)
					       (tuple 'c 42)
					       (tuple 'c 42)))))
    (helper:shuffel st ())))



