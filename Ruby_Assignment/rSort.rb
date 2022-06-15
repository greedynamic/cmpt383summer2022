def numsSort(nums)
    result = nums.dup
    result.each_with_index do |n,i|
        if i > 0
            preI = i
            while preI > 0 && result[preI] < result[preI-1] do
                result[preI], result[preI-1] = result[preI-1], result[preI]
                preI = preI - 1
            end
        end
    end
    return result
end


def strsSort(strs)
    result = strs.dup
    result.each_with_index do |s,i|
        if i > 0
            preI = i
            while preI > 0 && result[preI] < result[preI-1] do
                result[preI], result[preI-1] = result[preI-1], result[preI]
                preI = preI - 1
            end
        end
    end
    return result
end

def rationalsSort(rs)
    result = rs.dup
    result.each_with_index do |r,i|
        if i > 0
            preI = i
            while preI > 0 && result[preI] < result[preI-1] do
                result[preI], result[preI-1] = result[preI-1], result[preI]
                preI = preI - 1
            end
        end
    end
    return result
end