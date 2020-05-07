(define foo (lambda ()
              (throw "foo")))

(define throw-thing
  (lambda ()
    (throw "foo")))

(define dont-throw-thing
  (lambda ()
    0))

(define test
  (lambda ()
    (try
     ((lambda ()
        (try
         (throw-thing)
         (catch f
           3))))
     (catch e
       1))))

(define raise-test
  (lambda ()
    (throw-thing)))
