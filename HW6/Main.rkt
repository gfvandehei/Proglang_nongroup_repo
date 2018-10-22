
(define prog
  ;prog pulls out the first element in a list (a terminal) and sends the two nonterminals following
  ;to the associated evaluation functions
  (lambda (expr)
    ;expr a list representing a boolean expression
    (cond((eqv? expr #t) #t)
         ((eqv? expr #f) #f)
         (else (let ()
                 (define args (cdr expr))
                 ;if this is mylet assign the variable and call the function
                 (car(expr) car(args) cdr(args))
                 (display "else")
                 )
                )
                 
         )
    )
  )

(define false #f)

(define true #t)

(define myignore
  (lambda(val)
    #f
    )
  )

(define myor
  (lambda (lval rval)
    (or (prog lval) (prog rval))
    )
  )

(define myand
  (lambda (lval rval)
    (and (prog lval) (prog rval))
    )
  )

(define mynot
  (lambda (val)
    (not prog(val))
    )
  )

(define mylet
  (lambda (var expr1 expr2)
    (display var)
    )
  )
  
(define myinterpreter '(
    (prog true)
    (prog (myor (myand true (myignore (myor true false))) (myand true false)))
    (prog (mylet z (myor false true) (myand z true)))
    (prog (mylet a true (myor (mylet b (myand true false) (myor false b)) (myand false a))))
    (prog (mylet x true (myor (mylet x (myand true false) (myand true x)) (myand true x))))
))

;; YOUR CODE HERE
(define (myinterpreter x)
;;
  (x)
)
