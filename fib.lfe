(defmodule fib
    (export
     (fib 1)
     (factorial 1)
     (con-fib 2)
     (start 1)))


(defun fib
  ((0 a b)
   a)
  ((n a b)
   (fib (- n 1) b (+ a b))))

(defun fib (n)
  (fib n 0 1))

(defun factorial
  ((0)
   1)
  ((n)
   (* n (factorial (- n 1)))))



;;the concurrent version works but only for small numbers
;;because the standart erlang vm has a max number of process and
;;the number of spawned process for each number n is 2^n + 1.
;;The default number of processes is 262144.
;;2 ^ 30 + 1 is 1073741825 which is alot bigger.
;;NOTE: The maximum number you can configure is 134217727, which is still
;;to small for the the 30th fib number.
;;The algorythm still reduces the whole number to 1/0 and addition.
;;The algorythm above is better, it has no problem with the 100th fib
;;number.
(defun con-fib
  ((0 p)
   (! p (tuple 'result 0)))
  ((1 p)
   (! p (tuple 'result 1)))
  ((n p)
   (let ((pid1 (spawn_link 'fib 'con-fib (list (- n 1) (self))))
	 (pid2 (spawn_link 'fib 'con-fib (list (- n 2) (self)))))
     (receive
      ((tuple 'result n)
       (receive
	((tuple 'result m)
	 (! p (tuple 'result (+ n m))))))))))


(defun start (n)
  (spawn_link 'fib 'con-fib (list n (self)))
  (process_flag 'trap_exit 'true)
  (receive
   ((tuple 'result m)
    (io:format "~p~n" (list m))
    (receive
     ((tuple 'EXIT pid2 'normal))
     (n
      (io:format "something happend after you got the result ~p~n"
		 (list n)))))
   ((tuple 'EXIT pid2 reason)
    (io:format "The calculation failed because ~p"
	       (list reason)))))
