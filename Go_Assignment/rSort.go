package main

// import (
// 	"math"
// )

func numsSort(nums []int) {
	for i := range nums {
		if i > 0 {
			for preI := i; preI > 0; preI-- {
				if nums[preI] < nums[preI-1] {
					// swap
					// temp := int(nums[preI])
					// nums[preI] = nums[preI-1]
					// nums[preI-1] = temp
					nums[preI], nums[preI-1] = nums[preI-1], nums[preI]
				}
			}
		}
	}
}

func strsSort(strs []string) {
	for i := range strs {
		if i > 0 {
			for preI := i; preI > 0; preI-- {
				if strs[preI] < strs[preI-1] {
					strs[preI], strs[preI-1] = strs[preI-1], strs[preI]
				}
			}
		}
	}
}

func rationalSort(rs []Rationalizer) {
	for i := range rs {
		if i > 0 {
			for preI := i; preI > 0 && rs[preI].LessThan(rs[preI-1]); preI-- {
				rs[preI], rs[preI-1] = rs[preI-1], rs[preI]
			}
		}
	}
}
