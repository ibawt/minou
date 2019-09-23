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
