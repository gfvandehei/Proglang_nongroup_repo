
(define (prog expr varlist) 
  ;prog pulls out the first element in a list (a terminal) and sends the two nonterminals following
  ;to the associated evaluation functions
  ;expr a list representing a boolean expression
  (display "Prog:  ")
  (display expr)
  (newline)
  (cond((equal? expr 'true) #t)
       ((equal? expr 'false) #f)
       ((symbol? expr) (varlook expr varlist))
       (else
              ;the command will be (car expr))
              (cond ((equal? (car expr) 'myor)
                  (myor (car(cdr expr)) (car(cdr(cdr expr))) varlist)
                  )
              ((equal? (car expr) 'myand)
                  (myand (car(cdr expr)) (car(cdr(cdr expr))) varlist)
                  )
              ((equal? (car expr) 'myignore)
                  (myignore (car(cdr expr)))
                  )
              ((equal? (car expr) 'mylet)
                  (mylet (car(cdr expr)) (car(cdr(cdr expr))) (car(cdr(cdr(cdr expr)))) varlist)
                  )
              (else #f)
              )
              )
   )
)
  ;)

(define (varlook var varlist)
  (display "VARLOOK: ")
  (display var)
  (newline)
  (define curvar (car varlist))
  (cond ((equal? curvar var) (car(cdr varlist)))
        (else
         (varlook var (cdr varlist))
         )
        )
  )

(define false #f) ;defines false to its boolean value

(define true #t) ;defines true to its boolean value

(define (myignore val)
  ;the myignore function will return false for the expression passed
  #f
  )

(define (myor lval rval varlist)
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
  ;(cond ((and ( or (equal? lval 'true) (equal? lval 'false)) ( or (equal? rval 'true) (equal? rval 'false)))
   ;      (or (prog lval varlist) (prog rval varlist))
    ;     )
     ;   ((or (equal? lval 'true) (equal? lval 'false))
      ;   ;(or (prog lval) (prog (car rval)))
       ;  (or (prog lval varlist) (prog rval varlist))
        ; (display "RVAL OR")
         ;(newline)
         ;)
        ;((or (equal? rval 'true) (equal? rval 'false))
  ;       (or (prog lval varlist) (prog rval varlist))
   ;      (display "LVAL OR")
    ;     (newline)
     ;    )
      ;  (else
       ;      (or (prog lval varlist) (prog rval varlist))
        ;     )
        ;)
  (or (prog lval varlist) (prog rval varlist))
  
  )

(define (myand lval rval varlist)
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
  ;(cond ((and ( or (equal? lval 'true) (equal? lval 'false)) ( or (equal? rval 'true) (equal? rval 'false))) (and (prog lval) (prog rval)))
   ;     ((or (equal? lval 'true) (equal? lval 'false)) (and (prog lval) (prog rval)))
    ;    ((or (equal? rval 'true) (equal? rval 'false)) (and (prog lval) (prog rval)))
     ;   (else (and (prog lval) (prog rval)))
      ;  )
  (and (prog lval varlist) (prog rval varlist))
  )

(define (mynot varlist)
  ;val, and boolean expression
  ;mynot function, returns the opposite boolean of the val expression
  (not prog(val varlist))
  )

(define (mylet var expr1 expr2 varlist)
  (display "mylet")
  (newline)
  (display expr1)
  (newline)
  (display expr2)
  (newline)
  (newline)
  ;make a pair of variable and value
  ;add to varlist
  (define varlist2 (cons var (cons(prog expr1 varlist) varlist)))
  (prog expr2 varlist2)
  )

(define (runcommand cmd)
  (define varlist '())
  (define commandcd (car cmd))
  (define exp1 (car(cdr cmd)))
  (prog exp1 varlist)
  )
  
;; YOUR CODE HERE
(define (myinterpreter x)
;;define var list
  (define anslist '())
  (cond ((eqv? x '()) (display x))
        (else(
             (display (runcommand (car x)))
             (newline)
             (myinterpreter (cdr x))
             )
        )
  )
  anslist
 )
