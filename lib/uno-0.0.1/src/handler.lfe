(defmodule handler
  (behavior gen_server)
  (export
   (start_link 0)
   (start_link 1)
   (init 1)
   (terminate 2)
   (handle_cast 2)
   (handle_call 3)
   (handle_info 2)))

(defmacro port ()
  8081)

(defun start_link ()
  (gen_server:start_link (tuple 'local 'handler) 'handler 'no_game_room_exists '()))

(defun start_link (args)
  (gen_server:start_link (tuple 'local 'handler) 'handler args '()))


(defun init (args)
  (tuple 'ok args))


(defun terminate (reason state)
  'ok)



(defun handle_cast

  ;;Starts Game
  ([(tuple player 'start)
    (tuple s _ _ p)]
   (case s
     ;;Game in Progress
     ('in_progress
      (gen_server:cast player 'already_started)
      (tuple 'noreply (tuple 'in_progress 'nil 'nil p)))
     ;;Game starts
     ('not_in_progress
      (let ((stack (uno:send_hands_to_player p)))
        (gen_server:cast player 'started)
	(lists:map (lambda (x) (gen_server:cast x (tuple (hd stack) 'next (hd p)))) p)
	(tuple 'noreply (tuple 'in_progress (tl stack) (list (hd stack)) p))))))
  
  ;;Connects
  ([(tuple player_pid 'connect 'null) 'no_game_room_exists]
   (gen_server:cast player_pid 'ok)
   (tuple 'noreply (tuple 'not_in_progress 'nil 'nil (list player_pid))))

  ;;Connects but player are waiting
  ([(tuple player_pid 'connect 'null) (tuple 'in_progress nachziehstapel ablagestapel players) ]
   (gen_server:cast player_pid 'game_in_progress)
   (tuple 'noreply (tuple 'in_progress nachziehstapel ablagestapel (cons player_pid players))))

  ;;Connects but game in progress
  ([(tuple player_pid 'connect 'null) (tuple 'not_in_progress 'nil 'nil players)]
   (gen_server:cast player_pid 'ok)
   (tuple 'noreply (tuple 'not_in_progress 'nil 'nil (cons player_pid players))))

  ;;Card is played
  ([(tuple player_pid 'put (tuple color type))
    (tuple 'in_progress nachziehstapel (cons (tuple cl tp)  t) (cons cur rest))]
   ;;Wrong Player?
   (if (=:= player_pid cur)
     ;;Card playable?
     (if (or
	  (=:= color cl)
	  (=:= type tp)
	  (and
	   (=:= cl 'c)
	   (=:= color tp)))
       ;;Right Player and Yes
       (progn
	 (gen_server:cast player_pid 'approved)
	 (let ((l (lists:append rest (list cur))))
	   (if (=:= type 60 )
	     (progn
	       (lists:map (lambda (p) (gen_server:cast p (tuple (tuple color type) 'next
								(hd (lists:reverse l)))))
			  l)
	       (tuple 'noreply (tuple 'in_progress nachziehstapel
				      (cons (tuple color type) (cons (tuple cl tp) t))
				      (lists:reverse l))))
	     (progn
	       ;(io:format "~p" (list l))
	       (lists:map (lambda (p) (gen_server:cast p (tuple (tuple color type) 'next
								(hd l))))
			  l)
	       (tuple 'noreply (tuple 'in_progress nachziehstapel
				      (cons (tuple color type) (cons (tuple cl tp) t)) l))))))
       ;;Right Player and No
       (progn
	 (gen_server:cast player_pid 'disapproved)
	 (tuple 'noreply (tuple 'in_progress nachziehstapel
				(cons (tuple cl tp) t)
				(cons cur rest)))))
     ;;Wrong Player
     (progn
       ;(io:format "shit~n" ())
       (lists:map (lambda (p) (gen_server:cast p (tuple (tuple cl tp) 'next cur))) (cons cur rest))
       (tuple 'noreply (tuple 'in_progress nachziehstapel (cons (tuple cl tp) t) (cons cur rest))))))

  ;;You are pulling cards
  ([(tuple player_pid 'pull) (tuple 'in_progress () (cons h t) (cons cur rest))]
   (handle_cast (tuple player_pid 'pull) (tuple 'in_progress (helper:shuffel t ()) (list h) (cons cur rest))))
  ([(tuple player_pid 'pull) (tuple 'in_progress (cons h t) ablagestapel (cons cur rest))]
    (if (=:= player_pid cur)
      (progn
	(gen_server:cast cur h)
	(tuple 'noreply (tuple 'in_progress t ablagestapel (cons cur rest))))
      (tuple 'noreply (tuple 'in_progress (cons h t) ablagestapel (cons cur rest)))))

  ;;Pass
  ([(tuple player_pid 'pass) (tuple 'in_progress nachziehstapel ablagestapel (cons cur rest))]
   (if (=:= player_pid cur)
     (progn
       (lists:map (lambda (x) (gen_server:cast x (tuple (hd ablagestapel) 'next (hd (lists:append rest cur))))) (cons cur rest))
       (tuple 'noreply (tuple 'in_progress nachziehstapel ablagestapel (lists:append rest (list cur)))))
     (tuple 'noreply (tuple 'in_progress nachziehstapel ablagestapel (cons cur rest)))))

  ([(tuple com name pid) (tuple 'in_progress n a p)]
   (lists:map (lambda (x) (gen_server:cast x (tuple com name pid))) p)
   (if (=:= com 'uno)
     (tuple 'noreply (tuple 'in_progress n a p))
     (tuple 'noreply 'no_game_room_exists)))

  (['terminate (tuple _ _ _ p)]
   (lists:map (lambda (x) (gen_server:cast x 'terminate)) p)
   (tuple 'noreply 'no_game_room_exists))

  (['terminate _]
   (tuple 'noreply 'no_game_room_exists)))
   


(defun handle_call (message from state)
  (tuple 'reply state state))

(defun handle_info
  ([_ state]
   (io:format "Got something else~n" '())
   (tuple 'stop 'unexpected_message state)))
	      

