package main

import (
	"fmt"
	"math/rand"
	"time"
)

func main() {
	/* ------------ Part 1 Rational type ------------ */

	testRationalType()

	/* ------------ Part 2 Sort ------------ */

	rand.Seed(time.Now().UnixNano())

	// +++++++ Test linear insertion sort for integers +++++++
	sortTestForInt()

	// +++++++ Test strings linear insertion sort +++++++
	sortTestForStr()

	// +++++++ Test rational numbers linear insertion sort +++++++
	sortTestForRationals()

	howGoExpressTime()

	fmt.Print("\n\n/* -------- Test Finish -------- */\n")
}

func testRationalType() {
	// 		1. Test constructor
	myR1 := NewRational(11, 25)
	myR2 := NewRational(13, 25)
	// wrongR := NewRational(1, 0)

	// 		2. Test Numerator()
	fmt.Printf("\nThe numerator of %s is %d", myR1, myR1.Numerator())

	// 		3. Test Denominator()
	fmt.Printf("\nThe denominator of %s is %d", myR1, myR1.Denominator())

	// 		4. Test Split()
	n, d := myR1.Split()
	fmt.Printf("\nThe split of %s is %d and %d\n", myR1, n, d)

	// 		5. Test conversion from Rational to String
	fmt.Print(myR1)

	// 		6. Test toFloat64()
	fmt.Printf("\nThe float of %s is %0.50f", myR1, myR1.toFloat64())

	// 		7. Test Equal(other Rationalizer)
	fmt.Printf("\nDoes %s equal to %s: %t", myR1, myR1, myR1.Equal(myR1))
	fmt.Printf("\nDoes %s equal to %s: %t", myR1, myR2, myR1.Equal(myR2))

	// 		8. Test LessThan(other Rationalizer)
	r1 := NewRational(1, 3)
	r2 := NewRational(2, 3)
	r3 := NewRational(6, 3)
	fmt.Printf("\nIs %s less than %s: %t", r1, r2, r1.LessThan(r2))
	fmt.Printf("\nIs %s less than %s: %t", r2, r1, r2.LessThan(r1))

	// 		9. Test IsInt()
	fmt.Printf("\nIs %s an integer: %t", r1, r1.IsInt())
	fmt.Printf("\nIs %s an integer: %t", r3, r3.IsInt())

	// 		10. Test Add(other Rationalizer)
	fmt.Printf("\nThe sum of %s and %s: %s", r1, r2, r1.Add(r2))

	// 		11. Test Multiply(other Rationalizer)
	fmt.Printf("\nThe product of %s and %s: %s", r1, r2, r1.Multiply(r2))

	// 		12. Test Divide(other Rationalizer)
	q, err1 := r1.Divide(r2)
	fmt.Printf("\nThe quotient of %s and %s: %s. Err: %s", r1, r2, q, err1)

	// 		13. Test Invert()
	inv, err2 := r1.Invert()
	fmt.Printf("\nThe invert of %s: %s. Err: %s", r1, inv, err2)

	// 		14. Test ToLowestTerms()
	fmt.Printf("\nThe lowest term of %s: %s", r3, r3.ToLowestTerms())
}

func sortTestForInt() {
	size := 0
	for size < 10000 {
		size += 1000
		var sortTimeTotal int
		for i := 0; i < 3; i++ {
			arr := make([]int, size)
			// fmt.Print("\n\n---- Before Sort ----\n")
			for i := range arr {
				randNum := rand.Intn(size)
				arr[i] = randNum
				// fmt.Printf("%d ", randNum)
			}

			start := time.Now()
			numsSort(arr)
			elapsed := time.Since(start)
			sortTimeTotal += int(elapsed)
			fmt.Printf("\n(Iter %d) Sort the %d integers took %s.\n", i, size, elapsed)

			// fmt.Print("\n\n---- After Sort ----\n")
			// for _, n := range arr {
			// 	fmt.Printf("%d ", n)
			// }
		}

		fmt.Printf("\nThe average time for sorting the %d integers took %d.\n", size, sortTimeTotal/3)
	}
}

func sortTestForStr() {
	// min := 33
	// max := 125
	// randNum := randNumBetween(min, max)

	size := 0
	for size < 10000 {
		size += 1000
		strArr := make([]string, size)

		// fmt.Print("\n\n---- Before Sort ----\n")

		for i := range strArr {
			strLen := rand.Intn(5) + 4
			strArr[i] = randStringBytes(strLen)
			// fmt.Printf("%s ", strArr[i])
		}

		start := time.Now()
		strsSort(strArr)
		elapsed := time.Since(start)
		fmt.Printf("\nSort the %d strings took %s\n", size, elapsed)

		// fmt.Print("\n\n---- After Sort ----\n")
		// for _, s := range strArr {
		// 	fmt.Printf("%s ", s)
		// }
	}

	// strArr := []string{"hl", "zg", "he", "ac", "ab", "23", "He", "111"}
	// fmt.Print("\n\n---- Before Sort ----\n")
	// for _, s := range strArr {
	// 	// strArr[i] = i
	// 	fmt.Print(s)
	// }
	// strsSort(strArr)

	// fmt.Print("\n\n---- After Sort ----\n")
	// for _, s := range strArr {
	// 	fmt.Print(s)
	// }
}

func sortTestForRationals() {
	size := 0
	for size < 10000 {
		size += 1000
		rArr := make([]Rationalizer, size)

		// fmt.Print("\n\n---- Before Sort ----\n")

		for i := range rArr {
			rArr[i] = NewRational(rand.Intn(10), rand.Intn(10)+1)
			// fmt.Print(rArr[i])
			// fmt.Print(" ")
		}

		start := time.Now()
		rationalSort(rArr)
		elapsed := time.Since(start)
		fmt.Printf("\nSort the %d rational numbers took %s\n", size, elapsed)

		// fmt.Print("\n\n---- After Sort ----\n")
		// for _, r := range rArr {
		// 	fmt.Print(r)
		// 	fmt.Print(" ")
		// }
	}

	// rArr := make([]Rationalizer, 5)
	// fmt.Print("\n\n---- Before Sort ----\n")
	// for i := range rArr {
	// 	rArr[i] = NewRational(rand.Intn(5), rand.Intn(5)+1)
	// 	fmt.Print(rArr[i])
	// 	fmt.Print(" ")
	// }
	// rationalSort(rArr)

	// fmt.Print("\n\n---- After Sort ----\n")
	// for _, r := range rArr {
	// 	fmt.Print(r)
	// 	fmt.Print(" ")
	// }

	// rArr := make([]Rationalizer, 5)
	// r1 := NewRational(14, 5)
	// r2 := NewRational(11, 4)
	// rArr[0] = r1
	// rArr[1] = r2
	// fmt.Print("\n\n---- Before Sort ----\n")
	// for i := 2; i < len(rArr); i++ {
	// 	rArr[i] = NewRational(rand.Intn(5)+10, rand.Intn(5)+1)
	// 	fmt.Print(rArr[i])
	// 	fmt.Print(" ")
	// }
	// rationalSort(rArr)

	// fmt.Print("\n\n---- After Sort ----\n")
	// for _, r := range rArr {
	// 	fmt.Print(r)
	// 	fmt.Print(" ")
	// }
}

func howGoExpressTime() {
	// ----------- microseconds -----------
	start := time.Now()
	time.Sleep(5 * time.Microsecond)
	elapsed := time.Since(start)
	fmt.Printf("\nHow the microseconds being expressed in string: %s", elapsed)

	fmt.Printf("\nHow the microseconds being expressed in int: %d", elapsed) // Nanoseconds

	// ----------- millionseconds -----------
	start = time.Now()
	time.Sleep(8 * time.Millisecond)
	elapsed = time.Since(start)
	fmt.Printf("\nHow the millionseconds being expressed in string: %s", elapsed)

	fmt.Printf("\nHow the millionseconds being expressed in int: %d", elapsed) // Nanoseconds

	// ----------- seconds -----------
	start = time.Now()
	time.Sleep(2 * time.Second)
	elapsed = time.Since(start)
	fmt.Printf("\nHow the seconds being expressed in string: %s", elapsed)

	fmt.Printf("\nHow the seconds being expressed in int: %d", elapsed) // Nanoseconds
}

func randNumBetween(min, max int) int {
	fmt.Printf("random number: %d", rand.Intn(1)*(max-min)+min)
	return rand.Intn(1)*(max-min) + min
}

// https://stackoverflow.com/questions/22892120/how-to-generate-a-random-string-of-a-fixed-length-in-go
func randStringBytes(n int) string {
	var letterBytes = []rune("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
	b := make([]rune, n)
	for i := range b {
		b[i] = letterBytes[rand.Intn(len(letterBytes))]
	}
	return string(b)
}
