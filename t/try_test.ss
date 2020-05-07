(define test-passes 0)
(define test-fails 0)

(define assert
  (lambda (assertion message)
    (if assertion
        (set! test-passes (+ 1 test-passes))
        (begin
          (set! test-fails (+ 1 test-fails))
          (display "FAIL: ")
          (display message)))))

(assert #t "true")
(assert (not #f) "false")

(define throw-thing
  (lambda ()
    (throw "foo")))

(define throw-test
  (lambda ()
    (try
     (throw-thing)
     #f
     (catch e
       1))))

(define no-throw-thing
  (lambda () #t))

(define non-throw-test
  (lambda ()
    (try
     (no-throw-thing)
     (catch e
       #f))))

(assert (throw-test))
(assert (non-throw-test))

(= test-fails 0)
