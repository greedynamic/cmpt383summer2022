class MyRational
    include Comparable
    # Getters: 2. Returns the numerator. & 3. Returns the denominator.
    attr_reader :numerator, :denominator
  
    # 1. Make a rational.
    def initialize(nume, denom)
      @numerator = nume
      raise 'MyRational: Denominator cannot be 0.' if denom == 0
      @denominator = denom if denom != 0
    end
  
    # numerator setter
    def set_num(nume)
      @numerator = nume
    end
  
    # denominator setter
    def set_denom(denom)
      raise 'MyRational: Denominator cannot be 0.' if denom == 0
      @denominator = denom if denom != 0
    end
  
    # // 4. Returns the numerator, denominator.
    # Get the numerator and denominator as a pair
    def pair
      return [numerator, denominator]
    end
  
    # Converts pair to a string
    def pair_s
      arr = pair.map {|i| i.to_s}
      raise 'Invalid rational number array input.' if arr.size < 2
      return "#{arr[0]}/#{arr[1]}"
    end
  
    # // 5. Converts MyRational to a string.
    def to_s
      "(#{@numerator}, #{@denominator})"
    end
  
    # // 6. Converts MyRational to a float.
    def to_f
      n = numerator/1.0
      d = denominator/1.0
      return n/d
    end
  
    Integer.prepend(Module.new do
      def to_mr
        return MyRational.new(self, 1)
      end
    end)
  
    # // 7. Returns true iff this value equals other.
    def ==(other)
      other.class == self.class && other.numerator*denominator == other.denominator*numerator
    end
  
    # // if r < other --> return true
    # // if r >= other --> return false
    # // 8. Returns true iff this value is less than other.
    def <=>(other)
      return self.to_f <=> other.to_f
    end
  
    # // 9. Returns true iff the value equal an integer.
    def int?
      return true if numerator%denominator == 0
      return false
    end
  
    # // 10. Returns the sum of this value with other.
    def +(other)
      if denominator == other.denominator then
        d = denominator.abs
        numeOther = other.numerator.abs
        numeR = numerator.abs
        nSum = numeR + numeOther
        return MyRational.new(nSum, d) if bothPositive(other)
        return MyRational.new(-1*nSum, d) if bothNegative(other)
        return MyRational.new(numeOther-numeR, d) if isNegative
        return MyRational.new(numeR-numeOther, d) if other.isNegative
      end
  
      d1 = denominator.abs
      d2 = other.denominator.abs
      n1 = numerator.abs
      n2 = other.numerator.abs
      dProd = d1 * d2
      numeR = n1 * d2
        numeOther = n2 * d1
      numeSum = numeR + numeOther
  
      return MyRational.new(numeSum, dProd) if bothPositive(other)
      return MyRational.new(-1*numeSum, dProd) if bothNegative(other)
      return MyRational.new(numeOther-numeR, dProd) if isNegative
      return MyRational.new(numeR-numeOther, dProd) if other.isNegative
    end
  
    # // 11. Returns the product of this value with other.
    def *(other)
      dProd = denominator * other.denominator
      nProd = numerator * other.numerator
      return MyRational.new(nProd, dProd)
    end
  
    # // 12. Returns the quotient of this value with other. The error is nil if its is successful, and a non-nil if it cannot be divided.
    def /(other)
      raise 'The given two rational numbers can not be divided.' if other.numerator == 0
      resNume = numerator * other.denominator
      resDeno = other.numerator * denominator
      return MyRational.new(resNume, resDeno)
    end
  
    # // 13. Returns the reciprocal. The error is nil if it is successful, and non-nil if it cannot be inverted.
    def invert
      raise 'The given rational number has no inverse.' if numerator == 0
      return MyRational.new(denominator, numerator)
    end
  
    # // 14. Returns an equal value in lowest terms.
    def to_lowest_terms
      return MyRational.new(numerator/denominator, 1) if int?
      return self if numerator == 0
      return MyRational.new(1, denominator/numerator) if denominator%numerator == 0
    
    # larger number / smaller number
      g = getGcb(numerator, denominator)
    #   puts "GCB: #{g}"
      return MyRational.new(numerator/g, denominator/g) if g!= 0
      return self
    end
  
    # // 15. Harmonic sum
    def get_harmonic_sum(n)
      raise 'The given rational should be greater than zero.' if n <= 0
      return MyRational.new(1, 1) if n == 1
  
      resultD = factorialCal(1, n)
        resultN = 0
  
      n.times do |i|
        resultN += resultD / (i + 1)
      end
      return MyRational.new(resultN, resultD)
    end
  
    def factorialCal(first, last)
      if first == last
        return first
      end
      mid = (first + last) / 2
      return factorialCal(first, mid) * factorialCal(mid+1, last)
    end
  
    def getGcb(nume, deno)
      dividend = nume
      divisor = deno
      if nume < deno
        dividend = deno
        divisor = nume
      end
      q1 = dividend % divisor
        q2 = divisor % q1
        while q2 != 0 
            curr_q2 = q2
            q2 = q1 % q2
            q1 = curr_q2
      end
        return q1
    end
  
    def isNegative
      return self.numerator*self.denominator < 0
    end
  
    def bothNegative(r)
      return isNegative && r.isNegative
    end
  
    def bothPositive(r)
      return !isNegative && !r.isNegative
    end
  
  end # MyRational