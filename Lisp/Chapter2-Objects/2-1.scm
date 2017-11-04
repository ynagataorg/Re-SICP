#lang racket/base

; 2.1.1 Example: Arithmetic Operations for Rational Numbers

(define (minus x) (* -1 x))

(define (make-rat n d)
  (let ((g (gcd n d)))
    (if (> d 0)
        (cons (/ n g) (/ d g))
        (cons (/ (minus n) g) (/ (minus d) g)))))
(define (numer x) (car x))
(define (denom x) (cdr x))

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))
(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))
(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))
(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))
(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

(define (print-rat x)
  (display (numer x))
  (display "/")
  (display (denom x))
  (newline))

(define one-half (make-rat 1 2))
(print-rat one-half)
(define one-third (make-rat 1 3))
(print-rat one-third)

(print-rat (add-rat one-half one-third))
(print-rat (mul-rat one-half one-third))
(print-rat (add-rat one-third one-third))

(print-rat (make-rat -1 2))
(print-rat (make-rat 1 -2))
(print-rat (sub-rat (make-rat 1 2) (make-rat 5 6)))

; ex.2.2
(define (make-segment ps pe) (cons ps pe))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))

(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (print-point p)
  (display "(")
  (display (x-point p))
  (display ", ")
  (display (y-point p))
  (display ")")
  (newline))

(define (midpoint-segment s)
  (let ((sp (start-segment s))
        (ep (end-segment s)))
  (define (average x y) (/ (+ x y) 2))
  (make-point (average (x-point sp) (x-point ep))
              (average (y-point sp) (y-point ep)))))
midpoint-segment

(define p1 (make-point -2 1))
(define p2 (make-point 4 3))
(define pm (midpoint-segment (make-segment p1 p2)))
(print-point p1)
(print-point p2)
(print-point pm)

; ex.2.3
(define (make-rectangle1 p width height)
  (cons p (cons width height)))
(define (height-rect1 rect) (cdr (cdr rect)))
(define (width-rect1 rect) (car (cdr rect)))

(define (calc-circum1 rect)
  (* 2 (+ (height-rect1 rect) (width-rect1 rect))))
(define (calc-area1 rect)
  (* (height-rect1 rect) (width-rect1 rect)))

(define r1 (make-rectangle1 pm 3 1))
(calc-circum1 r1)
8
(calc-area1 r1)
3

(define (make-rectangle2 left-bottom right-top)
  (cons left-bottom right-top))
(define (height-rect2 rect)
  (abs (- (y-point (car rect))
          (y-point (cdr rect)))))
(define (width-rect2 rect)
  (abs (- (x-point (car rect))
          (x-point (cdr rect)))))

(define (calc-circum2 rect)
  (* 2 (+ (height-rect2 rect) (width-rect2 rect))))
(define (calc-area2 rect)
  (* (height-rect2 rect) (width-rect2 rect)))

(define r2 (make-rectangle2 pm p2))
(calc-circum2 r2)
8
(calc-area2 r2)
3
