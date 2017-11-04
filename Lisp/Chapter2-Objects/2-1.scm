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

; 2.1.3
(define (consX x y)
  (define (dispatch m)
    (cond ((= m 0) x)
          ((= m 1) y)
          (else (error "Argument not 0 or 1: CONS" m))))
  dispatch)
(define (carX z) (z 0))
(define (cdrX z) (z 1))

(carX (consX 3 4)) ; 3
(cdrX (consX 3 4)) ; 4

; ex.2.4
(define (consY x y)
  (lambda (m) (m x y)))
(define (carY z)
  (z (lambda (p q) p)))
(define (cdrY z)
  (z (lambda (p q) q)))

(carY (consY 3 4)) ; 3
(cdrY (consY 3 4)) ; 4

; ex.2.5
(define (divides? a b) (= 0 (remainder b a)))
(define (count-divisions n divisor)
  (define (iter x count)
    (if (divides? divisor x)
        (iter (/ x divisor) (+ count 1))
        count))
  (iter n 0))

(define (consZ a b)
  (* (expt 2 a) (expt 3 b)))
(define (carZ z)
  (count-divisions z 2))
(define (cdrZ z)
  (count-divisions z 3))

(carZ (consZ 3 4)) ; 3
(cdrZ (consZ 3 4)) ; 4

; ex.2.6
; Thx to ja:Wikipedia ラムダ計算 and
; [おとうさん、ぼくにもYコンビネータがわかりましたよ！ - きしだのはてな]
; (http://d.hatena.ne.jp/nowokay/20090409#1239268405)
(define zero
  ; λfx.x
  (lambda (f) (lambda (x) x)))
(define (succ n)
  ; λnfx.f(nfx)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define (toint n)
  ((n (lambda (x) (+ x 1))) 0))
(toint zero) ; 0
(toint (succ zero)) ; 1

(define one
  ; λfx.f(x)
  (lambda (f) (lambda (x) (f x))))
(toint one) ; 1
(define two
  ; λfx.f(f(x))
  (lambda (f) (lambda (x) (f (f x)))))
(toint two) ; 2

(define (plus m n)
  ; λmnfx.mf(nfx)
  (lambda (f) (lambda (x) ((m f) ((n f) x)))))
(toint (plus one two)) ; 3 = 1 + 2
(toint (plus two (plus one two))) ; 5 = 2 + (1 + 2)

; 2.2.1
(define squares (list 1 4 9 16 25))
(define odds (list 1 3 5 7))

(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))
(list-ref squares 3)
16

(define (length-r items)
  (if (null? items)
      0
      (+ 1 (length-r (cdr items)))))
(length-r odds)
4

(define (length-i items)
  (define (iter a count)
    (if (null? a)
        count
        (iter (cdr a) (+ 1 count))))
  (iter items 0))
(length-i odds)
4

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1)
            (append (cdr list1) list2))))
(append squares odds)
(append odds squares)

; ex.2.17
(define (last-pair items)
  (let ((pair (cdr items)))
    (if (null? pair)
        items
        (last-pair pair))))
(last-pair squares)
(last-pair odds)

; ex.2.18
(define (reverse items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (car things) answer))))
  (iter items '()))
(reverse squares)

; ex.2.19
(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(define (cc amount coin-values)
  (define (no-more? items) (null? items))
  (define (first-denomination items) (car items))
  (define (except-first-denomination items) (cdr items))
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination
                 coin-values))
            (cc (- amount
                   (first-denomination
                    coin-values))
                coin-values)))))

(cc 100 us-coins)
292
;(cc 100 uk-coins)
;104561

; ex.2.20
(define (same-parity x . items)
  (define (parity x) (remainder x 2))
  (define (iter things answer)
    (if (null? things)
        (reverse answer)
        (if (= (parity (car things)) (parity x))
            (iter (cdr things) (cons (car things) answer))
            (iter (cdr things) answer))))
  (cons x (iter items '())))
(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)

(define (scale-list items factor)
  (map (lambda (x) (* x factor))
       items))
(scale-list (list 1 2 3 4 5) 10)

(map (lambda (x y) (+ x (* 2 y)))
     (list 1 2 3)
     (list 4 5 6))
'(9 12 15)

; ex.2.21
(define (square x) (* x x))
(define (square-list-raw items)
  (if (null? items)
      '()
      (cons (square (car items))
            (square-list-raw (cdr items)))))
(square-list-raw (list 1 2 3 4))

(define (square-list items)
  (map (lambda (x) (square x)) items))
(square-list (list 1 2 3 4))

; ex.2.22
(define (square-list-iter1 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items '()))
(square-list-iter1 (list 1 2 3 4))
; '(16 9 4 1)

(define (square-list-iter2 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items '()))
(square-list-iter2 (list 1 2 3 4))
; '((((() . 1) . 4) . 9) . 16)

(define (square-list-iter items)
  (define (iter things answer)
    (if (null? things)
        (reverse answer)
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items '()))
(square-list-iter (list 1 2 3 4))
; '(1 4 9 16)
