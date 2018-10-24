;; Contract: prog: expr -> boolean value of expr
;;Purpose: evaluate a given boolean expression
;;expr, The boolean expression to be evaluated
;;varlist, the list of local variables and their values
;;Example (prog (myand true false)) -> false
;;Definition
(define (prog expr varlist) 
  ;(display "Prog:  ")
  ;(display expr)
  ;(newline)
  (cond((equal? expr 'true) #t)
       ((equal? expr 'false) #f)
       ((symbol? expr) (varlook expr varlist))
       (else
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
              ((equal? (car expr) 'mynot)
                  (mynot (car(cdr expr)) varlist)
                  )
              (else #f)
              )
              )
   )
)

;;Contract: varlook varlist(var value) -> value
;;Purpose: determine the value of a variable name, located on a list
;;var, the variable name to lookup
;;varlist, the variable list containing variable names and values
;;Example: (varlook x (x #t y #f)) -> #t
;;Definition:
(define (varlook var varlist)
  ;(display "VARLOOK: ")
  ;(display var)
  ;(newline)
  (define curvar (car varlist))
  (cond ((equal? curvar var) (car(cdr varlist)))
        (else
         (varlook var (cdr varlist))
         )
        )
  )

;;Contract: myignore: #f
;;Purpose: to "ignore" an expression by not evaluating it and instead returning false
;;val, the expression to not evaluate
;;Example: (myignore true) -> #f
;;Definition:
(define (myignore val)
  #f
  )

;;Contract: myor -> (or lval rval)
;;Purpose: to compute the or value of two passed in expressions
;;lval, the left expression
;;rval, the right expression
;;varlist, a list of variables and definitions
;;Example: (myor false true) -> true
;;Definition:
(define (myor lval rval varlist)
  ;(display "myor ")
  ;(newline)
  ;(display lval)
  ;(newline)
  ;(display rval)
  ;(newline)
  ;(newline)
  (or (prog lval varlist) (prog rval varlist)) 
  )

;;Contract: myand -> (and lval rval)
;;Purpose: compute the and value of lval and rval
;;lval, the left expression
;;rval, the right expression
;;Example: (myand true true '()) -> true
;;Definition:
(define (myand lval rval varlist)
  ;(display "myand ")
  ;(newline)
  ;(display lval)
  ;(newline)
  ;(display rval)
  ;(newline)
  ;(newline)
  (and (prog lval varlist) (prog rval varlist))
  )

;;Contract: mynot -> (not val)
;;Purpose: compute the negation of val
;;val, the expression to be negated
;;varlist, the list of variables and definitions
;;Example: (mynot true '()) -> #f
;;Definition:
(define (mynot val varlist)
  (not (prog val varlist))
  )

;;Contract: mylet: varlist -> varlist + value(expr1)
;;Purpose: compute the value of a variable and store it in a list, return the value of expr2
;;var, the name of the var to be computer
;;expr1, the expression to be stored with var
;;expr2, the expression to be computed and returned
;;varlist, the list of variables and their values
;;Example: (mylet x true false '()) -> false
;;Definition:
(define (mylet var expr1 expr2 varlist)
  ;(display "mylet")
  ;(newline)
  ;(display expr1)
  ;(newline)
  ;(display expr2)
  ;(newline)
  ;(newline)
  (define varlist2 (cons var (cons(prog expr1 varlist) varlist)))
  (prog expr2 varlist2)
  )

;;Contract: runcommand: cmd -> (prog (car(cdr cmd)))
;;Purpose: Begin the running of a single command
;;cmd, a single boolean expression to compute
;;Example: (runcommand (prog true)) -> true
;;Definition:
(define (runcommand cmd)
  (define varlist '())
  (define commandcd (car cmd))
  (define exp1 (car(cdr cmd)))
  (prog exp1 varlist)
  )

;;Contract: myinterpreterhelper: anslist -> list((x))
;;Purpose: iterate through commands passed to myinterpreter and put the evaluations in a list
;;x, a list of boolean expressions
;;anslist, a list containing all boolean expressions computed to this point
;;Example: (myinterpreterhelper '((prog(true))(prog(false))) '()) -> (#t #f)
;;Definition:
(define (myinterpreterhelper x anslist)
    (cond ((equal? x '()) (reverse anslist))
        (else
         (myinterpreterhelper (cdr x) (cons (runcommand (car x)) anslist))
         )
        )
  )

  
;; Contract: myinterpreter: x -> list(evaluations of boolean expressions in x)
;; Purpose: give the formatted list of values to the user
;; x,  list of boolean expressions
;; Example: (myinterpreter '((prog(true))(prog(false)))) -> (#t #f)
(define (myinterpreter x)
  (define anslist '())
  (myinterpreterhelper x anslist)

 )
