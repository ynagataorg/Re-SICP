#lang racket/base
(provide prime?)

(define (square x) (* x x))

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

(define (prime? n (times 10))
  (cond ((< n 2) #f)
        ((= times 0) #t)
        ((miller-rabin-test n) (prime? n (- times 1)))
        (else #f)))
