(define foo (lambda (n acc)
              (if (= 0 n)
                  acc
                  (foo (- n 1) (+ acc 2)))))
(define (fib n)
  (if (<= n 2)
      1
      (+ (fib (- n 1)) (fib (- n 2)))))

(define (fibr n)
  (define (iter a b count)
    (if (<= count 0)
        a
        (iter b (+ a b) (- count 1))))
  (iter 0 1 n))
