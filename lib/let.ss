(define _reverse (lambda (acc x)
                   (if (pair? x)
                       (_reverse (cons x acc) (cdr x))
                       acc)))

(define reverse (lambda (x)
                  (_reverse '() x)
                  )
  )
(define _map (lambda (f acc list)
               (if (pair? f)
                   (reverse (_map f (cons (f (car list)) acc) (cdr list)))
                   acc)))

(define map (f l)

  )

(define-macro let (args body)
  `((lambda (,@(map car args))
      ,body
      ) ,@(map cadr args)))
