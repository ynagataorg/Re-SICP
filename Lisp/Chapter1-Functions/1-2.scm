#lang racket/base

(define (square n) (* n n))
square

; 1.2.1
(define (factorial_ n)
  (if (<= n 1)
      1
      (* n (factorial_ (- n 1)))))
factorial_

(factorial_ 6)
720

(define (factorial n)
  (define (iter product counter)
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
(define (fib-ugry n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib-ugry (- n 1))
                 (fib-ugry (- n 2))))))
fib-ugry

(fib-ugry 10)
55

(define (fib n)
  (define (fib-iter a b counter)
    (if (= counter 0)
        b
        (fib-iter (+ a b) a (- counter 1))))
  (fib-iter 1 0 n))
fib

(fib 10)
55

(define (count-change amount)
  (define (cc amount kinds-of-coins)
    (cond ((= amount 0) 1)
          ((or (< amount 0) (= kinds-of-coins 0)) 0)
          (else (+ (cc amount (- kinds-of-coins 1))
                   (cc (- amount (first-denomination kinds-of-coins)) kinds-of-coins)))))
  (define (first-denomination kinds-of-coins)
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
(define (calc-fn-r n)
  (cond ((< n 3) n)
        (else (+ (* 1 (calc-fn-r (- n 1)))
                 (* 2 (calc-fn-r (- n 2)))
                 (* 3 (calc-fn-r (- n 3)))))))
calc-fn-r

(calc-fn-r 3)
4 ; 1*2 + 2*1 + 3*0
(calc-fn-r 4)
11 ; 1*4 + 2*3 + 3*1
(calc-fn-r 5)
25 ; 1*11 + 2*4 + 3*3

(define (calc-fn-i n)
  (define (calc-fn-iter p1 p2 p3 counter)
    (cond ((< counter 3) p1)
          (else (calc-fn-iter (+ (* 1 p1) (* 2 p2) (* 3 p3))
                              p1
                              p2
                              (- counter 1)))))
  (cond ((< n 3) n)
        (else (calc-fn-iter 2 1 0 n))))
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
(define (pascal m n)
  (cond ((= m 1) 1)
        ((= n 1) 1)
        ((= n m) 1)
        (else (+ (pascal (- m 1) (- n 1))
                 (pascal (- m 1) n)))))
pascal

(pascal 3 2)
2
(pascal 5 3)
6
(pascal 7 4)
20

; ex.1.15
(define (sine angle)
  (define (cube x) (* x x x))
  (define (p x)
    (begin
      (displayln x); output value of an argument x here.
      (- (* 3 x) (* 4 (cube x)))))
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3.0)))))
sine

(sine 12) ; apply p 5 times.
#|
0.04938271604938271
0.14766643898381945
0.4301196273428894
0.9720653790301994
-0.7578653335073415
|#
-0.5324462817995026

(sine 3.14) ; apply p 4 times.
#|
0.03876543209876543
0.11606327593091235
0.34193602092725733
0.8658910929629984
|#
0.0008056774674223277

(sine 1.57) ; apply p 3 times.
#|
0.05814814814814814
0.17365800071127369
0.5000259145195963
|#
0.9999999959705563

(sine 0) ; apply p 0 times.
0

; 1.2.4
(define (expt-r base n)
  (if (= n 0)
      1
      (* base (expt-r base (- n 1)))))
expt-r

(define (expt-i base n)
  (define (expt-iter base counter product)
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

(define (even? n) (= (remainder n 2) 0))
even?

(define (fast-expt-r base n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt-r base (/ n 2))))
        (else (* base (fast-expt-r base (- n 1))))))
fast-expt-r

(fast-expt-r 2 10)
1024

; ex.1.16
(define (fast-expt-i base n)
  (define (expt-iter base n result)
    (begin
      (printf "~A ~A ~A~%" base n result)
      (cond ((= n 0) result)
            ((even? n) (expt-iter (square base) (/ n 2) result))
            (else (expt-iter base (- n 1) (* base result))))))
  (expt-iter base n 1))
fast-expt-i

(fast-expt-i 2 3)
#|
2 3 1
2 2 2
4 1 2
4 0 8
|#
8

(fast-expt-i 2 10)
#|
2 10 1
4 5 1
4 4 4
16 2 4
256 1 4
256 0 1024
|#
1024

(fast-expt-i 2 100)
#|
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
|#
1267650600228229401496703205376

; ex.1.17
(define (mult-r a b)
  (if (= b 0)
      0
      (+ a (mult-r a (- b 1)))))
mult-r

(mult-r 7 143)
1001

(define (double n) (+ n n))
double

(define (halve n)
  (if (= (remainder n 2) 0)
      (/ n 2)
      0))
halve

(define (fast-mult-r a b)
  (cond ((= b 0) 0)
        ((even? b) (double (fast-mult-r a (/ b 2))))
        (else (+ a (fast-mult-r a (- b 1))))))
fast-mult-r

(fast-mult-r 7 143)
1001

; ex.1.18
(define (fast-mult-i a b)
  (define (mult-iter a b result)
    (begin
      (printf "~A ~A ~A~%" a b result)
      (cond ((= b 0) result)
            ((even? b) (mult-iter (double a) (/ b 2) result))
            (else (mult-iter a (- b 1) (+ a result))))))
  (mult-iter a b 0))
fast-mult-i

(fast-mult-i 7 143)
#|
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
|#
1001

; ex.1.19
(define (fib-fast n)
  (define (fib-iter a b p q counter)
    (cond ((= counter 0) b)
          ((even? counter)
           (fib-iter a
                     b
                     (+ (* p p) (* q q))
                     (+ (* 2 p q) (* q q))
                     (/ counter 2)))
          (else
           (fib-iter (+ (* b q) (* a q) (* a p))
                     (+ (* b p) (* a q))
                     p
                     q
                     (- counter 1)))))
  (fib-iter 1 0 0 1 n))
fib-fast

(fib-fast 10)
55

(fib-fast 100)
354224848179261915075

; 1.2.5
(define (gcd-impl a b)
  (begin
    (printf "(~A ~A) -> " a b)
    (if (= b 0)
        a
        (gcd-impl b (remainder a b)))))
gcd-impl

(gcd-impl 206 40)
; (206 40) -> (40 6) -> (6 4) -> (4 2) -> (2 0) -> 2
2

; 1.2.6
(define (smallest-divisor_ n)
  (define (divides? a b) (= (remainder b a) 0))
  (define (find-divisor n d)
    (cond ((> (* d d) n) n)
          ((divides? d n) d)
          (else (find-divisor n (+ d 1)))))
  (find-divisor n 2))
smallest-divisor_

(define (prime? n)
  (= n (smallest-divisor_ n)))
prime?

; ex.1.21
(map prime? '(199 1999 19999))
'(#t #t #f)

(smallest-divisor_ 19999)
7

; Carmichael numbers
(define carmichaels '(561 1105 1729 2465 2821 6601))
(map prime? carmichaels)
'(#f #f #f #f #f #f)

; Fermet Test
(define (expmod base e m)
  (cond ((= e 0) 1)
        ((even? e)
         (remainder
          (square (expmod base (/ e 2) m))
          m))
        (else
         (remainder
          (* base (expmod base (- e 1) m))
          m))))
expmod

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))
fermat-test

(define (fermat-prime? n times)
  (cond ((= times 0) #t)
        ((fermat-test n) (fermat-prime? n (- times 1)))
        (else #f)))
fermat-prime?

(map (lambda (n) (fermat-prime? n 10)) '(199 1999 19999))
'(#t #t #f)

(map (lambda (n) (fermat-prime? n 100)) carmichaels)
'(#t #t #t #t #t #t) ; forall a < n, expmod a n n = a (remainder n).

; ex.1.22
(define (search-for-primes start counter)
  (define (search-iter n discovered counter)
    (cond ((= discovered counter) #t)
          ((prime? n) (begin
                        (printf "~A is prime.~%" n)
                        (search-iter (+ n 1) (+ discovered 1) counter)))
          (else (search-iter (+ n 1) discovered counter))))
  (search-iter start 0 counter))
search-for-primes

(search-for-primes 1000 3)
#|
1009 is prime.
1013 is prime.
1019 is prime.
|#

(search-for-primes 10000 3)
#|
10007 is prime.
10009 is prime.
10037 is prime.
|#

(search-for-primes 100000 3)
#|
100003 is prime.
100019 is prime.
100043 is prime.
|#

(search-for-primes 1000000 3)
#|
1000003 is prime.
1000033 is prime.
1000037 is prime.
|#

; ex.1.23
(define (smallest-divisor n)
  (define (divides? a b) (= (remainder b a) 0))
  (define (next test-divisor)
    (if (= test-divisor 2) 3 (+ test-divisor 2)))
  (define (find-divisor n d)
    (cond ((> (* d d) n) n)
          ((divides? d n) d)
          (else (find-divisor n (next d)))))
  (find-divisor n 2))
smallest-divisor

(search-for-primes 10000 3)
#|
10007 is prime.
10009 is prime.
10037 is prime.
|#

(search-for-primes 100000 3)
#|
100003 is prime.
100019 is prime.
100043 is prime.
|#

(search-for-primes 1000000 3)
#|
1000003 is prime.
1000033 is prime.
1000037 is prime.
|#

; ex.1.27
(define (fermat-test-all n)
  (define (try-it a)
    (= (expmod a n n) a))
  (define (try-iter a)
    (cond ((= n 1) #f)
          ((= a n) #t)
          ((try-it a) (try-iter (+ a 1)))
          (else #f)))
  (try-iter 1))
fermat-test-all

(map (lambda (n) (fermat-test-all n)) '(1 2 3 5 7 9 11 13 15 17 19 21 23 25))
'(#f #t #t #t #t #f #t #t #f #t #t #f #t #f)

(fermat-test-all 100)
#f

(map (lambda (n) (fermat-test-all n)) carmichaels)
'(#t #t #t #t #t #t)

; ex.1.28 (Miller-Rabin test)
#|
thx to:
[Bill the Lizard: SICP Exercise 1.28: The Miller-Rabin test]
(http://www.billthelizard.com/2010/03/sicp-exercise-128-miller-rabin-test.html)
|#
(define (miller-rabin-test n)
  (define (square-with-check x m)
    (let ((mx (remainder (square x) m)))
      (cond ((= x 1) mx)
            ((= x (- m 1)) mx)
            ((= mx 1) 0)
            (else mx))))
  (define (expmod-with-check base e m)
    (cond ((= e 0) 1)
          ((even? e)
           (square-with-check (expmod-with-check base (/ e 2) m) m))
          (else
           (remainder
            (* base (expmod-with-check base (- e 1) m))
            m))))
  (define (try-it a)
    (= (expmod-with-check a n n) a))
  (try-it (+ 1 (random (- n 1)))))
miller-rabin-test

(define (fast-prime? n times)
  (cond ((= times 0) #t)
        ((miller-rabin-test n) (fast-prime? n (- times 1)))
        (else #f)))
fast-prime?

(map (lambda (n) (fast-prime? n 10)) '(199 1999 19999))
'(#t #t #f)

(map (lambda (n) (fast-prime? n 10)) carmichaels)
'(#f #f #f #f #f #f)
