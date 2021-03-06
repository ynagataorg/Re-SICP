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

; ex.2.36
(define ma (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

(accumulate-n + 0 ma)
'(22 26 30)

; ex.2.37
(define mb (list (list 1 2 3 4) (list 4 5 6 6) (list 6 7 8 9)))
(define (display-matrix m)
  (for-each (lambda (row)
              (display "(")
              (for-each (lambda (coeff)
                          (display coeff)
                          (display ",\t"))
                        row)
              (display ")")
              (newline))
            m))

(define i3 (list (list 1 0 0) (list 0 1 0) (list 0 0 1)))
(define i4 (list (list 1 0 0 0) (list 0 1 0 0) (list 0 0 1 0) (list 0 0 0 1)))
(define (dot-product v w)
  ; returns sigma_i v_i * w_i
  (accumulate + 0 (map * v w)))
(define (matrix-*-vector m v)
  ; returns t_i = sigma_j m_ij * v_j
  (map (lambda (w) (dot-product w v)) m))
(define (transpose mat)
  (accumulate-n cons '() mat))
(define (matrix-*-matrix m n)
  ; returns p_ij = sigma_k m_ik * n_kj
  (let ((n-cols (transpose n)))
    (map (lambda (m-row) (matrix-*-vector n-cols m-row)) m)))

(dot-product (car mb) (list 1 1 1 1))
10
(matrix-*-vector mb (list 1 1 1 1))
'(10 21 30)

(display-matrix ma)
#|
(1,	2,	3,	)
(4,	5,	6,	)
(7,	8,	9,	)
(10,	11,	12,	)
|#
(display-matrix (transpose ma))
#|
(1,	4,	7,	10,	)
(2,	5,	8,	11,	)
(3,	6,	9,	12,	)
|#
(display-matrix mb)
#|
(1,	2,	3,	4,	)
(4,	5,	6,	6,	)
(6,	7,	8,	9,	)
|#
(display-matrix (transpose mb))
#|
(1,	4,	6,	)
(2,	5,	7,	)
(3,	6,	8,	)
(4,	6,	9,	)
|#

(display-matrix (matrix-*-matrix i3 i3))
(display-matrix (matrix-*-matrix i4 i4))
(display-matrix (matrix-*-matrix ma i3))
(display-matrix (matrix-*-matrix i4 ma))

(display-matrix (matrix-*-matrix ma mb))
#|
(27,	33,	39,	43,	)
(60,	75,	90,	100,	)
(93,	117,	141,	157,	)
(126,	159,	192,	214,	)
|#

(display-matrix (matrix-*-matrix mb ma))
#|
(70,	80,	90,	)
(126,	147,	168,	)
(180,	210,	240,	)
|#

; ex.2.38.
(define fold-right accumulate)
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(fold-right / 1 (list 1 2 3))
; 1 1/2
(fold-left / 1 (list 1 2 3))
; 1/6
(fold-right list '() (list 1 2 3))
; '(1 (2 (3 ())))
(fold-left list '() (list 1 2 3))
; '(((() 1) 2) 3)
(fold-right + 0 (list 1 2 3 4))
(fold-left + 0 (list 1 2 3 4))
(fold-right * 1 (list 1 2 3 4))
(fold-left * 1 (list 1 2 3 4))
; fold-right = fold-left forall sequence
; when (= (op x y) (op y x)) forall x, y.

; ex.2.39.
(define (reverse-right sequence)
  (fold-right (lambda (x y) (append y (list x)))
              '() sequence))
(define (reverse-left sequence)
  (fold-left (lambda (x y) (cons y x))
             '() sequence))
(reverse-right (list 1 2 3))
(reverse-left (list 1 2 3))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(require "../prime.scm")
#|
(define (prime-sum-pairs n)
  (define (prime-sum? pair)
    (prime? (+ (car pair) (cadr pair))))
  (define (make-pair-sum pair)
    (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))
  (map make-pair-sum
       (filter prime-sum?
               (flatmap
                (lambda (i)
                  (map (lambda (j) (list i j))
                       (enumerate-interval 1 (- i 1))))
                (enumerate-interval 1 n)))))

(prime-sum-pairs 6)
'((2 1 3) (3 2 5) (4 1 5) (4 3 7) (5 2 7) (6 1 7) (6 5 11))
|#

(define (permutations seq)
  (define (remove item sequence)
    (filter (lambda (x) (not (= x item)))
            sequence))
  (if (null? seq)
      (list '())
      (flatmap (lambda (x)
                 (map (lambda (xs) (cons x xs))
                      (permutations (remove x seq))))
               seq)))

(permutations (list 1 2 3))
'((1 2 3) (1 3 2) (2 1 3) (2 3 1) (3 1 2) (3 2 1))

; ex.2.40.
(define (unique-pairs n)
  ; returns pair (i, j) (1 <= j < i <= n).
  (flatmap (lambda (i)
             (map (lambda (j) (list i j))
          (enumerate-interval 1 (- i 1))))
   (enumerate-interval 1 n)))
(map unique-pairs (enumerate-interval 1 5))
#|
'(()
  ((2 1))
  ((2 1) (3 1) (3 2))
  ((2 1) (3 1) (3 2) (4 1) (4 2) (4 3))
  ((2 1) (3 1) (3 2) (4 1) (4 2) (4 3) (5 1) (5 2) (5 3) (5 4)))
|#

(define (prime-sum-pairs n)
  (define (prime-sum? pair)
    (prime? (+ (car pair) (cadr pair))))
  (define (make-pair-sum pair)
    (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))
  (map make-pair-sum
       (filter prime-sum? (unique-pairs n))))
(prime-sum-pairs 6)

; ex.2.41.
(define (unique-triplets n)
  ; returns pair (i, j, k) (1 <= k < j < i <= n).
  (flatmap (lambda (i)
             (flatmap (lambda (j)
                        (map (lambda (k) (list i j k))
                             (enumerate-interval 1 (- j 1))))
                      (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))
(map unique-triplets (enumerate-interval 1 5))

(define (make-triplets-sum n s)
  ; returns pair (i, j, k) (1 <= k < j < i <= n, i + j + k = s).
  (filter (lambda (t) (= (+ (car t) (cadr t) (caddr t)) s))
          (unique-triplets n)))
(map (lambda (s) (make-triplets-sum 5 s)) (enumerate-interval 6 12))
(map (lambda (s) (make-triplets-sum 6 s)) (enumerate-interval 6 15))

; ex.2.42.
#|
Thx to:
* [Exercise 2.42 – SICP exercises]
  (https://wizardbook.wordpress.com/2010/12/03/exercise-2-42/)
* [エイト・クイーン - Wikipedia]
  (https://ja.wikipedia.org/wiki/%E3%82%A8%E3%82%A4%E3%83%88%E3%83%BB%E3%82%AF%E3%82%A4%E3%83%BC%E3%83%B3#n-.E3.82.AF.E3.82.A4.E3.83.BC.E3.83.B3)
|#
(define (queens board-size)
  (define empty-board '())
  (define (adjoin-position new-row k rest-of-queens)
    (cons new-row rest-of-queens))
  (define (safe-horizontal? k positions)
    ; (car position) is newly queen : on col-1.
    ; (cdr position) is other queens: on col-2, 3, ..., k.
    ; so safe-horitontal? = car-elem is not in cdr-elem.
    (not (member (car positions) (cdr positions))))
  (define (safe-diagonal? k positions)
    ; for example, (safe-diagonal? 3 '(2 3 1)) implies
    ; (a) newly queen is 2
    ; (b) length of position is k=3;
    ; (c) (cdr '(2 3 1)) is safe.
    (define (safe-diagonal-iter newly older col)
      (cond ((null? older)
             ;(display k)
             ;(display positions)
             ;(newline)
             #t)
            ((= (abs (- newly (car older)))
                (abs (- 1 col))) #f)
            (else (safe-diagonal-iter
                   newly (cdr older) (+ col 1)))))
    (safe-diagonal-iter (car positions) (cdr positions) 2))
  (define (safe? k positions)
    (and (safe-horizontal? k positions)
         (safe-diagonal? k positions)))
  (define (queen-cols k)
    ; returns all paterns of first k-columns.
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position
                    new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(queens 1)

(queens 2)

(queens 3)

(queens 4)

(queens 5)

(queens 6)

(= (length (queens 6)) 4)
(= (length (queens 7)) 40)
(= (length (queens 8)) 92)

; On my computer with DrRacket:
; (queens 12) required about 30 sec, memory <= 256MB.
; (queens 13) required about 2+ min, memory <= 2048MB.
; (queens 14) cannot eval.
