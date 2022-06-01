package main

import (
	"fmt"
	"math/rand"
	"time"
)

func main() {
	/* ------------ Part 1 Rational type ------------ */

	// testRationalType()
	// testHarmonicSum()

	/* ------------ Part 2 Sort ------------ */

	rand.Seed(time.Now().UnixNano())

	// sortTestForInt()

	// testStrSortCorrectness()
	// sortTestForStr()

	// testRaionalSortCorrectness()
	// sortTestForRationals()

	// howGoExpressTime()

	fmt.Print("\n\n/* -------- Test Finish -------- */\n")
}

func testRationalType() {
	// 		1. Test constructor
	myR1 := makeRational(11, 25)
	myR2 := makeRational(-13, 25)
	fmt.Print(makeRational(1, 0))

	r1 := makeRational(1, 3)
	r2 := makeRational(2, -3)
	r3 := makeRational(6, 3)
	r4 := makeRational(-1, 3)
	r5 := makeRational(2, 3)
	r6 := makeRational(-2, 3)
	r7 := makeRational(2, 3)
	r8 := makeRational(4, 6)
	r9 := makeRational(3, 5)
	r10 := makeRational(9, 15)

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
	fmt.Printf("\nThe float of %s is %0.6f", myR1, myR1.toFloat64())
	fmt.Printf("\nThe float of %s is %0.6f", myR2, myR2.toFloat64())

	// 		7. Test Equal(other Rationalizer)
	fmt.Printf("\nDoes %s equal to %s: %t", myR1, myR1, myR1.Equal(myR1))
	fmt.Printf("\nDoes %s equal to %s: %t", myR1, myR2, myR1.Equal(myR2))
	fmt.Printf("\nDoes %s equal to %s: %t", r7, r8, r7.Equal(r8))

	// 		8. Test LessThan(other Rationalizer)
	fmt.Printf("\nIs %s less than %s: %t", r1, r2, r1.LessThan(r2))
	fmt.Printf("\nIs %s less than %s: %t", r2, r1, r2.LessThan(r1))
	fmt.Printf("\nIs %s less than %s: %t", r7, r8, r7.LessThan(r8))
	fmt.Printf("\nIs %s less than %s: %t", r9, r10, r9.LessThan(r10))

	// 		9. Test IsInt()
	fmt.Printf("\nIs %s an integer: %t", r1, r1.IsInt())
	fmt.Printf("\nIs %s an integer: %t", r3, r3.IsInt())

	// 		10. Test Add(other Rationalizer)
	fmt.Printf("\nThe sum of %s and %s: %s", r1, r2, r1.Add(r2))
	fmt.Printf("\nThe sum of %s and %s: %s", r2, r4, r2.Add(r4))
	fmt.Printf("\nThe sum of %s and %s: %s", r1, r4, r1.Add(r4))
	fmt.Printf("\nThe sum of %s and %s: %s", r4, r5, r4.Add(r5))

	// 		11. Test Multiply(other Rationalizer)
	fmt.Printf("\nThe product of %s and %s: %s", r1, r2, r1.Multiply(r2))
	fmt.Printf("\nThe product of %s and %s: %s", r2, r4, r2.Multiply(r4))
	fmt.Printf("\nThe product of %s and %s: %s", r4, r6, r4.Multiply(r6))

	// 		12. Test Divide(other Rationalizer)
	q, err1 := r1.Divide(r2)
	fmt.Printf("\nThe quotient of %s and %s: %s. Err: %s", r1, r2, q, err1)

	// 		13. Test Invert()
	inv, err2 := r1.Invert()
	fmt.Printf("\nThe invert of %s: %s. Err: %s", r1, inv, err2)

	// 		14. Test ToLowestTerms()
	fmt.Printf("\nThe lowest term of %s: %s", r3, r3.ToLowestTerms())
}

func testHarmonicSum() {
	fmt.Print(harmonicSum(6))
}

func sortTestForInt() {
	size := 0

	//
	// loop size from 1k, 2k, ... 9k, 10k
	//
	for size < 10000 {
		size += 1000
		sortTimeTotal := float64(0)

		//
		// loop 3 times to get an average sort time
		//
		for i := 0; i < 3; i++ {
			arr := make([]int, size)

			for i := range arr {
				arr[i] = rand.Intn(size)
			}

			start := time.Now()
			res := numsSort(arr)
			elapsed := time.Since(start)

			sortTimeTotal += float64(elapsed)

			fmt.Print(len(res))
			// fmt.Printf("\n(Iter %d) Sort the %d integers took %s.\n", i+1, size, elapsed)
		}

		// get average sort time in nanoseconds and convert it to microseconds
		ave := (sortTimeTotal / 3.0) / 1000.0

		fmt.Printf("\nThe average time (in microseconds or µs) for sorting the %d integers took %0.6f\n", size, ave)
	}
}

func sortTestForStr() {
	size := 0

	//
	// loop size from 1k, 2k, ... 9k, 10k
	//
	for size < 10000 {
		size += 1000
		sortTimeTotal := float64(0)

		//
		// loop 3 times to get an average sort time
		//
		for i := 0; i < 3; i++ {
			strArr := make([]string, size)

			for i := range strArr {
				strLen := rand.Intn(5) + 4
				strArr[i] = randStringBytes(strLen)
			}

			start := time.Now()
			res := strsSort(strArr)
			elapsed := time.Since(start)

			sortTimeTotal += float64(elapsed)

			fmt.Print(len(res))
			// fmt.Printf("\n(Iter %d) Sort the %d strings took %s\n", i+1, size, elapsed)
		}

		ave := (sortTimeTotal / 3.0) / 1000.0

		fmt.Printf("\nThe average time (in microseconds or µs) for sorting the %d strings took %0.6f\n", size, ave)
	}
}

func sortTestForRationals() {
	size := 0

	//
	// loop size from 1k, 2k, ... 9k, 10k
	//
	for size < 10000 {
		size += 1000
		sortTimeTotal := float64(0)

		//
		// loop 3 times to get an average sort time
		//
		for i := 0; i < 3; i++ {
			rArr := make([]Rationalizer, size)

			for i := range rArr {
				rArr[i] = makeRational(rand.Intn(20), rand.Intn(20)+1)
			}

			start := time.Now()
			res := rationalSort(rArr)
			elapsed := time.Since(start)

			sortTimeTotal += float64(elapsed)

			fmt.Print(len(res))
			// fmt.Printf("\n(Iter %d) Sort the %d rational numbers took %s\n", i+1, size, elapsed)
		}

		ave := (sortTimeTotal / 3.0) / 1000.0

		fmt.Printf("\nThe average time (in microseconds or µs) for sorting the %d rational numbers took %0.6f\n", size, ave)
	}
}

func testStrSortCorrectness() {
	strArr := []string{"hl", "zg", "he", "ac", "ab", "23", "He", "111"}
	fmt.Print("\n\n---- Before Sort ----\n")
	for _, s := range strArr {
		fmt.Print(s)
	}
	res := strsSort(strArr)

	fmt.Print("\n\n---- After Sort ----\n")
	for _, s := range res {
		fmt.Print(s)
	}
}

func testRaionalSortCorrectness() {
	rArr1 := make([]Rationalizer, 5)
	fmt.Print("\n\n---- Before Sort ----\n")
	for i := range rArr1 {
		rArr1[i] = makeRational(rand.Intn(5)*-1, rand.Intn(5)+1)
		fmt.Print(rArr1[i])
		fmt.Print(" ")
		// fmt.Print(rArr1[i].toFloat64())
		// fmt.Print(" ")
	}
	res := rationalSort(rArr1)

	fmt.Print("\n\n---- After Sort ----\n")
	for _, r := range res {
		fmt.Print(r)
		fmt.Print(" ")
		// fmt.Print(r.toFloat64())
		// fmt.Print(" ")
	}

	rArr2 := make([]Rationalizer, 5)
	r1 := makeRational(14, 5)
	r2 := makeRational(11, 4)
	rArr2[0] = r1
	rArr2[1] = r2
	fmt.Print("\n\n---- Before Sort ----\n")
	for i := 2; i < len(rArr2); i++ {
		rArr2[i] = makeRational((rand.Intn(5)+10)*-1, rand.Intn(5)+1)
		fmt.Print(rArr2[i])
		fmt.Print(" ")
		// fmt.Print(rArr2[i].toFloat64())
		// fmt.Print(" ")
	}
	res = rationalSort(rArr2)

	fmt.Print("\n\n---- After Sort ----\n")
	for _, r := range res {
		fmt.Print(r)
		fmt.Print(" ")
		// fmt.Print(r.toFloat64())
		// fmt.Print(" ")
	}
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
