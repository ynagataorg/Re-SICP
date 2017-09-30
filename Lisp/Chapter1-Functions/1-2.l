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

; ex.1.15
(defun sine (angle)
  (defun cube (x) (* x x x))
  (defun p (x)
    (progn
      (prin1 x) (format t "~%") ; output value of an argument x here.
      (- (* 3 x) (* 4 (cube x)))))
  (if (not (> (abs angle) 0.1))
    angle
    (p (sine (/ angle 3.0)))))
sine

(sine 12) ; apply p 6 times.
0.04938272
0.1476664
0.4301196
0.9720653
-0.757865
-0.5324477

(sine 3.14) ; apply p 5 times.
0.03876543
0.1160633
0.3419361
0.8658911
8.056164e-4

(sine 1.57) ; apply p 4 times.
0.05814815
0.173658
0.5000259
0.9999999

(sine 0) ; apply p 1 times.
0

; 1.2.4
(defun expt-r (base n)
  (if (= n 0)
    1
    (* base (expt-r base (- n 1)))))
expt-r

(defun expt-i (base n)
  (defun expt-iter (base counter product)
    (if (= counter 0)
      product
      (expt-iter base
		 (- counter 1)
		 (* base product))))
  (expt-iter base n 1))
expt-i

(expt-r 2 10)
1024

(expt-i 2 10)
1024

(defun even? (n) (= (mod n 2) 0))
even?

(defun fast-expt-r (base n)
  (cond ((= n 0) 1)
	((even? n) (square (fast-expt-r base (/ n 2))))
	(t (* base (fast-expt-r base (- n 1))))))
fast-expt-r

(fast-expt-r 2 10)
1024

; ex.1.16
(defun fast-expt-i (base n)
  (defun expt-iter (base n result)
    (progn
      (format t "~A ~A ~A~%" base n result)
      (cond ((= n 0) result)
	    ((even? n) (expt-iter (square base) (/ n 2) result))
	    (t (expt-iter base (- n 1) (* base result))))))
  (expt-iter base n 1))
fast-expt-i

(fast-expt-i 2 3)
2 3 1
2 2 2
4 1 2
4 0 8
8

(fast-expt-i 2 10)
2 10 1
4 5 1
4 4 4
16 2 4
256 1 4
256 0 1024
1024

(fast-expt-i 2 100)
2 100 1
4 50 1
16 25 1
16 24 16
256 12 16
65536 6 16
4294967296 3 16
4294967296 2 68719476736
18446744073709551616 1 68719476736
18446744073709551616 0 1267650600228229401496703205376
1267650600228229401496703205376

(fast-expt-i 2 1000)
2 1000 1
4 500 1
16 250 1
256 125 1
256 124 256
65536 62 256
4294967296 31 256
4294967296 30 1099511627776
18446744073709551616 15 1099511627776
18446744073709551616 14 20282409603651670423947251286016
340282366920938463463374607431768211456 7 20282409603651670423947251286016
340282366920938463463374607431768211456 6 6901746346790563787434755862277025452451108972170386555162524223799296
115792089237316195423570985008687907853269984665640564039457584007913129639936 3 6901746346790563787434755862277025452451108972170386555162524223799296
115792089237316195423570985008687907853269984665640564039457584007913129639936 2 799167628880894011233688890827050574271641124522232614619944181664095165137859998750798362384253944616915694367080095461234681773897801038410285056
13407807929942597099574024998205846127479365820592393377723561443721764030073546976801874298166903427690031858186486050853753882811946569946433649006084096 1 799167628880894011233688890827050574271641124522232614619944181664095165137859998750798362384253944616915694367080095461234681773897801038410285056
13407807929942597099574024998205846127479365820592393377723561443721764030073546976801874298166903427690031858186486050853753882811946569946433649006084096 0 10715086071862673209484250490600018105614048117055336074437503883703510511249361224931983788156958581275946729175531468251871452856923140435984577574698574803934567774824230985421074605062371141877954182153046474983581941267398767559165543946077062914571196477686542167660429831652624386837205668069376
10715086071862673209484250490600018105614048117055336074437503883703510511249361224931983788156958581275946729175531468251871452856923140435984577574698574803934567774824230985421074605062371141877954182153046474983581941267398767559165543946077062914571196477686542167660429831652624386837205668069376

; ex.1.17
(defun mult-r (a b)
  (if (= b 0)
    0
    (+ a (mult-r a (- b 1)))))
mult-r

(mult-r 7 143)
1001

(defun double (n) (+ n n))
double

(defun halve (n)
  (if (= (mod n 2) 0)
    (/ n 2)
    0))
halve

(defun fast-mult-r (a b)
  (cond ((= b 0) 0)
	((even? b) (double (fast-mult-r a (/ b 2))))
	(t (+ a (fast-mult-r a (- b 1))))))
fast-mult-r

(fast-mult-r 7 143)
1001

; ex.1.18
(defun fast-mult-i (a b)
  (defun mult-iter (a b result)
    (progn
      (format t "~A ~A ~A~%" a b result)
      (cond ((= b 0) result)
            ((even? b) (mult-iter (double a) (/ b 2) result))
	    (t (mult-iter a (- b 1) (+ a result))))))
  (mult-iter a b 0))
fast-mult-i

(fast-mult-i 7 143)
7 143 0
7 142 7
14 71 7
14 70 21
28 35 21
28 34 49
56 17 49
56 16 105
112 8 105
224 4 105
448 2 105
896 1 105
896 0 1001
1001

