#lang racket/base

; 1.1.1
(+ (* 3
      ( + (* 2 4)
          (+ 3 5)))
   (+ (- 10 7)
      6))
57

; 1.1.2
(define radius 10)
radius

(define pi 3.14159)
pi

(* pi (* radius radius))
314.159

(define circum (* 2 pi radius))
62.8318

; 1.1.4
(define (square x) (* x x))
square

(square 21)
441
(square (+ 2 5))
49
(square (square 3))
81

(define (circumference radius)
  (* 2 pi radius))

(circumference 10)
62.8318

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(sum-of-squares 3 4)
25

; 1.1.6
(define (>= x y) (not (< x y)))
>=

(define (<= x y) (not (> x y)))
<=

; ex.1.2
(/ 5 2)
2 1/2

(/ (+ 5 4 (- 2
             (- 3
                (+ 6 (/ 4 5)))))
   (* 3 (- 6 2) (- 2 7)))
-37/150

; ex.1.3
(define (sum-of-three-squares x y z)
  (+ (square x) (square y) (square z)))
sum-of-three-squares

(sum-of-three-squares 3 4 5)
50

(define (sum-of-squares-from-three-of-two x y z)
  (- (sum-of-three-squares x y z)
     (square (min x y z))))
sum-of-squares-from-three-of-two

(sum-of-squares-from-three-of-two 5 6 7)
85

; 1.1.7
(define (average x y) (/ (+ x y) 2))
average

(define (improve__ guess x)
  (average guess (/ x guess)))
improve__

(define (good-enough?__ guess x)
  (< (abs (- (square guess) x)) 0.001))
good-enough?__

(define (sqrt-iter__ guess x)
  (if (good-enough?__ guess x)
      guess
      (sqrt-iter__ (improve__ guess x) x)))
sqrt-iter__

(define (my-sqrt__ x)
  (sqrt-iter__ 1.0 x))
my-sqrt__

(my-sqrt__ 2)
1.4142156862745097

(my-sqrt__ 9)
3.00009155413138

(square (my-sqrt__ 1000))
1000.000369924366

; ex.1.7
(my-sqrt__ 1/1000000)
0.031260655525445276

(define (good-enough?_ guess oldguess x)
  (< (abs (/ (- guess oldguess) guess)) 0.001))
good-enough?_

(define (sqrt-iter_ guess oldguess x)
  (if (good-enough?_ guess oldguess x)
      guess
      (sqrt-iter_ (improve__ guess x) guess x)))
sqrt-iter_

(define (my-sqrt_ x)
  (sqrt-iter_ 1.0 x x))
my-sqrt_

(my-sqrt_ 1/1000000)
0.0010000001533016628

; ex.1.8
(define (improve-cube y x)
  (average y (/ (+
                 (/ x (* y y))
                 (* 2 y))
                3)))
improve-cube

(define (good-enough? guess oldguess x)
  (< (abs (/ (- guess oldguess) guess)) 0.001))
good-enough?

(define (cube-iter guess oldguess x)
  (if (good-enough? guess oldguess x)
      guess
      (cube-iter (improve-cube guess x) guess x)))
cube-iter

(define (my-cbrt_ x)
  (cube-iter 1.0 x x))
my-cbrt_

(my-cbrt_ 8)
2.001525315150488

(my-cbrt_ 1e-18)
1.0005872910315646e-006

; 1.1.8
(define (my-sqrt x)
  (define (good-enough? guess oldguess)
    (< (abs (/ (- guess oldguess) guess)) 0.001))
  (define (improve guess x)
    (average guess (/ x guess)))
  (define (sqrt-iter guess oldguess x)
    (if (good-enough? guess oldguess)
        guess
        (sqrt-iter (improve guess x) guess x)))
  (sqrt-iter 1.0 x x))
my-sqrt

(my-sqrt 1e-18)
1.0000000691683832e-009

(define (my-cbrt x)
  (define (good-enough? guess oldguess)
    (< (abs (/ (- guess oldguess) guess)) 0.001))
  (define (improve guess x)
    (average guess (/ (+
                       (/ x (* guess guess))
                       (* 2 guess))
                      3)))
  (define (cbrt-iter guess oldguess x)
    (if (good-enough? guess oldguess)
        guess
        (cbrt-iter (improve guess x) guess x)))
  (cbrt-iter 1.0 x x))
my-cbrt

(my-cbrt 8)
2.001525315150488

(my-cbrt 1e-18)
1.0005872910315646e-006
