; by xyzzy (Lisp Interaction mode)

; 1.1.1
(+ (* 3
      ( + (* 2 4)
	  (+ 3 5)))
   (+ (- 10 7)
      6)
9

; 1.1.2
(setq radius 10)
10

(* pi (* radius radius))
314.1592653589793d0

#|
defmacro define: Thx to
[Common Lisp “ü–å](http://www.geocities.jp/m_hiroi/xyzzy_lisp/abclisp08.html#chap16)
|#
(defmacro define ((name &rest args) &rest body)
  `(defun ,name ,args ,@body))
define

(setq circum (* 2 pi radius))
62.83185307179586d0

; 1.1.4
(define (square x) (* x x))
square

(square 21)
441
(square (+ 2 5))
49
(square (square 3))
81

(define (circumference radius)
	(* 2 pi radius))
circumference

(circumference 10)
62.83185307179586d0

(define (sum-of-squares x y)
	(+ (square x) (square y)))
sum-of-squares

(sum-of-squares 3 4)
25


