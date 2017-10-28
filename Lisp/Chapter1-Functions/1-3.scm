#lang racket/base

; utils
(define (square a) (* a a))

(define (cube a) (* a a a))

(define (average a b) (/ (+ a b) 2))

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

(define (pi-sum__ a b)
  (if (> a b)
      0
      (+ (/ 1.0 (* a (+ a 2)))
         (pi-sum__ (+ a 4) b))))
pi-sum__

(map (lambda (b) (* 8 (pi-sum__ 1 b))) (iota 10 3 4))
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

(map (lambda (b) (* 8 (pi-sum__ 1 b))) (iota 10 1003 4))
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

(map (lambda (b) (* 8 (pi-sum__ 1 b))) (iota 10 10003 4))
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

(define (pi-sum_ a b)
  (define (function x)
    (/ 1.0 (* x (+ x 2))))
  (define (next x) (+ x 4))
  (sum-r function a next b))
pi-sum_

(* 8 (pi-sum_ 1 1000))
3.139592655589783

(map (lambda (to) (* 8 (pi-sum_ 1 to)))
     (map (lambda (e) (expt 10 e)) (iota 5 1)))
#|
'(2.976046176046176
  3.1215946525910105
  3.139592655589783
  3.141392653591793
  3.141572653589795)

(map (lambda (to) (* 8 (pi-sum_ 1 to)))
     (map (lambda (e) (expt 10 e)) (iota 7 1)))
'(2.976046176046176
  3.1215946525910105
  3.139592655589783
  3.141392653591793
  3.141572653589795
  3.141590653589793
  3.141592453589793)
|#

(define (integral_ f a b dx)
  (define (add-dx x) (+ x dx))
  (* dx (sum-r f (+ a (/ dx 2.0)) add-dx b)))
integral_

(integral_ cube 0 1 0.01)
0.24998750000000042

(integral_ cube 0 1 0.001)
0.249999875000001

(map (lambda (dx) (integral_ cube 0 1 dx))
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
(define (miller-rabin-test n)
  (define (square-with-check x m)
    (let ((mx (remainder (square x) m)))
      (cond ((= x 1) mx)
            ((= x (- m 1)) mx)
            ((= mx 1) 0)
            (else mx))))
  (define (expmod-with-check base e m)
    (cond ((= e 0) 1)
          ((even? e)
           (square-with-check (expmod-with-check base (/ e 2) m) m))
          (else
           (remainder
            (* base (expmod-with-check base (- e 1) m))
            m))))
  (define (try-it a)
    (= (expmod-with-check a n n) a))
  (try-it (+ 1 (random (- n 1)))))
miller-rabin-test

(define (prime? n (times 10))
  (cond ((< n 2) #f)
        ((= times 0) #t)
        ((miller-rabin-test n) (prime? n (- times 1)))
        (else #f)))
prime?

(define (gcd-impl a b)
  (if (= b 0)
        a
        (gcd-impl b (remainder a b))))
gcd-impl

(define (filtered-accumulate combiner null-value function a next b predicate)
  (define (acc a result)
    (if (> a b)
        result
        (acc (next a)
             (combiner result
                       (if (predicate a) (function a) null-value)))))
  (acc a null-value))
filtered-accumulate

(define (ex-1-33-a a b)
  (filtered-accumulate + 0 square a inc b prime?))

(= (ex-1-33-a 1 10) (+ (* 2 2) (* 3 3) (* 5 5) (* 7 7)))
#t

(= (ex-1-33-a 11 20) (+ (* 11 11) (* 13 13) (* 17 17) (* 19 19)))
#t

(define (ex-1-33-b n)
  (filtered-accumulate * 1 id 1 inc n
                       (lambda (i) (= (gcd-impl i n) 1))))

(= (ex-1-33-b 8) (* 3 5 7))
#t

; 1.3.2
(define (pi-sum a b)
  (sum (lambda (x) (/ 1.0 (* x (+ x 2))))
       a
       (lambda (x) (+ x 4))
       b))
pi-sum

(* 8 (pi-sum 1 1000))
3.139592655589782

(define (integral f a b dx)
  (* (sum f
          (+ a (/ dx 2.0))
          (lambda (x) (+ x dx))
          b)
     dx))
integral

(integral cube 0 1 0.001)
0.24999987500000073

(integral cube 0 1 0.0001)
0.24999999874993337

((lambda (x y z) (+ x y (square z)))
 1 2 3)
(+ 1 2 (* 3 3))

; f(x,y) = x(1+xy)^2 + y(1-y) + (1+xy)(1-y)
; a = 1+xy, b = 1-y, f(x,y) = xa^2 + yb + ab
(define (sec1-3-2-1 x y)
  (let ((a (+ 1 (* x y)))
        (b (- 1 y)))
    (+ (* x (square a))
       (* y b)
       (* a b))))
sec1-3-2-1

; ex.1.34
(define (f g) (g 2))
(f square)
4
(f (lambda (z) (* z (+ z 1))))
6

#|
> (f f)
application: not a procedure;
 expected a procedure that can be applied to arguments
  given: 2
  arguments...: 2

(f f) -> (f 2) -> (2 2)
> (2 2)
application: not a procedure;
 expected a procedure that can be applied to arguments
  given: 2
  arguments...: 2
|#

; 1.3.3
;f(a) < 0 < f(b) => exists x, a < x < b, f(x) = 0.
(define (search f neg-point pos-point)
  (define (close-enough? x y)
    (< (abs (- x y)) 0.001))
  (let ((mid-point (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
        mid-point
        (let ((test-value (f mid-point)))
          (cond ((positive? test-value)
                 (search f neg-point mid-point))
                ((negative? test-value)
                 (search f mid-point pos-point))
                (else mid-point))))))
(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond ((and (negative? a-value) (positive? b-value))
           (search f a b))
          ((and (negative? b-value) (positive? a-value))
           (search f b a))
          (else
           (error "Values are not of opposite sign" a b)))))
half-interval-method

(half-interval-method sin 2.0 4.0)
3.14111328125

(half-interval-method (lambda (x) (- (* x x) 2))
                      1.0
                      2.0)
1.41455078125

(define (fixed-point f first-guess)
  (define tolerance 1e-6)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))
fixed-point

(fixed-point cos 1.0)
0.7390855263619245

(fixed-point (lambda (y) (+ (sin y) (cos y)))
             1.0)
1.2587277968014188

; sqrt(x) = y => y^2 = x => y = x / y
; so sqrt(x) is fixed-point of function: y = x / y
(define (sqrt-fixed x)
  (fixed-point (lambda (y) (average y (/ x y)))
               1.0))
sqrt-fixed

(sqrt-fixed 2)
1.414213562373095

; ex.1.35
; phi^2 = phi + 1 => phi = 1 + 1 / phi
; so phi is fixed-point of function: phi = 1 + 1 / phi
(define phi-fixed
  (fixed-point (lambda (x) (average x (+ 1 (/ 1 x))))
               1.0))

phi-fixed
1.6180337185494662

(- (square phi-fixed) (+ phi-fixed 1))
-6.04186452868305e-007

; ex.1.36
(define (fixed-point-with-display f first-guess)
  (define tolerance 1e-6)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (display guess)
    (newline)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))
fixed-point-with-display

(fixed-point-with-display
 (lambda (x) (average x (+ 1 (/ 1 x))))
 1.0)
#|
1.0
1.5
1.5833333333333333
1.6074561403508771
1.6147785476652068
1.61702925556443
1.617723628348796
1.6179380934832117
1.6180043565683029
1.6180248320058461
1.6180311591702674
1.618033114362648
|#
1.6180337185494662

(fixed-point-with-display
 (lambda (x) (/ (log 1000) (log x)))
 10)
4.555535421530586 ; by 39 steps

(fixed-point-with-display
 (lambda (x) (average x (/ (log 1000) (log x))))
 10)
#|
10
6.5
5.095215099176933
4.668760681281611
4.57585730576714
4.559030116711325
4.55613168520593
4.555637206157649
4.55555298754564
4.555538647701617
4.555536206185039
|#
4.555535790493355 ; by 11 steps

; ex.1.37-a (continued-fraction: recurive process)
; bug fixed. thx to [sicp-ex-1.37](http://community.schemewiki.org/?sicp-ex-1.37).
(define (cont-frac n d k)
  (define (iter i)
    (if (> i k)
        0
        (/ (n i)
           (+ (d i) (iter (+ i 1))))))
  (iter 1))
cont-frac

(define (phi-by-cont-frac k)
  (/ 1
     (cont-frac (lambda (i) 1.0)
                (lambda (i) 1.0)
                k)))

; phi is 1.6180339887... (by Wikipedia)
(map phi-by-cont-frac (iota 25 1))
#|
'(1.0
  2.0
  1.5
  1.6666666666666665
  1.6
  1.625
  1.6153846153846154 <- here, 2 decimal: k= 7.
  1.619047619047619
  1.6176470588235294
  1.6181818181818184 <- here, 3 decimal: k=10.
  1.6179775280898876
  1.6180555555555558 <- here, 4 decimal: k=12.
  1.6180257510729614
  1.6180371352785146 <- here, 5 decimal: k=14.
  1.6180327868852458
  1.618034447821682
  1.618033813400125  <- here, 6 decimal: k=17.
  1.6180340557275543
  1.6180339631667064 <- here, 7 decimal: k=19.
  1.6180339985218037
  1.6180339850173577 <- here, 8 decimal: k=21.
  1.6180339901755971
  1.6180339882053252 <- here, 9 decimal: k=23.
  1.6180339889579018
  1.6180339886704433)
|#

(define (cont-frac-iterative n d k)
  (define (iter k result)
    (if (= k 0)
        result
        (iter (- k 1)
              (/ (n k)
                 (+ (d k) result)))))
  (iter k 0))
cont-frac-iterative

(/ 1
   (cont-frac-iterative (lambda (i) 1.0)
                        (lambda (i) 1.0)
                        12))
1.6180555555555558

; ex.1.38
(define (napier-by-cont-frac which k)
  (define (euler-d i)
    (if (= (remainder i 3) 2)
        (* 2 (/ (+ i 1) 3))
        1))
  (+ 2
     (which (lambda (i) 1.0)
            euler-d
            k)))
napier-by-cont-frac

(map (lambda (k) (napier-by-cont-frac cont-frac k)) (iota 5 10))
(map (lambda (k) (napier-by-cont-frac cont-frac-iterative k)) (iota 5 10))
;'(2.7182817182817183 2.7182818352059925 2.7182818229439496 2.718281828735696 2.7182818284454013)

; ex.1.39
(define (tan-cf x k)
  (define (lambert-minus-xtanx)
    (cont-frac-iterative (lambda (i) (* -1 x x))
                         (lambda (i) (- (* 2 i) 1))
                         k))
  (if (= x 0)
      0
      (* -1 (/ (lambert-minus-xtanx) x))))
tan-cf

(define pi 3.141592)

(tan-cf pi 10) ; tan(pi) = 0
-6.554829992649349e-007

(tan-cf (/ pi 2) 10) ; tan(pi / 2) = nan
3060023.295435797

(tan-cf (/ pi 4) 10) ; tan(pi / 4) = 1
0.9999996732051569

; 1.3.4
(define (average-damp f)
  (lambda (x) (average x (f x))))
average-damp

((average-damp square) 10)
55

(define (my-sqrt x)
  (fixed-point (average-damp (lambda (y) (/ x y)))
               1.0))
my-sqrt

(my-sqrt 2e-10)
1.4159184968008115e-005

(define (my-cbrt x)
  (fixed-point (average-damp (lambda (y) (/ x (square y))))
               1.0))
my-cbrt

(my-cbrt 8e-15)
2.0082480853390656e-005

(define dx 1e-5)
(define (deriv g)
  (lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))
deriv

((deriv cube) 5) ; D(x^3)=3*x^2, so D(x^3)(5)=3*5^2=75.
75.00014999664018

(define (newton-transform g)
  (lambda (x) (- x (/ (g x) ((deriv g) x)))))
(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))
newtons-method

(define (my-sqrt-newton x)
  (newtons-method
   (lambda (y) (- (square y) x)) 1.0))
my-sqrt-newton

(my-sqrt-newton 2e-10)
1.4385662128249002e-005

(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))
(define (sqrt1 x)
  (fixed-point-of-transform
   (lambda (y) (/ x y)) average-damp 1.0))
(define (sqrt2 x)
  (fixed-point-of-transform
   (lambda (y) (- (square y) x)) newton-transform 1.0))

(sqrt1 2)
1.414213562373095

(sqrt2 2)
1.4142135623730951

; ex.1.40
(define (cubic a b c)
  (lambda (x) (+ (cube x) (* a (square x)) (* b x) c)))
(define (solve-cubic a b c)
  (newtons-method (cubic a b c) 1))

(solve-cubic 0 0 -8) ; (x-2)^3=0
2.0

(solve-cubic -3 1 -3) ; (x-3)(x^2+1)=0
3.000000000000238

(solve-cubic -4 -3 18) ; (x-3)^2(x+2)=0
3.000002544856985

(solve-cubic 4 -3 -18) ; (x+3)^2(x-2)=0
2.000000000000059

; ex.1.41
(define (double f)
  (lambda (x) (f (f x))))
double

((double inc) 5)
7 ; 5 + 2

(((double double) inc) 5)
9 ; 5 + 2^2

(((double (double double)) inc) 5)
21 ; 5 + (2^2)^2

(((double (double (double double))) inc) 5)
261 ; 5 + ((2^2)^2)^2

((((double double) (double double)) inc) 5)
261 ; 5 + ((2^2)^(2^2))

; ex.1.42
(define (compose f g)
  (lambda (x) (f (g x))))
compose

((compose square inc) 6)
49

; ex.1.43
(define (repeated f n)
  (lambda (x)
    (if (> n 1)
        ((compose f (repeated f (- n 1))) x)
        (f x))))
repeated

((repeated square 2) 5)
625 ; means (square (square 5)).

((repeated square 3) 4)
65536
;means (square (square (square 4)))
;    = (square (square 2^4))
;    = (square 2^8)
;    = 2^16

; ex.1.44
(define (smooth f dx)
  (lambda (x) (/ (+ (f (- x dx))
                    (f x)
                    (f (+ x dx)))
                 3)))
smooth

(define (n-fold-smooth f dx n)
  (repeated (smooth f dx) n))
n-fold-smooth

(sin (/ pi 2))
0.9999999999999466

((smooth sin 0.5) (/ pi 2))
0.9183883745935327

((n-fold-smooth sin 0.5 2) (/ pi 2))
0.729773656913086

(map
 (lambda (n)
   ((n-fold-smooth sin 0.5 n) (/ pi 2)))
 (iota 5 1))
'(0.9183883745935327
  0.729773656913086
  0.6122904044263963
  0.5278375479126715
  0.4625613496467092)

; ex.1.45
(define (try-2nd x)
  (fixed-point (average-damp (lambda (y) (/ x y)))
               1.0))
(try-2nd 4)
2.000000000000002

(define (try-3rd x)
  (fixed-point (average-damp (lambda (y) (/ x (expt y 2))))
               1.0))
(try-3rd 8)
2.0000002271906077

#|
(define (try-4th-failed x)
  (fixed-point (average-damp (lambda (y) (/ x (expt y 3))))
               1.0))
(try-4th-failed 16)
|#

(define (try-4th x)
  (fixed-point
   ((repeated average-damp
              2)
    (lambda (y) (/ x (expt y 3))))
   1.0))
(try-4th 16)
2.0

(define (nth-root x n)
  (fixed-point
   ((repeated average-damp
              (floor (/ (log n) (log 2))))
    (lambda (y) (/ x (expt y (- n 1)))))
   1.0))
nth-root

(nth-root 3 1)
2.9999990463256836

(nth-root 9 2)
3.0

(nth-root 27 3)
2.9999998270063113

;(map (lambda (n) (nth-root (expt 3 n) n)) (iota 100 1))

