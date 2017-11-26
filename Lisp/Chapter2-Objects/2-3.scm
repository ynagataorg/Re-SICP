#lang racket/base

(car '(a b c))
(cdr '(a b c))

(define (memq item items)
  (cond ((null? items) #f)
        ((eq? item (car items)) items)
        (else (memq item (cdr items)))))
(memq 'apple '(pear banana prune))
(memq 'apple '(x (apple sauce) y apple pear))

; ex.2.54
(define (equal? items1 items2)
  (cond ((and (null? items1) (null? items2)) #t)
        ((or (null? items1) (null? items2)) #f)
        ((not (eq? (car items1) (car items2))) #f)
        (else (equal? (cdr items1) (cdr items2)))))

(equal? '(this is a list) '(this is a list))
(equal? '(this is a list) '(this (is a) list))

; 2.3.2
(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))
(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))

(define (make-exponent base exponent)
  (cond ((=number? exponent 0) 1)
        ((=number? exponent 1) base)
        ((and (number? base) (number? exponent)) (expt base exponent))
        (else (list '** base exponent))))

(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))
(define (addend s) (cadr s))
(define (augend s) (caddr s))
(define (product? x)
  (and (pair? x) (eq? (car x) '*)))
(define (multiplier p) (cadr p))
(define (multiplicand p) (caddr p))
(define (exponent? x)
  (and (pair? x) (eq? (car x) '**)))
(define (base e) (cadr e))
(define (exponent e) (caddr e))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        ((sum? exp) (make-sum (deriv (addend exp) var)
                              (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        ((exponent? exp)
         (make-product
          (make-product (exponent exp)
                        (make-exponent (base exp)
                                       (- (exponent exp) 1)))
          (deriv (base exp) var)))
        (else
         (error "unsupported expression type: DERIV" exp))))

(deriv '(+ x 3) 'x)
1
(deriv '(* x y) 'x)
'y
(deriv '(* x y) 'y)
'x
(deriv '(* (* x y) (+ x 3)) 'x)
'(+ (* x y) (* y (+ x 3)))

(deriv '(** x 0) 'x) ; x**0 d/dx = 1 d/dx = 0
(deriv '(** x 1) 'x) ; x**1 d/dx = x d/dx = 1
(deriv '(** x 2) 'x) ; x**2 d/dx = 2 * x**(2-1) * 1
(deriv '(** x 3) 'x) ; x**3 d/dx = 3 * x**(3-1) * 1

(deriv '(** (+ x 2) 3) 'x) ; (x+2)**3 d/dx = 3 * (x+2)**2 * 1
'(* 3 (** (+ x 2) 2))
(deriv '(** (+ (* x y) 1) 3) 'x) ; (xy+1)**3 d/dx = 3 * (xy+1)**2 * y
'(* (* 3 (** (+ (* x y) 1) 2)) y)
