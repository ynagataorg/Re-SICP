#lang racket/base

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
(define (same-parity head . tail)
  (define (parity x) (remainder x 2))
  (define (iter things answer)
    (if (null? things)
        (reverse answer)
        (if (= (parity (car things)) (parity head))
            (iter (cdr things) (cons (car things) answer))
            (iter (cdr things) answer))))
  (cons head (iter tail '())))
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

; ex.2.23
(define (foreach action items)
  (if (null? items)
      #t
      (and (action (car items))
           (foreach action (cdr items)))))
(foreach (lambda (x)
           (display x)
           (newline))
         (list 57 321 88))
