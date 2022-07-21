-- rational.hs

--
-- Implement your answers in this file.
--
-- There are few rules to follow:
--
--  - Don't change the MyRational type.
--  - Don't change any of the given function signatures.
--  - Use only functions from the standard prelude. Don't import any Haskell
--    modules.
--
-- You can implement your own helper functions if you like.
--

data MyRational = Frac Integer Integer

--
-- Given integers n and d, create a new rational with n as the numerator and d
-- as the denominator. Trying to create a rational with denominator 0 is an
-- error. Call the error function to crash the function, e.g. error
-- "makeRational: denominator can't be 0"
--
makeRational :: Integer -> Integer -> MyRational
makeRational n d | d == 0    = error "Denominator cannot be zero."
                 | otherwise = Frac n d

--
-- Returns the numerator of a rational.
--
getNum :: MyRational -> Integer
getNum (Frac n d) = n

--
-- Returns the denominator of a rational.
--
getDenom :: MyRational -> Integer
getDenom (Frac n d) = d

--
-- Returns a pair of the numerator and denominator of a MyRational.
--
pair :: MyRational -> (Integer, Integer)
pair (Frac n d) = (n, d)

--
-- Implement an instance of the show function that returns the usual string
-- representation of the rational. For instance, 5/3 would be the string
-- "5/3".
--
instance Show MyRational where
  show (Frac n d) = show n ++ "/" ++ show d

--
-- Convert the fraction to a floating point value Returns the value as the
-- number as a floating point number. For example, 5/2 is 2.5, 1/3 is 0.3333,
-- etc. Hint: use fromIntegral.
--
toFloat :: MyRational -> Float
toFloat (Frac n d) = (fromIntegral n) / (fromIntegral d)

--
-- Implement an instance of == that test if two MyRationals are equal. Be
-- careful if either is not in lowest terms!
--
instance Eq MyRational where
  (Frac n1 d1) == (Frac n2 d2) | n1*d2 == n2*d1   = True
                               | otherwise        = False

--
-- Implement an instance of compare x y that tests if the MyRationals x and y
-- are the same (return EQ), or x is less than y (return LT), or x is greater
-- than y (return GT). Be careful with negative values, and when x or y is not
-- in lowest terms!
--
instance Ord MyRational where
  compare (Frac n1 d1) (Frac n2 d2) = compare (n1*d2) (n2*d1)

--
-- Return True if the given MyRational represents an integer, and False
-- otherwise. For example, 4/1, 21/3, and 0/99 are all integers.
--
isInt :: MyRational -> Bool
isInt (Frac n d) | n%d == 0   = True
                 | otherwise  = False

--
-- Adds two given MyRationals and returns a new MyRational that is there sum.
--
add :: MyRational -> MyRational -> MyRational
add (Frac n1 d1) (Frac n2 d2) = (makeRational (n1*d2+n2*d1) (d1*d2))

--
-- Multiplies two given MyRationals and returns a new MyRational that is there
-- product.
--
mult :: MyRational -> MyRational -> MyRational
mult (Frac n1 d1) (Frac n2 d2) = (makeRational (n1*n2) (d1*d2))

--
-- Divides two given MyRationals and returns a new MyRational that is there
-- quotient. Call the error function if division by zero would occur.
--
divide :: MyRational -> MyRational -> MyRational
divide (Frac n1 d1) (Frac n2 d2) | n2 == 0 = error "Two given rationals cannot be divided."
                                 | otherwise = (makeRational (n1*d2) (d1*n2))

--
-- Inverts a given MyRational and returns a new one with the numerator and
-- denominator switched. For example, 2/3 inverts to 3/2. Call the error
-- function for 0 numerators, e.g. 0/3 inverts to 3/0, which is not a
-- rational.
--
invert :: MyRational -> MyRational
invert (Frac n d) | d == 0 = error "The given rational cannot be inverted."
                  | otherwise = (makeRational d n)

--
-- Reduces a given MyRational and returns a new MyRational that is in lowest
-- terms. For example, 36/20 reduces to 9/5. Use the gcd function to help do
-- this. Be careful in the case where the numerator or denominator is
-- negative.
--
toLowestTerms :: MyRational -> MyRational
toLowestTerms (Frac n d) = (makeRational (div n (gcd (abs n) (abs d))) (div d (gcd (abs n) (abs d))))

--
-- Given an integer, return a rational equal to 1/1 + 1/2 + ... + 1/n.
--
-- For example:
--
-- > harmonicSum 25
-- 34052522467/8923714800
--
harmonicSum :: Integer -> MyRational
-- ...

--
-- Using insertion sort, list any list of values [a] for a type that
-- implements Ord.
--
-- For example:
--
-- > insertionSort [5,6,2,3,1,4]
-- [1,2,3,4,5,6]
--
-- > insertionSort ["one","two","three","four"]
-- ["four","one","three","two"]
--
-- > insertionSort [makeRational 2 2,makeRational 0 1,
--                  makeRational 4 5,makeRational (-1) 7]
-- [-1/7,0/1,4/5,2/2]
--
insert :: Ord a => a -> [a] -> [a]
insert x [] = [x]
insert x (y:ys) | x <= y    = x:y:ys
                | otherwise = y : (insert x ys)

insertionSort :: Ord a => [a] -> [a]
insertionSort []     = []
insertionSort (x:xs) = insert x (insertionSort xs)

-- randomList: Int -> IO([Int])
-- randomList 0 = return []
-- randomList n = do r  <- randomRIO (1,10000)
--                   rs <- randomList (n-1)
--                   return (r:rs) 

-- randomListPairs :: Int -> IO([(Int,Int)])
-- randomListPairs 0 = return []
-- randomListPairs n = do a <- randomRIO (1,10000)
--                       b <- randomRIO (1,10000)
--                       ps <- randomListPairs (n-1)
--                       return ((a,b):ps) 

-- randomStr :: Int -> IO String
-- randomStr size = replicateM size $ randomRIO ('a', 'z')

-- randomStrList :: Int -> IO([String])
-- randomStrList 0 = return []
-- randomStrList n = do r <- randomStr 10
--                         rs <- randomStrList (n-1)
--                         return (r:rs)

-- randomRationalList :: [(Int,Int)] -> [MyRational]
-- randomRationalList []           = []
-- randomRationalList ((n,d):rest) = ((makeRational (toInteger n) (toInteger d)):(randomRationalList rest))

--
-- When you're ready to test insertionSort, put a main function here that
-- calls it. See helloWorld.hs in the same folder for an example of how to do
-- this.
--
-- main = do 
-- putStrLn "Haskell!"
-- putStrLn "Calling insertionSort ..."
-- numLst4 <- randomList 4000
-- numLst5 <- randomList 5000
-- numLst6 <- randomList 6000
-- numLst7 <- randomList 7000
-- numLst8 <- randomList 8000
-- numLst9 <- randomList 9000
-- numLst10 <- randomList 10000
-- insertionSort numLst4

-- sLst1 <- randomStrList 1000
-- sLst2 <- randomStrList 2000
-- sLst3 <- randomStrList 3000
-- sLst4 <- randomStrList 4000
-- sLst5 <- randomStrList 5000
-- sLst6 <- randomStrList 6000
-- sLst7 <- randomStrList 7000
-- sLst8 <- randomStrList 8000
-- sLst9 <- randomStrList 9000
-- sLst10 <- randomStrList 10000
-- insertionSort sLst1

-- rPair1 <- randomListPairs 1000
-- insertionSort (randomRationalList rPair1)

-- rPair2 <- randomListPairs 2000
-- insertionSort (randomRationalList rPair2)

-- rPair3 <- randomListPairs 3000
-- insertionSort (randomRationalList rPair3)

-- rPair4 <- randomListPairs 4000
-- insertionSort (randomRationalList rPair4)

-- rPair5 <- randomListPairs 5000
-- insertionSort (randomRationalList rPair5)

-- rPair6 <- randomListPairs 6000
-- insertionSort (randomRationalList rPair6)

-- rPair7 <- randomListPairs 7000
-- insertionSort (randomRationalList rPair7)

-- rPair8 <- randomListPairs 8000
-- insertionSort (randomRationalList rPair8)

-- rPair9 <- randomListPairs 9000
-- insertionSort (randomRationalList rPair9)

-- rPair10 <- randomListPairs 10000
-- insertionSort (randomRationalList rPair10)