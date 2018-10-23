
(define (prog expr) 
  ;prog pulls out the first element in a list (a terminal) and sends the two nonterminals following
  ;to the associated evaluation functions
  ;expr a list representing a boolean expression
  (display "Prog:  ")
  (display expr)
  (newline)
  (cond((equal? expr 'true) #t)
       ((equal? expr 'false) #f)
       ((symbol? expr) #f)
       (else
              ;the command will be (car expr))
              (cond ((equal? (car expr) 'myor)
                  (myor (car(cdr expr)) (car(cdr(cdr expr))))
                  )
              ((equal? (car expr) 'myand)
                  (myand (car(cdr expr)) (car(cdr(cdr expr))))
                  )
              ((equal? (car expr) 'myignore)
                  (myignore (car(cdr expr)))
                  )
              ((equal? (car expr) 'mylet)
                  (mylet (car(cdr expr)) (car(cdr(cdr expr))) (car(cdr(cdr(cdr expr)))))
                  )
              (else #f)
              )
              )
   )
)
  ;)

(define false #f) ;defines false to its boolean value

(define true #t) ;defines true to its boolean value

(define (myignore val)
  ;the myignore function will return false for the expression passed
  #f
  )

(define (myor lval rval)
  ;lval, the left expression
  ;rval, the right expression
  ;the myor function will return the equivilant of the expression (lval or rval)
  (display "myor ")
  (newline)
  (display lval)
  (newline)
  (display rval)
  (newline)
  (newline)
  (cond ((and ( or (equal? lval 'true) (equal? lval 'false)) ( or (equal? rval 'true) (equal? rval 'false)))
         (or (prog lval) (prog rval))
         )
        ((or (equal? lval 'true) (equal? lval 'false))
         ;(or (prog lval) (prog (car rval)))
         (or (prog lval) (prog rval))
         (display "RVAL OR")
         (newline)
         )
        ((or (equal? rval 'true) (equal? rval 'false))
         (or (prog lval) (prog rval))
         (display "LVAL OR")
         (newline)
         )
        (else
             (or (prog lval) (prog rval))
             )
        )
  
  )

(define (myand lval rval)
  ;lval, the left expression to be passed to and
  ;rval, the right expression to be oassed to and
  ;myand function, will return the equivilant of (lval and rval)
  (display "myand ")
  (newline)
  (display lval)
  (newline)
  (display rval)
  (newline)
  (newline)
  (cond ((and ( or (equal? lval 'true) (equal? lval 'false)) ( or (equal? rval 'true) (equal? rval 'false))) (and (prog lval) (prog rval)))
        ((or (equal? lval 'true) (equal? lval 'false)) (and (prog lval) (prog rval)))
        ((or (equal? rval 'true) (equal? rval 'false)) (and (prog lval) (prog rval)))
        (else (and (prog lval) (prog rval)))
        )
  )

(define mynot
  ;val, and boolean expression
  ;mynot function, returns the opposite boolean of the val expression
  (lambda (val)
    (not prog(val))
    )
  )

(define (mylet var expr1 expr2)
  (display "mylet")
  (newline)
  (display expr1)
  (newline)
  (display expr2)
  (newline)
  (newline)
  (define var (prog expr1))
  (prog expr2)
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
