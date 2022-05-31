package main

import (
	"errors"
	"fmt"
	"math"
)

type Rational struct {
	numerator, denominator int
}

func makeRational(n int, d int) Rational {
	if d == 0 {
		err := errors.New("Denominator can not be zero.")
		fmt.Print(err)
		return Rational{}
	} else {
		return Rational{n, d}
	}
}

func (r Rational) Numerator() int {
	return r.numerator
}

func (r Rational) Denominator() int {
	return r.denominator
}

func (r Rational) Split() (int, int) {
	return r.numerator, r.denominator
}

func (r Rational) String() string {
	return fmt.Sprintf("%v/%v", r.numerator, r.denominator)
}

func (r Rational) toFloat64() float64 {
	return float64(r.numerator / r.denominator)
}

func (r Rational) Equal(other Rationalizer) bool {
	if r.numerator*other.Denominator() == r.denominator*other.Numerator() {
		return true
	}
	return false
}

// if r < other --> return true
// if r >= other --> return false
func (r Rational) LessThan(other Rationalizer) bool {
	if r.Equal(other) {
		return false
	}

	prodA := r.numerator * other.Denominator()
	prodB := other.Numerator() * r.denominator

	numeratorA := math.Abs(float64(prodA))
	numeratorB := math.Abs(float64(prodB))

	if isNegative(r) && isNegative(other) {
		return numeratorA > numeratorB
	} else if !isNegative(r) && !isNegative(other) {
		// fmt.Printf("\nis less than: %t", numeratorA < numeratorB)
		return numeratorA < numeratorB
	} else if isNegative(r) && !isNegative(other) {
		return true
	} else {
		return false
	}
}

func isNegative(r Rationalizer) bool {
	// fmt.Printf("\nis it negative: %t", r.Numerator()*r.Denominator() < 0)
	return r.Numerator()*r.Denominator() < 0
}

func (r Rational) IsInt() bool {
	return r.numerator%r.denominator == 0
}

func (r Rational) Add(other Rationalizer) Rationalizer {
	denoProd := r.denominator * other.Denominator()

	numeratorR := r.numerator * other.Denominator()
	numeratorOther := other.Numerator() * r.denominator

	if bothNegative(r, other) || bothPositive(r, other) {
		nSum := numeratorR + numeratorOther
		return makeRational(nSum, denoProd)
	} else {
		if isNegative(other) {
			nSum := numeratorR - numeratorOther
			return makeRational(nSum, denoProd)
		} else {
			nSum := numeratorOther - numeratorR
			return makeRational(nSum, denoProd)
		}
	}
}

func bothNegative(r1 Rationalizer, r2 Rationalizer) bool {
	return isNegative(r1) && isNegative(r2)
}

func bothPositive(r1 Rationalizer, r2 Rationalizer) bool {
	return !isNegative(r1) && !isNegative(r2)
}

func (r Rational) Multiply(other Rationalizer) Rationalizer {
	dProd := r.denominator * other.Denominator()
	nProd := r.numerator * other.Numerator()
	return makeRational(nProd, dProd)
}

// 12. Returns the quotient of this value with other. The error is nil
// if its is successful, and a non-nil if it cannot be divided.
func (r Rational) Divide(other Rationalizer) (Rationalizer, error) {
	if other.Numerator() == 0 {
		err := errors.New("Two numbers can not be divided.")
		return Rational{}, err
	}
	resNume := r.numerator * other.Denominator()
	resDeno := other.Numerator() * r.denominator
	return Rational{resNume, resDeno}, nil
}

// 13. Returns the reciprocal. The error is nil if it is successful,
// and non-nil if it cannot be inverted.
func (r Rational) Invert() (Rationalizer, error) {
	if r.numerator != 0 {
		return makeRational(r.denominator, r.numerator), nil
	}
	err := errors.New("There's no inverse for this number.")

	return Rational{}, err
}

// 14. Returns an equal value in lowest terms.
func (r Rational) ToLowestTerms() Rationalizer {
	if r.IsInt() {
		return makeRational(r.numerator/r.denominator, 1)
	} else if r.numerator == 0 {
		return r
	} else if r.denominator%r.numerator == 0 {
		return makeRational(1, r.denominator/r.numerator)
	}

	// larger number / smaller number
	if r.numerator > r.denominator {
		g := getGCB(r.numerator, r.denominator)
		return makeRational(r.numerator/g, r.denominator/g)
	} else {
		g := getGCB(r.denominator, r.numerator)
		return makeRational(r.numerator/g, r.denominator/g)
	}
}

func getGCB(dividend, divisor int) int {
	q1 := int(dividend % divisor)
	q2 := int(divisor % q1)
	for q2 != 0 {
		curr_q2 := int(q2)
		q2 = q1 % q2
		q1 = curr_q2
	}
	return q2
}

//
// 15. Harmonic sum
//
func harmonicSum() {

}
