package main

func numsSort(nums []int) []int {
	result := make([]int, len(nums))
	copy(result, nums)
	for i := range result {
		if i > 0 {
			for preI := i; preI > 0 && result[preI] < result[preI-1]; preI-- {
				result[preI], result[preI-1] = result[preI-1], result[preI]
			}
		}
	}
	return result
}

func strsSort(strs []string) []string {
	result := make([]string, len(strs))
	copy(result, strs)
	for i := range result {
		if i > 0 {
			for preI := i; preI > 0 && result[preI] < result[preI-1]; preI-- {
				result[preI], result[preI-1] = result[preI-1], result[preI]
			}
		}
	}
	return result
}

func rationalSort(rs []Rationalizer) []Rationalizer {
	result := make([]Rationalizer, len(rs))
	copy(result, rs)
	for i := range rs {
		if i > 0 {
			for preI := i; preI > 0 && result[preI].LessThan(result[preI-1]); preI-- {
				result[preI], result[preI-1] = result[preI-1], result[preI]
			}
		}
	}
	return result
}
