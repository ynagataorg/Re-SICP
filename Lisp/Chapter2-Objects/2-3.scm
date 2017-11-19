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

