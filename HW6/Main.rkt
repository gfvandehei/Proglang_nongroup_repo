
(define (prog expr) 
  ;prog pulls out the first element in a list (a terminal) and sends the two nonterminals following
  ;to the associated evaluation functions
  ;expr a list representing a boolean expression
  (display expr)
  (newline)
  (cond((equal? expr 'true) #t)
       ((equal? expr 'false) #f)
       (else
              ;the command will be (car expr))
              (display (car expr))
              (newline)
              (display (car(cdr expr)))
              (let ((cmd (car expr))
                    )
                (cmd (car(cdr expr)) (car(cdr expr)))
                )
              ;((car expr) #t #t)
             )
   )
)
  ;)

(define false #f) ;defines false to its boolean value

(define true #t) ;defines true to its boolean value

(define myignore
  ;the myignore function will return false for the expression passed
  (lambda(val)
    #f
    )
  )

(define (myor lval rval)
  ;lval, the left expression
  ;rval, the right expression
  ;the myor function will return the equivilant of the expression (lval or rval)
  (display "or")
  (or (prog lval) (prog rval))
  )

(define myand
  ;lval, the left expression to be passed to and
  ;rval, the right expression to be oassed to and
  ;myand function, will return the equivilant of (lval and rval)
  (lambda (lval rval)
    (and (prog lval) (prog rval))
    )
  )

(define mynot
  ;val, and boolean expression
  ;mynot function, returns the opposite boolean of the val expression
  (lambda (val)
    (not prog(val))
    )
  )

(define mylet
  (lambda (var expr1 expr2)
    (display "HELLO")
    )
  )

(define (runcommand cmd)
  (define commandcd (car cmd))
  (define exp1 (car(cdr cmd)))
  (prog exp1)
  )

;; YOUR CODE HERE
(define (myinterpreter x)
;;
  (cond ((eqv? x '()) (display x))
        (else(
             (display (runcommand (car x)))
             (newline)
             (myinterpreter (cdr x))
             )
        )
  )
 )
