(defmodule fib
    (export
     (fib 1)
     (factorial 1)
     (con-fib 2)
     (start 1)
     (seq 4)
     (fib-with-seq 1)))


;;basic sequence function
;;takes the number n of the position of the
;;number you are looking for (n)
;;the two first numbers of the seq
;;and a function that takes the last two numbers and returns
;;the next number
(defun seq
  ((0 a b f)
   a)
  ((n a b f)
   (seq (- n 1) b (funcall f a b) f)))


(defun fib-with-seq (n)
  (seq n 0 1 (lambda (a b) (+ a b))))

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
;;This fails with 27
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
