# Test MyRational.rb

require "./MyRational.rb"
require "./rSort.rb"
require 'date'

#
# /* ------------ Test Part 1 Rational type ------------ */
#
###
################################################
def testRationalType1To5
  #   ---- 1. Test constructor ----
  #   ---- 5. Test conversion from Rational to String ----
  r1 = MyRational.new(2, 1)
  r2 = MyRational.new(-3, 9)
  r3 = MyRational.new(-4, -5)

  rArr = [r1,r2,r3]

  rArr.each_with_index do |r,i|
    puts "r#{i+1} = #{r}"
  end
  
  # r2 = MyRational.new(2, 0) # error
  # puts "r2 = #{r2}"

  #   ---- 2. Test Numerator: getter and setter ----
  puts "r2's numerator = #{r2.numerator}"
  
  r1.set_num(3)
  puts "Set r1's numerator to 3:\nr1 = #{r1}"

  #   ---- 3. Test Denominator: getter and setter ----
  puts "r3's denominator = #{r3.denominator}"
  
  # r1.denominator = 0 # error
  # puts "r1 = #{r1}"

  # r1.set_denominator(0) # error
  # puts "r1 = #{r1}"
  
  r1.set_denom(5)
  puts "Set r1's denominator to 5:\nr1 = #{r1}"

  #   ---- 4. Test pair ----
  puts "Print pair arr: #{r1.pair}"
  r1_arr = r1.pair.map {|i| i}
  puts "Print pair: #{r1_arr[0]}/#{r1_arr[1]}"

  # helper function: convert pair to a string
  rArr.each_with_index do |r,i|
    puts "Print pair: r#{i+1} = #{r.pair_s}"
  end
end

###
################################################
def testRationalType6To9
  r1 = MyRational.new(5, 8)
  r2 = MyRational.new(-5, 8)
  r3 = MyRational.new(-5, -8)
  r4 = MyRational.new(5, -8)
  r5 = MyRational.new(7, 8)
  r6 = MyRational.new(-7, 8)
  r7 = MyRational.new(8, 8)
  r8 = MyRational.new(-8, 8)
  rArr = [r1,r2,r3,r4,r5,r6,r7,r8]

  puts "\nPrint rationals"
  rArr.each_with_index do |r,i|
    puts "r#{i+1} = #{r.pair_s}"
  end

  #   ---- 6. Test to_f: converts a rational to a float ----
  puts "\n6. Test to_f"
  rArr.each_with_index do |r,i|
    puts "r#{i+1}_f: #{r.pair_s} = #{r.to_f}"
  end

  # Test to_mr for Ruby standard object Integer
  [5.to_mr, -5.to_mr].each_with_index do |mr,i|
    puts mr.class
    puts "mr#{i+1} = " + mr.pair_s
    puts "mr#{i+1}_f = #{mr.to_f}"
  end

  #   ---- 7. Test ==(other rational number) ----
  puts "\n7. Test =="
  puts "#{r1.pair_s} == #{r3.pair_s}: Actual: #{r1==r3}. Expect: True"
  puts "#{r1.pair_s} == #{r2.pair_s}: Actual: #{r1==r2}. Expect: False"
  puts "#{r2.pair_s} == #{r3.pair_s}: Actual: #{r3==r2}. Expect: False"
  puts "#{r2.pair_s} == #{r4.pair_s}: Actual: #{r4==r2}. Expect: True"

  #   ---- 8. Test <=>(other rational number) ----
  puts "\n8. Test <=>"
  puts "1 <=> 1: #{2<=>2}" # equal: 0
  puts "1 <=> 2: #{2<=>3}" # less than: -1
  puts "1 <=> 0: #{2<=>1}" # larger than: 1
  # r1 <=> r3 two equal positive: 0
  puts "#{r1.pair_s} <=> #{r3.pair_s}: Actual: #{r1<=>r3}. Expect: 0"
  # 5/8 <=> 7/8: -1
  puts "#{r1.pair_s} <=> #{r5.pair_s}: Actual: #{r1<=>r5}. Expect: -1"
  # 7/8 <=> 5/8: 1
  puts "#{r5.pair_s} <=> #{r1.pair_s}: Actual: #{r5<=>r1}. Expect: 1"
  
  # r2 <=> r4 two equal negative: 0
  puts "#{r2.pair_s} <=> #{r4.pair_s}: Actual: #{r4<=>r2}. Expect: 0"
  # -5/8 <=> -7/8: 1
  puts "#{r2.pair_s} <=> #{r6.pair_s}: Actual: #{r2<=>r6}. Expect: 1"
  # -7/8 <=> -5/8: -1
  puts "#{r6.pair_s} <=> #{r2.pair_s}: Actual: #{r6<=>r2}. Expect: -1"
  
  # positive and negative: r1 <=> r2, r2 <=> r1
  puts "#{r1.pair_s} <=> #{r2.pair_s}: Actual: #{r1<=>r2}. Expect: 1"
  puts "#{r2.pair_s} <=> #{r1.pair_s}: Actual: #{r2<=>r1}. Expect: -1"

  #   ---- 9. Test if a rational number is an integer ----
  puts "\n9. Test int?"
  puts "Is #{r1.pair_s} an integer: Actual: #{r1.int?}. Expect: False"
  puts "Is #{r7.pair_s} an integer: Actual: #{r7.int?}. Expect: True"
  puts "Is #{r8.pair_s} an integer: Actual: #{r8.int?}. Expect: True"

  #   ---- Test Ruby Comparable class ----
  puts "\nTest Ruby Comparable class"
  puts "Is #{r1.pair_s} in between of #{r2.pair_s} <=> #{r5.pair_s}: Actual: #{r1.between?(r2, r5)}. Expect: True"
  puts "Is #{r1.pair_s} in between of #{r5.pair_s} <=> #{r7.pair_s}: Actual: #{r1.between?(r5, r7)}. Expect: False"
end

###
################################################
def testRationalType10To14
  r1 = MyRational.new(5, 8)
  r2 = MyRational.new(-5, 8)
  r3 = MyRational.new(-5, -8)
  r4 = MyRational.new(5, -8)
  r5 = MyRational.new(2, -3)
  r6 = MyRational.new(0, 2)
  r7 = MyRational.new(-2, 4)
  r8 = MyRational.new(-4, 2)
  r9 = MyRational.new(10, 64)
  r10 = MyRational.new(63, 42)
  r11 = MyRational.new(44, 66)
  r12 = MyRational.new(42, 70)
  rArr = [r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12]

  puts "\nPrint rationals"
  rArr.each_with_index do |r,i|
    puts "r#{i+1} = #{r.pair_s}"
  end

  def testHelperFun
    puts "\nTest my helper function"
    puts "Is #{r1.pair_s} negative: Actual: #{r1.isNegative}. Expect: False"
    puts "Is #{r2.pair_s} negative: Actual: #{r2.isNegative}. Expect: False"
  
    puts "Is #{r1.pair_s} and #{r2.pair_s} both negative: Actual: #{r1.bothNegative(r2)}. Expect: False"
    puts "Is #{r1.pair_s} and #{r2.pair_s} both positive: Actual: #{r1.bothPositive(r2)}. Expect: False"
    puts "Is #{r2.pair_s} and #{r4.pair_s} both negative: Actual: #{r2.bothNegative(r4)}. Expect: True"
    puts "Is #{r1.pair_s} and #{r3.pair_s} both positive: Actual: #{r1.bothPositive(r3)}. Expect: True"
  end
  # testHelperFun

  #   ---- 10. Test addition + ----
  puts "\n10. Test addition + (sum two rationals)"
  puts "Add #{r1.pair_s} and #{r2.pair_s}: Actual: #{(r1+r2).pair_s}. Expect: 0/8"
  puts "Add #{r3.pair_s} and #{r5.pair_s}: Actual: #{(r3+r5).pair_s}. Expect: -1/24"

  #   ---- 11. Test multiplication * ----
  puts "\n11. Test multiplication * (product two rationals)"
  puts "Multiply #{r1.pair_s} and #{r2.pair_s}: Actual: #{(r1*r2).pair_s}. Expect: -25/64"
  puts "Multiply #{r3.pair_s} and #{r5.pair_s}: Actual: #{(r3*r5).pair_s}. Expect: -10/24"

  #   ---- 12. Test divide / ----
  puts "\n12. Test divide / (divide two rationals)"
  puts "Divide #{r1.pair_s} and #{r2.pair_s}: Actual: #{(r1/r2).pair_s}. Expect: -1/1"
  puts "Divide #{r3.pair_s} and #{r5.pair_s}: Actual: #{(r3/r5).pair_s}. Expect: -15/16"
  # puts "Divide #{r1.pair_s} and #{r6.pair_s}: Actual: #{(r1/r6).pair_s}. Expect: Error"

  #   ---- 13. Test invert ----
  puts "\n13. Test invert"
  puts "The inverse of #{r2.pair_s}: Actual: #{r2.invert.pair_s}. Expect: 8/-5"
  # puts "The inverse of #{r6.pair_s}: Actual: #{r6.invert}. Expect: Error"

  #   ---- 14. Test to lowest terms ----
  puts "\n14. Test ToLowstTerms"
  puts "The lowest term of #{r6.pair_s}: Actual: #{r6.to_lowest_terms.pair_s}. Expect: 0/2"
  puts "The lowest term of #{r7.pair_s}: Actual: #{r7.to_lowest_terms.pair_s}. Expect: -1/2"
  puts "The lowest term of #{r8.pair_s}: Actual: #{r8.to_lowest_terms.pair_s}. Expect: -2/1"
  puts "The lowest term of #{r9.pair_s}: Actual: #{r9.to_lowest_terms.pair_s}. Expect: 5/32"
  puts "The lowest term of #{r10.pair_s}: Actual: #{r10.to_lowest_terms.pair_s}. Expect: 3/2"
  puts "The lowest term of #{r11.pair_s}: Actual: #{r11.to_lowest_terms.pair_s}. Expect: 2/3"
  puts "The lowest term of #{r12.pair_s}: Actual: #{r12.to_lowest_terms.pair_s}. Expect: 3/5"
end

###
################################################
def testHarmonicSum
  # Test a very large number? like 1000?
  n = 1000
  puts "Harmonic sum from 1 to #{n} is #{get_harmonic_sum(n).to_lowest_terms}"
end

# testRationalType1To5

# testRationalType6To9

# testRationalType10To14

testHarmonicSum # 15. Harmonic Sum

#
# /* ------------ Test Part 2 Sort ------------ */
#

def testSortSample
    def testNumsSortSample
        numArr = [2,5,3,9,1,2]
        puts "\nBefore sort: "
        puts "#{numArr}"
    
        res = numsSort(numArr)
        puts "\nAfter sort: "
        puts "#{res}"
    end
    
    def testStrsSortSample
        strArr = ["hl", "zg", "he", "ac", "ab", "23", "He", "111"]
        puts "\nBefore sort: "
        puts "#{strArr}"
        
        res = strsSort(strArr)
        puts "\nAfter sort: "
        puts "#{res}"
    end
    
    def testRationalsSortSample
        r1 = MyRational.new(5, 8)
        r2 = MyRational.new(-5, 8)
        r3 = MyRational.new(-5, -8)
        r4 = MyRational.new(5, -8)
        r5 = MyRational.new(2, -3)
        r6 = MyRational.new(0, 2)
        r7 = MyRational.new(-2, 4)
        r8 = MyRational.new(-4, 2)
        r9 = MyRational.new(10, 64)
        r10 = MyRational.new(63, 42)
        r11 = MyRational.new(44, 66)
        r12 = MyRational.new(42, 70)
        rArr = [r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12]
    
        puts "\nBefore sort: "
        rArr.each { |r| puts r.pair_s }
        res = rationalsSort(rArr)
    
        puts "\nAfter sort: "
        res.each { |r| puts r.to_lowest_terms.pair_s }
    end
    
    testNumsSortSample
    
    testStrsSortSample
    
    testRationalsSortSample
end

# testSortSample

def howRubyExpressTime
    puts "Subseconds: #{Time.now.subsec*1000000.0}"
    puts "time now: #{Time.now.to_f*1000000}" # microseconds
    puts "current time:#{Time.now.to_f}; seconds: #{Time.now.sec.to_f}; microseconds: #{Time.now.usec.to_f}; nanoseconds: #{Time.now.nsec.to_f}"
end

# howRubyExpressTime

def testNumsSort
    size = [1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000]
    # size = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    log_time = File.open("ints_sort_time.txt", "w")
    size.each do |s|
        numsArr = []
        sortTimeTotal = 0
        # Loop 3 times to get an average sort time
        3.times do |t|
            s.times do |i|
                numsArr[i] = rand(s)
            end

            time1 = Time.now.to_f*1000000
            res = numsSort(numsArr)
            time2 = Time.now.to_f*1000000
            time_diff = time2 - time1
            sortTimeTotal += time_diff
            puts "\n(Iter #{t+1}) Sort #{s} integers took : #{time_diff}"
        end

        avg = sortTimeTotal / 3.0
        puts "\nThe average time (in microseconds or µs) for sorting #{s} integers took #{avg}\n"
        if log_time
            log_time.puts "#{avg}\n"
        end
    end
    log_time.close
end

def testStrsSort
    size = [1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000]
    # size = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    log_time = File.open("strings_sort_time.txt", "w")
    size.each do |s|
        strsArr = []
        sortTimeTotal = 0
        # Loop 3 times to get an average sort time
        3.times do |t|
            s.times do |i|
                strsArr[i] = ('a'..'z').to_a.shuffle[0,5].join
            end

            time1 = Time.now.to_f*1000000
            res = strsSort(strsArr)
            time2 = Time.now.to_f*1000000
            time_diff = time2 - time1
            sortTimeTotal += time_diff
            puts "\n(Iter #{t+1}) Sort #{s} strings took : #{time_diff}"
        end

        avg = sortTimeTotal / 3.0
        puts "\nThe average time (in microseconds or µs) for sorting #{s} strings took #{avg}\n"
        if log_time
            log_time.puts "#{avg}\n"
        end
    end
    log_time.close
end

def testRationalsSort
    size = [1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000]
    # size = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    log_time = File.open("rationals_sort_time.txt", "w")
    size.each do |s|
        rsArr = []
        sortTimeTotal = 0
        # Loop 3 times to get an average sort time
        3.times do |t|
            s.times do |i|
                rsArr[i] = MyRational.new(rand(20), rand(1..20))
            end

            time1 = Time.now.to_f*1000000
            res = rationalsSort(rsArr)
            time2 = Time.now.to_f*1000000
            time_diff = time2 - time1
            sortTimeTotal += time_diff
            puts "\n(Iter #{t+1}) Sort #{s} strings took : #{time_diff}"
        end

        avg = sortTimeTotal / 3.0
        puts "\nThe average time (in microseconds or µs) for sorting #{s} strings took #{avg}\n"
        if log_time
            log_time.puts "#{avg}\n"
        end
    end
    log_time.close
end

# testNumsSort

# testStrsSort

# testRationalsSort
