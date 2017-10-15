#lang racket/base

; utils
(define (square a) (* a a))

(define (cube a) (* a a a))

(define (iota count (start 0) (step 1))
  (if (= count 0)
      '()
      (cons start (iota (- count 1) (+ start step) step))))

; 1.3.1
(define (sum-integers_ a b)
  (if (> a b)
      0
      (+ a (sum-integers_ (+ a 1) b))))
sum-integers_

(define (sum-cubes_ a b)
  (if (> a b)
      0
      (+ (cube a) (sum-cubes_ (+ a 1) b))))
sum-cubes_

(define (pi-sum_ a b)
  (if (> a b)
      0
      (+ (/ 1.0 (* a (+ a 2)))
         (pi-sum_ (+ a 4) b))))
pi-sum_

(map (lambda (b) (* 8 (pi-sum_ 1 b))) (iota 10 3 4))
#|
'(2.6666666666666665
  2.895238095238095
  2.976046176046176
  3.017071817071817
  3.041839618929402
  3.0584027659273314
  3.0702546177791836
  3.079153394197426
  3.086079801123833
  3.0916238066678385)
|#

(map (lambda (b) (* 8 (pi-sum_ 1 b))) (iota 10 1003 4))
#|
'(3.139600623693464
  3.1396085285584143
  3.1396163709344975
  3.139624151559768
  3.139631871160703
  3.1396395304524294
  3.1396471301389424
  3.1396546709133233
  3.13966215345795
  3.1396695784447006)
|#

(map (lambda (b) (* 8 (pi-sum_ 1 b))) (iota 10 10003 4))
#|
'(3.1413927335598038
  3.1413928134638907
  3.141392893304131
  3.1413929730806016
  3.141393052793378
  3.141393132442537
  3.1413932120281545
  3.1413932915503064
  3.1413933710090696
  3.141393450404518)
|#

(define (sum-r function a next b)
  (if (> a b)
      0
      (+ (function a)
         (sum-r function (next a) next b))))
sum-r

(define (inc n) (+ n 1))
inc

(define (sum-cubes-r a b)
  (sum-r cube a inc b))
sum-cubes-r

(sum-cubes-r 1 10)
3025

(define (id n) n)
id

(define (sum-integers a b)
  (sum-r id a inc b))

(sum-integers 1 10)
55

(define (pi-sum a b)
  (define (function x)
    (/ 1.0 (* x (+ x 2))))
  (define (next x) (+ x 4))
  (sum-r function a next b))
pi-sum

(* 8 (pi-sum 1 1000))
3.139592655589783

(map (lambda (to) (* 8 (pi-sum 1 to)))
     (map (lambda (e) (expt 10 e)) (iota 5 1)))
#|
'(2.976046176046176
  3.1215946525910105
  3.139592655589783
  3.141392653591793
  3.141572653589795)

(map (lambda (to) (* 8 (pi-sum 1 to)))
     (map (lambda (e) (expt 10 e)) (iota 7 1)))
'(2.976046176046176
  3.1215946525910105
  3.139592655589783
  3.141392653591793
  3.141572653589795
  3.141590653589793
  3.141592453589793)
|#

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* dx (sum-r f (+ a (/ dx 2.0)) add-dx b)))
integral

(integral cube 0 1 0.01)
0.24998750000000042

(integral cube 0 1 0.001)
0.249999875000001

(map (lambda (dx) (integral cube 0 1 dx))
     (map (lambda (e) (expt 10 e)) (iota 5 -1 -1)))
#|
'(0.24874999999999994
  0.24998750000000042
  0.249999875000001
  0.24999999874993412
  0.24999999998662864)
|#

; ex. 1.30
(define (sum function a next b)
  (define (sum-iter a result)
    (if (> a b)
        result
        (sum-iter (next a) (+ result (function a)))))
  (sum-iter a 0))
sum

(define (sum-cubes a b)
  (sum cube a inc b))
sum-cubes

(sum-cubes 1 10)
3025

; ex. 1.29
(define (simpson f a b n)
  (define h (/ (- b a) n))
  (define (y k)
    (f (+ a (* k h))))
  (define (term k)
    (*
     (cond ((or (= k 0) (= k n)) 1)
           ((even? k) 2)
           (else 4))
     (y k)))
  (* (sum term 0 inc n)
     (/ h 3)))
simpson

(map (lambda (n) (simpson cube 0 1 n)) (iota 10 2 2))
'(1/4 1/4 1/4 1/4 1/4 1/4 1/4 1/4 1/4 1/4)

; ex.1.31-a (product-r)
(define (product-r function a next b)
  (if (> a b)
      1
      (* (function a)
         (product-r function (next a) next b))))
product-r

(define (factorial-with-product-r n)
  (product-r id 1 inc n))
factorial-with-product-r

(factorial-with-product-r 10)
3628800

(define (john-wallis-method upper)
  (define (john-d-function n)
    (/ (* (* 2 n) (* 2 (+ n 1)))
       (* (+ (* 2 n) 1) (+ (* 2 n) 1))))
  (product-r john-d-function 1 inc upper))
john-wallis-method

(* 4 (john-wallis-method 1))
3 5/9

(map (lambda (upper) (* 4.0 (john-wallis-method upper)))
     (map (lambda (e) (expt 2 e)) (iota 8 3)))
#|
'(3.2300364664117174
  3.18812716944714
  3.1654820600347966
  3.1536988490958002
  3.1476868995564256
  3.144650162517214
  3.143124017028195
  3.1423589891217865)
|#

; ex.1.31-b (product)
(define (product function a next b)
  (define (product-iter a result)
    (if (> a b)
        result
        (product-iter (next a) (* result (function a)))))
  (product-iter a 1))
product

(define (factorial-with-product-i n)
  (product id 1 inc n))
factorial-with-product-i

(factorial-with-product-i 10)
3628800

; ex.1.32-a (accumulate-r)
(define (accumulate-r combiner null-value function a next b)
  (if (> a b)
      null-value
      (combiner (function a)
                (accumulate-r combiner null-value function (next a) next b))))
accumulate-r

(define (sum-with-accumulate-r function a next b)
  (accumulate-r + 0 function a next b))
sum-with-accumulate-r

(sum-with-accumulate-r id 0 inc 10)
55

(define (product-with-accumulate-r function a next b)
  (accumulate-r * 1 function a next b))
product-with-accumulate-r

(define (factorial-with-accumulate-r n)
  (product-with-accumulate-r id 1 inc n))
factorial-with-accumulate-r

(factorial-with-accumulate-r 10)
3628800

; ex.1.32-b (accumulate)
(define (accumulate combiner null-value function a next b)
  (define (acc a result)
    (if (> a b)
        result
        (acc (next a) (combiner result (function a)))))
  (acc a null-value))
accumulate

(define (sum-with-accumulate-i function a next b)
  (accumulate + 0 function a next b))
sum-with-accumulate-i

(sum-with-accumulate-i id 0 inc 10)
55

(define (product-with-accumulate-i function a next b)
  (accumulate * 1 function a next b))
product-with-accumulate-i

(define (factorial-with-accumulate-i n)
  (product-with-accumulate-i id 1 inc n))
factorial-with-accumulate-i

(factorial-with-accumulate-i 10)
3628800

; ex.1.33 (filtered-accumulate)

; 1.3.2

