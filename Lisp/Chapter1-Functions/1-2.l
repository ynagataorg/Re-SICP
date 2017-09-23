; 1.2.1
(defun factorial_ (n)
  (if (<= n 1)
    1
    (* n (factorial_ (- n 1)))))
factorial_

(factorial_ 6)
720

(defun factorial (n)
  (defun iter (product counter)
    (if (> counter n)
      product
      (iter (* counter product)
	    (+ counter 1))))
  (if (<= n 1)
    1
    (iter 1 1)))
factorial

(factorial 6)
720

; 1.2.2
(defun fib-ugry (n)
  (cond ((= n 0) 0)
	((= n 1) 1)
	(t (+ (fib-ugry (- n 1))
	      (fib-ugry (- n 2))))))
fib-ugry

(fib-ugry 10)
55

(defun fib (n)
  (defun fib-iter (a b counter)
    (if (= counter 0)
      b
      (fib-iter (+ a b) a (- counter 1))))
  (fib-iter 1 0 n))
fib

(fib 10)
55

(defun count-change (amount)
  (defun cc (amount kinds-of-coins)
    (cond ((= amount 0) 1)
	  ((or (< amount 0) (= kinds-of-coins 0)) 0)
	  (t (+ (cc amount (- kinds-of-coins 1))
		(cc (- amount (first-denomination kinds-of-coins)) kinds-of-coins)))))
  (defun first-denomination (kinds-of-coins)
    (cond ((= kinds-of-coins 1) 1)
	  ((= kinds-of-coins 2) 5)
	  ((= kinds-of-coins 3) 10)
	  ((= kinds-of-coins 4) 25)
	  ((= kinds-of-coins 5) 50)))
  (cc amount 5))
count-change

(count-change 100)
292

; ex.1.11
(defun calc-fn-r (n)
  (cond ((< n 3) n)
	(t (+ (* 1 (calc-fn-r (- n 1)))
	      (* 2 (calc-fn-r (- n 2)))
	      (* 3 (calc-fn-r (- n 3)))))))
calc-fn-r

(calc-fn-r 3)
4 ; 1*2 + 2*1 + 3*0
(calc-fn-r 4)
11 ; 1*4 + 2*3 + 3*1
(calc-fn-r 5)
25 ; 1*11 + 2*4 + 3*3

(defun calc-fn-i (n)
  (defun calc-fn-iter (p1 p2 p3 counter)
    (cond ((< counter 3) p1)
	  (t (calc-fn-iter (+ (* 1 p1) (* 2 p2) (* 3 p3))
			   p1
			   p2
			   (- counter 1)))))
  (cond ((< n 3) n)
	(t (calc-fn-iter 2 1 0 n))))
calc-fn-i

(calc-fn-i 0)
0
(calc-fn-i 1)
1
(calc-fn-i 2)
2
(calc-fn-i 3)
4
(calc-fn-i 4)
11
(calc-fn-i 5)
25

; ex.1.12
(defun pascal (m n)
  (cond ((= m 1) 1)
	((= n 1) 1)
	((= n m) 1)
	(t (+ (pascal (- m 1) (- n 1))
	      (pascal (- m 1) n)))))
pascal

(pascal 3 2)
2
(pascal 5 3)
6
(pascal 7 4)
20

