
;;
;; ------------ Part 1 Rational type ------------ 
;;

;;
;;;; 1. Test constructor ;;;;
;;
;; Input: non-list
(define r0 (make-rational 0 1))
(define r1 (make-rational 0 0))
(define r2 (make-rational 0 'a))
(define r3 (make-rational 0))

;; Input: a list with zero number
(define r3 (make-rational (list)))

;; Input: a list with one number
> (make-rational (list 0))
> (make-rational '0)
'(my-rational (0) 1) ; wrong

;; Input: a list with one non-number
> (make-rational (list 'a))

;; Input: a list with two number
> (make-rational (list 0 1))

;; Input: a list with two number and denominator is zero
> (make-rational (list 0 0))

;; Input: a list with two non-number
> (make-rational (list 'a 'b))


;;
;;;; 7. Test less than r= ;;;;
;;
(r= (make-rational -3 7) (make-rational 3 -7))

;;
;;;; 8. Test less than r< ;;;;
;;
(r< (make-rational -3 7) (make-rational 2 -7)) ;; true
(r< (make-rational -3 7) (make-rational 5 -7)) ;; false


;;
;;;; 9.Test if an integer ;;;;
;;
(is-int? (make-rational -3 7))
(is-int? (make-rational -14 7))

;;
;;;; 10. Add ;;;;
;;
;; >>> 0.1 + 0.2 == 0.3
;; False
;; >>> 0.2 + 0.2 + 0.2 == 0.6
;; False
;; >>> 1.3 + 2.0 == 3.3
;; False
;; >>> 1.2 + 2.4 + 3.6 == 7.2
;; False
;; (= (+ 0.1 0.2) 0.3)
;; (= (+ (/ 1 10) (/ 2 10)) (/ 3 10))

(define (r+ r1 r2)
  (cond ((= (r-denominator r1) (r-denominator r2)) 
 )

(r+ (make-rational -1 7) (make-rational 2 -7))
(r+ (make-rational 1 -7) (make-rational 2 7))

;;
;;;; 11. Multiply ;;;;
;;
(r* (make-rational -1 7) (make-rational 2 -7))
(r* (make-rational -1 7) (make-rational 2 7))

;;
;;;; 12. Divide ;;;;
;;
(r/ (make-rational -1 7) (make-rational 2 -7))
(r/ (make-rational 1 7) (make-rational 2 -7))
(r/ (make-rational -1 7) (make-rational 0 -7))

;;
;;;; 13. Invert ;;;;
;;
(invert (make-rational -1 7))
(invert (make-rational 0 7))

;;
;; 14. Reduce to lowest terms
;;
(to-lowest-terms (make-rational '0 '2)) ;; 0 r1
'(my-rational 0 1) ;; not exactly wrong? because it's still zero?
(to-lowest-terms (make-rational -2 4)) ;; -1/2 r2
(to-lowest-terms (make-rational -4 2)) ;; -2 r3
(to-lowest-terms (make-rational 10 64)) ;; 5/32 r4
(to-lowest-terms (make-rational 63 42)) ;; 3/2 r5
(to-lowest-terms (make-rational 44 66)) ;; 2/3 r6
(to-lowest-terms (make-rational 42 70)) ;; 3/5 r7
;; -4/2, -2/4, 0/2, 10/64, 42/70, 44/66, 63/42
;; r3, r2, r1, r4, r7, r6, r5

;;
;; 15. Harmonic sum
;;


;;
;; ------------ Part 2 Insertion Sort ------------ 
;;


;;
;; Insertion sort
;;

;; sort numbers
(insertionSort '(6 5 4) <)

(define ns '(6 2 1 5 4))
(insertionSort ns <)

;; sort strings
(define ss1 '("b" "c" "d" "a"))
(define ss2 '("d" "c" "b" "a"))
(define ss3 '("he" "hel" "1" "11" "123"))
(insertionSort ss1 string<?)
(insertionSort ss2 string<?)
(insertionSort ss3 string<?)

;; sort rationals
(define r1 (make-rational '0 '2))
(define r2 (make-rational -2 4))
(define r3 (make-rational -4 2))
(define r4 (make-rational (list 10 64)))
(define r5 (make-rational 63 42))
(define r6 (make-rational 44 66))
(define r7 (make-rational 42 70))
;; -2, -1/2, 0, 5/32, 3/5, 2/3, 3/2
;; r3, r2, r1, r4, r7, r6, r5

(define rs1 (list r1 r2 r3 r4 r5 r6 r7))
(insertionSort rs1 r<)

(define rn1 (make-rational '0 '9))
(define rn2 (make-rational 1 9))
(define rn3 (make-rational 2 9))
(define rn4 (make-rational (list 3 9)))
(define rn5 (make-rational 4 9))
(define rn6 (make-rational 5 9))
(define rn7 (make-rational 6 9))
(define rs2 (list rn1 rn2 rn3 rn4 rn5 rn6 rn7))
(insertionSort rs2 r<)



;;
;; Benchmark
;;
(make-nums-list 1000 (list))
(insertionSort (make-nums-list 1000 (list)) <)
(time (insertionSort (make-nums-list 1000 (list)) <))

(sortTime (current-inexact-milliseconds) (make-nums-list 1000 '()) <)

(define (ave-sortTime lst cmp cycles)
  (if (zero? cycles)
      (sortTime (current-inexact-milliseconds) lst cmp)
      (cons (sortTime (current-inexact-milliseconds) lst cmp) (ave-sortTime lst cmp (- cycles 1)))
    )
  )

(define (ave-time lst cmp cycles)
  (if (zero? cycles)
      0
      (exact->inexact (/ (+ (sortTime (current-inexact-milliseconds) lst cmp) (ave-sortTime lst cmp (- cycles 1))) cycles))
    )
  )

(define (ave-sort lst cmp cycles)
  (cond ((zero? cycles) (print (sortTime (current-inexact-milliseconds) lst cmp)) 0)
        ((= 1 cycles) (print (sortTime (current-inexact-milliseconds) lst cmp)))
        ((= 2 cycles) (print (sortTime (current-inexact-milliseconds) lst cmp)))
        ((= 3 cycles) (print (sortTime (current-inexact-milliseconds) lst cmp)))
        (else (print (exact->inexact (/ (+ (sortTime (current-inexact-milliseconds) lst cmp) (ave-sortTime lst cmp (- cycles 1))) cycles))))
    )
  )

(ave-sortTime (make-nums-list 1000 '()) < 3)

(ave-sort (make-nums-list 1000 '()) < 3)