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

; 2.2.2
(define x (cons (list 1 2) (list 3 4)))
;> x
;'((1 2) 3 4)

(define (count-leaves tree)
  (cond ((null? tree) 0)
        ((not (pair? tree)) 1)
        (else (+ (count-leaves (car tree))
                 (count-leaves (cdr tree))))))

(length x) ; 3
(count-leaves x) ; 4
(length (list x x)) ; 2
(count-leaves (list x x)) ; 8

; ex.2.25
(car (cdr (car (cdr (cdr '(1 3 (5 7) 9))))))
(car (car '((7))))
(car (cdr ; removing 6
  (car (cdr ; removing 5
    (car (cdr ; removing 4
      (car (cdr ; removing 3
        (car (cdr ; removing 2
          (car (cdr '(1 (2 (3 (4 (5 (6 7))))))))))))))))))

; ex.2.26
(define ex26x (list 1 2 3))
(define ex26y (list 4 5 6))
(append ex26x ex26y)
'(1 2 3 4 5 6)
(cons ex26x ex26y)
'((1 2 3) 4 5 6)
(list ex26x ex26y)
'((1 2 3) (4 5 6))

; ex.2.27
(define y (list (list 1 2) (list 3 4)))
#|
(define (reverse items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (car things) answer))))
  (iter items '()))
|#
(define (deep-reverse items)
  (cond ((null? items) '())
        ((not (pair? items)) items)
        (else (append (deep-reverse (cdr items))
                      (list (deep-reverse (car items)))))))
(reverse y)
(deep-reverse x)
(deep-reverse y)

; ex.2.28
(define (fringe tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (list tree))
        (else (append (fringe (car tree))
                      (fringe (cdr tree))))))
(fringe x)
(fringe y)
(fringe (list x x))

; ex.2.29
(define (make-mobile_ left right)
  (list left right))
(define (make-branch_ length structure)
  (list length structure))

; (a).
(define (left-branch mobile)
  (car mobile))
(define (right-branch_ mobile)
  (car (cdr mobile)))
(define (branch-length branch)
  (car branch))
(define (branch-structure_ branch)
  (car (cdr branch)))
(define (mobile? mobile)
  (pair? mobile))

; changes in (d).
(define (make-mobile left right) (cons left right))
(define (make-branch length structure)
  (cons length structure))
(define (right-branch mobile)
  (cdr mobile))
(define (branch-structure branch)
  (cdr branch))

(define m1
  (make-mobile (make-branch 3 2)
               (make-branch 2 3)))
(define m2
  (make-mobile (make-branch 3
                            (make-mobile (make-branch 1 0.5)
                                         (make-branch 1 0.5)))
               (make-branch 2
                            (make-mobile (make-branch 1 1)
                                         (make-branch 2 0.5)))))
(define m3
  (make-mobile (make-branch 2 2)
               (make-branch 3 3)))

; (b).
(define (total-weight mobile)
  (if (not (mobile? mobile))
      mobile
      (+ (total-weight (branch-structure (left-branch mobile)))
         (total-weight (branch-structure (right-branch mobile))))))
(total-weight m1) ; 5
(total-weight m2) ; 2.5

; (c).
(define (balanced? mobile)
  (if (not (mobile? mobile))
      #t
      (let ((lbranch (left-branch mobile))
            (rbranch (right-branch mobile))
            (lmobile (branch-structure (left-branch mobile)))
            (rmobile (branch-structure (right-branch mobile))))
        (and (= (* (branch-length lbranch)
                   (total-weight lmobile))
                (* (branch-length rbranch)
                   (total-weight rmobile)))
             (balanced? lmobile)
             (balanced? rmobile)))))
(balanced? m1) ; #t
(balanced? m2) ; #t
(balanced? m3) ; #f

(define t (list 1 (list 2 (list 3 4) 5) (list 6 7)))
(define (scale-tree tree factor)
  (cond ((null? tree) '())
        ((not (pair? tree)) (* tree factor))
        (else (cons (scale-tree (car tree) factor)
                    (scale-tree (cdr tree) factor)))))
(scale-tree t 10)

(define (scale-tree2 tree factor)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (scale-tree2 sub-tree factor)
             (* sub-tree factor)))
       tree))
(scale-tree2 t 10)

; ex.2.30
(define (square-tree tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (square tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))))))
(square-tree t)

(define (square-tree2 tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree2 sub-tree)
             (square sub-tree)))
       tree))
(square-tree2 t)

; ex.2.31
(define (tree-map f tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (tree-map f sub-tree)
             (f sub-tree)))
       tree))

(define (scale-tree3 tree factor)
  (tree-map (lambda (x) (* x factor)) tree))
(define (square-tree3 tree) (tree-map square tree))
(scale-tree3 t 10)
(square-tree3 t)

; ex.2.32
(define (subsets s)
  (if (null? s)
      (list '())
      (let ((rest (subsets (cdr s))))
        ; append "without (car s)" and "with (car s)".
        (append rest
                (map (lambda (x)
                       (cons (car s) x))
                     rest)))))

(subsets '())
(subsets '(1))
(subsets '(1 2))
(subsets '(1 2 3))

; 2.2.3
(define (fib n)
  (define (fib-iter a b counter)
    (if (= counter 0)
        b
        (fib-iter (+ a b) a (- counter 1))))
  (fib-iter 1 0 n))

(define (filter predicate sequence)
  (cond ((null? sequence) '())
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))

(define (enumerate-tree tree)
  (fringe tree))

(define (sum-odd-squares tree)
  (accumulate + 0
              (map square (filter odd? (enumerate-tree tree)))))

(define (even-fibs n)
  (accumulate cons '()
              (filter even? (map fib (enumerate-interval 0 n)))))

; t is '(1 (2 (3 4) 5) (6 7)).
(sum-odd-squares t)
84 ; returns 1 + 9 + 25 + 49 = 84.

(even-fibs 10)
'(0 2 8 34)

(define (list-fib-squares n)
  (accumulate cons '()
              (map square (map fib (enumerate-interval 0 n)))))
(list-fib-squares 10)
'(0 1 1 4 9 25 64 169 441 1156 3025)

(define (product-of-squares-of-odd-elements sequence)
  (accumulate * 1
              (map square (filter odd? sequence))))
(product-of-squares-of-odd-elements (enumerate-interval 1 5))
225

; ex.2.33.
(define (acc-map p sequence)
  (accumulate (lambda (x y) (cons (p x) y))
              '() sequence))
(acc-map square (enumerate-interval 1 5))

(define (acc-append seq1 seq2)
  (accumulate cons seq2 seq1))
(acc-append (list 1 2 3) (list 4 5 6))

(define (acc-length sequence)
  (accumulate (lambda (x y) (+ y 1))
              0 sequence))
(acc-length (enumerate-interval 1 5))

; ex.2.34.
(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms) (+ this-coeff (* higher-terms x)))
              0 coefficient-sequence))

(horner-eval 2 (list 1 3 0 5 0 1))
79 ; returns 1 + 3*2 + 0*4 + 5*8 + 0*16 + 1*32 = 1 + 6 + 40 + 32 = 79.

; ex.2.35.
(define (acc-count-leaves t)
  (accumulate + 0
              (map (lambda x 1) (enumerate-tree t))))
(acc-count-leaves t)
7
