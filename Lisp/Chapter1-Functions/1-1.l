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

(setq circum (* 2 pi radius))
62.83185307179586d0

; 1.1.4
(defun square (x) (* x x))
square

(square 21)
441
(square (+ 2 5))
49
(square (square 3))
81

(defun circumference (radius)
  (* 2 pi radius))
circumference

(circumference 10)
62.83185307179586d0

(defun sum-of-squares (x y)
  (+ (square x) (square y)))
sum-of-squares

(sum-of-squares 3 4)
25

; 1.1.6
(defun >= (x y) (not (< x y)))
>=
(defun <= (x y) (not (> x y)))
<=

; ex.1.2
(/ (+ 5 4 (- 2
	     (- 3
		(+ 6 (/ 4 5)))))
   (* 3 (- 6 2) (- 2 7)))
-37/150

; ex.1.3
(defun sum-of-three-squares (x y z)
  (+ (square x) (square y) (square z)))
sum-of-three-squares

(sum-of-three-squares 3 4 5)
50

(defun sum-of-squares-from-three-of-two (x y z)
  (- (sum-of-three-squares x y z)
     (square (min x y z))))
sum-of-squares-from-three-of-two

(sum-of-squares-from-three-of-two 5 6 7)
85

; 1.1.7
(defun average (x y) (/ (+ x y) 2))
average

(defun improve__ (guess x)
  (average guess (/ x guess)))
improve__

(defun good-enough?__ (guess x)
  (< (abs (- (square guess) x)) 0.001))
good-enough?

(defun sqrt-iter__ (guess x)
  (if (good-enough?_ guess x)
      guess
    (sqrt-iter__ (improve__ guess x) x)))
sqrt-iter__

(defun my-sqrt__ (x)
  (sqrt-iter__ 1.0 x))
my-sqrt__

(my-sqrt__ 2)
1.414216

(my-sqrt__ 9)
3.000092

(square (my-sqrt__ 1000))
1000.0

; ex.1.7
(my-sqrt__ 1/1000000)
0.03126065

(defun good-enough?_ (guess oldguess x)
  (< (abs (/ (- guess oldguess) guess)) 0.001))
good-enough?_

(defun sqrt-iter_ (guess oldguess x)
  (if (good-enough?_ guess oldguess x)
      guess
    (sqrt-iter_ (improve__ guess x) guess x)))
sqrt-iter_

(defun my-sqrt_ (x)
  (sqrt-iter_ 1.0 x x))
my-sqrt_

(my-sqrt_ 1/1000000)
0.001

; ex.1.8
(defun improve-cube (y x)
  (average y (/ (+
		 (/ x (* y y))
		 (* 2 y))
		3)))
improve-cube

(defun good-enough? (guess oldguess x)
  (< (abs (/ (- guess oldguess) guess)) 0.001))
good-enough?

(defun cube-iter (guess oldguess x)
  (if (good-enough3? guess oldguess x)
      guess
    (cube-iter (improve-cube guess x) guess x)))
cube-iter

(defun my-cbrt_ (x)
  (cube-iter 1.0 x x))
my-cbrt_

(my-cbrt_ 8)
2.001525

(my-cbrt_ 1e-18)
1.000587e-6

; 1.1.8
(defun my-sqrt (x)
  (defun good-enough? (guess oldguess)
    (< (abs (/ (- guess oldguess) guess)) 0.001))
  (defun improve (guess x)
    (average guess (/ x guess)))
  (defun sqrt-iter (guess oldguess x)
    (if (good-enough? guess oldguess)
      guess
      (sqrt-iter (improve guess x) guess x)))
  (sqrt-iter 1.0 x x))
my-sqrt

(my-sqrt 1e-18)
1.0e-9

(defun my-cbrt (x)
  (defun good-enough? (guess oldguess)
    (< (abs (/ (- guess oldguess) guess)) 0.001))
  (defun improve (guess x)
    (average guess (/ (+
		       (/ x (* guess guess))
		       (* 2 guess))
		      3)))
  (defun cbrt-iter (guess oldguess x)
    (if (good-enough? guess oldguess)
      guess
      (cbrt-iter (improve guess x) guess x)))
  (cbrt-iter 1.0 x x))
my-cbrt

(my-cbrt 8)
2.001525

(my-cbrt 1e-18)
1.000587e-6
