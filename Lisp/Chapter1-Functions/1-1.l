; by xyzzy (Lisp Interaction mode)

; 1.1.1
(+ (* 3
      ( + (* 2 4)
	  (+ 3 5)))
   (+ (- 10 7)
      6))
57

; 1.1.2
(setq radius 10)
10

(* pi (* radius radius))
314.1592653589793d0

#|
defmacro define: Thx to
[Common Lisp “ü–å](http://www.geocities.jp/m_hiroi/xyzzy_lisp/abclisp08.html#chap16)
|#
(defmacro define ((name &rest args) &rest body)
  `(defun ,name ,args ,@body))
define

(setq circum (* 2 pi radius))
62.83185307179586d0

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
circumference

(circumference 10)
62.83185307179586d0

(define (sum-of-squares x y)
	(+ (square x) (square y)))
sum-of-squares

(sum-of-squares 3 4)
25

; 1.1.6
(define (>= x y) (not (< x y)))
>=
(define (<= x y) (not (> x y)))
<=

; ex.1.2
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
(define (average x y)
	(/ (+ x y) 2))
average

(define (improve guess x)
	(average guess (/ x guess)))
improve

(define (good-enough? guess x)
	(< (abs (- (square guess) x)) 0.001))
good-enough?

(define (sqrt-iter guess x)
	(if (good-enough? guess x)
	  guess
	  (sqrt-iter (improve guess x) x)))
sqrt-iter

(define (my-sqrt x)
	(sqrt-iter 1.0 x))
my-sqrt

(my-sqrt 2)
1.414216

(my-sqrt 9)
3.000092

(square (my-sqrt 1000))
1000.0

; ex.1.7
(my-sqrt 1/1000000)
0.03126065

(define (good-enough2? guess oldguess x)
	(< (abs (/ (- guess oldguess) guess)) 0.001))
good-enough2?

(define (sqrt-iter2 guess oldguess x)
	(if (good-enough2? guess oldguess x)
	  guess
	  (sqrt-iter2 (improve guess x) guess x)))
sqrt-iter2

(define (my-sqrt2 x)
	(sqrt-iter2 1.0 x x))
my-sqrt2

(my-sqrt2 1/1000000)
0.001

; ex.1.8
(define (improve-cube y x)
	;(prin1 y (format t " , "))
	(average y (/ (+
		       (/ x (* y y))
		       (* 2 y))
		      3)))
improve-cube

(define (good-enough3? guess oldguess x)
	(< (abs (/ (- guess oldguess) guess)) 0.001))
good-enough3?

(define (cube-iter guess oldguess x)
	(if (good-enough3? guess oldguess x)
	  guess
	  (cube-iter (improve-cube guess x) guess x)))
cube-iter

(define (my-cbrt x)
	(cube-iter 1.0 x x))
my-cbrt

(my-cbrt 8)
2.001525

(my-cbrt 1e-18)
1.000587e-6

; 1.1.8

