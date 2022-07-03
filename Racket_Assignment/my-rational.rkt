#lang racket
;;
;; ------------ Part 1 Rational type ------------ 
;;

;
; Check if a denominator is valid .
;
(define (valid-deno d)
  (cond ((not (number? d)) #f) ; if not a number, return false
        ((or (< d 0) (> d 0)) #t)
        (else #f))) ; if zero, return false

;
; 1. Creates a new rational value.
;
(define (make-rational . args)
  (let* ([value (flatten args)])
    (cond ((empty? value) (raise "the expected number of arguments does not match the given number. Expected: 2. Given: 0"))
          ((and (= (length value) 1) (number? (first value))) (list 'my-rational (first value) 1))
          ((and (= (length value) 2) (valid-deno (second value))) (list 'my-rational (first value) (second value)))
          (else (raise "Invalid input")))
    )
  )

;
; 2. Get the numerator.
;
(define r-numerator second)

;
; 3. Get the denominator
;
(define r-denominator third)

;
; 4. Get the numerator and denominator as a pair
;
(define (num-denom val)
  (list (r-numerator val) (r-denominator val)))

;
; 5. Convert to a string
;
(define (to-string val)
  (string-append (~v (r-numerator val)) "/" (~v (r-denominator val))))

;
; 6. Convert the fraction to a floating point value
;
(define (to-float val)
  (exact->inexact (/ (r-numerator val) (r-denominator val))))

;
; 7. Test for equality
;
(define (r= r1 r2)
  (= (* (r-numerator r1) (r-denominator r2)) (* (r-denominator r1) (r-numerator r2))))

;
; 8. Test for order: less than
;
(define (r< r1 r2)
  (< (to-float r1) (to-float r2)))

;
; 9. Test if an integer
;
(define (is-int? r)
  (= (remainder (r-numerator r) (r-denominator r)) 0))

;
; 10. Add
;
(define (r+ r1 r2)
  (let* ([nume (+ (* (r-numerator r1) (r-denominator r2)) (* (r-numerator r2) (r-denominator r1)))]
         [deno (* (r-denominator r1) (r-denominator r2))]
         )
    (make-rational nume deno)
    )
  )

;
; 11. Multiply
;
(define (r* r1 r2)
  (let* ([nume (* (r-numerator r1) (r-numerator r2))]
         [deno (* (r-denominator r1) (r-denominator r2))]
         )
    (make-rational nume deno)
    )
  )

;
; 12. Divide
;
(define (r/ r1 r2)
  (if (zero? (r-numerator r2))
      (raise "The given two rational numbers can not be divided.")
      (make-rational (* (r-numerator r1) (r-denominator r2)) (* (r-numerator r2) (r-denominator r1)))))

;
; 13. Invert
;
(define (invert r)
  (if (zero? (r-numerator r))
      (raise "The given rational number has no inverse.")
      (make-rational (r-denominator r) (r-numerator r))))

;
; 14. Reduce to lowest terms
;
(define (to-lowest-terms r)
  (let* ([g (gcd (r-numerator r) (r-denominator r))])
        (make-rational (/ (r-numerator r) g) (/ (r-denominator r) g))
    )
  )

;
; 15. Harmonic sum
;
(define (harmonic-sum n)
  (if (= n 1)
      (make-rational 1 1)
      (r+ (make-rational 1 n) (harmonic-sum (- n 1)))))



;;
;; ------------ Part 2 Insertion sort and benchmark ------------ 
;;

;
; Insertion sort for numbers / strings / rational numbers
;
(define (insertionSort vals comp-vals)
  (if (or (empty? vals) (= (length vals) 1))
      vals
      (insert (first vals) (insertionSort (rest vals) comp-vals) comp-vals)
     )
  )

(define (insert val r-range comp-vals)
  (cond ((null? r-range) (cons val (list)))
        ((comp-vals val (first r-range)) (cons val r-range))
        (else (cons (first r-range) (insert val (rest r-range) comp-vals)))
      )
  )

;
; Benchmark
;

(define (ave-sortTime lst cmp cycles)
  (if (zero? cycles)
      0
      (exact->inexact (/ (+ (sortTime (current-inexact-milliseconds) lst cmp) (ave-sortTime lst cmp (- cycles 1))) cycles))
    )
  )

(define (sortTime start-time lst cmp)
  (insertionSort lst cmp)
  (- (current-inexact-milliseconds) start-time))

;
; Numbers
;

; Create a list of n numbers
(define (make-num-list size)
  (if (zero? size)
      (list)
      (cons (random size) (make-num-list (- size 1)))))

(define sort-nums-data
  (lambda (size) (ave-sortTime (make-num-list size) < 3))
  )

;; -------- Get sort time data for lists of numbers in millionseconds --------
#;(define nums-sort-data (map sort-nums-data '(1000 2000 3000 4000 5000 6000 7000 8000 9000 10000)))


;
; Strings
;

; Create a list of n strings
(define (make-str-list size)
  (if (zero? size)
      (list)
      (cons (list->string (random-str 4)) (make-str-list (- size 1)))))

(define (random-str len)
  (if (zero? len)
      (list)
      (cons (random-char) (random-str (- len 1)))
    )
  )

(define (random-char)
  (let* ([chars "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"])
    (string-ref chars (random 62))
    )
  )

(define sort-strs-data
  (lambda (size) (ave-sortTime (make-str-list size) string<? 3))
  )

;; -------- Get sort time data for lists of strings in millionseconds --------
#;(define strs-sort-data (map sort-strs-data '(1000 2000 3000 4000 5000 6000 7000 8000 9000 10000)))


;
; Rational numbers
;

; Create a list of n rational numbers
(define (make-rational-list size)
  (if (zero? size)
      (list)
      (cons (random-rational size) (make-rational-list (- size 1)))))

(define (random-rational size)
  (make-rational (random size) (+ 1 (random size))))

(define sort-rationals-data
  (lambda (size) (ave-sortTime (make-rational-list size) r< 3))
  )

;; -------- Get sort time data for lists of numbers in millionseconds --------
#;(define rationals-sort-data (map sort-rationals-data '(1000 2000 3000 4000 5000 6000 7000 8000 9000 10000)))



;;
;;;; --------------------------------------- Test --------------------------------------- ;;;;
;;

(define ns '(6 2 1 5 4))


(define ss1 '("b" "c" "d" "a"))
(define ss2 '("d" "c" "b" "a"))
(define ss3 '("he" "hel" "12111" "22" "122"))


(define r0 (make-rational 2 3))
;(define rw0 (make-rational 0 0))
;(define rw1 (make-rational 0 'a))
(define r1 (make-rational '0 '2))
(define r2 (make-rational -2 4))
(define r3 (make-rational -4 2))
(define r4 (make-rational (list 10 64)))
(define r5 (make-rational 63 42))
(define r6 (make-rational 44 66))
(define r7 (make-rational 42 70))

(define rs (list r1 r2 r3 r4 r5 r6 r7))

(define rn1 (make-rational '0 '9))
(define rn2 (make-rational 1 9))
(define rn3 (make-rational 2 9))
(define rn4 (make-rational (list 3 9)))
(define rn5 (make-rational 4 9))
(define rn6 (make-rational 5 9))
(define rn7 (make-rational 6 9))
(define rs2 (list rn1 rn2 rn3 rn4 rn5 rn6 rn7))

