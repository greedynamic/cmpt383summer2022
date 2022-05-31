// rationalizer.go

package main

import (
	"fmt"
)

type Floater64 interface {
	// Converts a value to an equivalent float64.
	toFloat64() float64
}

type Rationalizer interface {

	// 5. Rationalizers implement the standard Stringer interface.
	fmt.Stringer

	// 6. Rationalizers implement the Floater64 interface.
	Floater64

	// 2. Returns the numerator.
	Numerator() int

	// 3. Returns the denominator.
	Denominator() int

	// 4. Returns the numerator, denominator.
	Split() (int, int)

	// 7. Returns true iff this value equals other.
	Equal(other Rationalizer) bool

	// 8. Returns true iff this value is less than other.
	LessThan(other Rationalizer) bool

	// 9. Returns true iff the value equal an integer.
	IsInt() bool

	// 10. Returns the sum of this value with other.
	Add(other Rationalizer) Rationalizer

	// 11. Returns the product of this value with other.
	Multiply(other Rationalizer) Rationalizer

	// 12. Returns the quotient of this value with other. The error is nil
	// if its is successful, and a non-nil if it cannot be divided.
	Divide(other Rationalizer) (Rationalizer, error)

	// 13. Returns the reciprocal. The error is nil if it is successful,
	// and non-nil if it cannot be inverted.
	Invert() (Rationalizer, error)

	// 14. Returns an equal value in lowest terms.
	ToLowestTerms() Rationalizer
} // Rationalizer interface
