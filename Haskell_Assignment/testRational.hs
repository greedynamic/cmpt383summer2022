import System.Random (randomRIO)
data MyRational = Frac Integer Integer

makeRational :: Integer -> Integer -> MyRational
makeRational n d | d == 0    = error "Denominator cannot be zero."
                 | otherwise = Frac n d

getNum :: MyRational -> Integer
getNum (Frac n d) = n

getDenom :: MyRational -> Integer
getDenom (Frac n d) = d

pair :: MyRational -> (Integer, Integer)
pair (Frac n d) = (n, d)

instance Show MyRational where
  show (Frac n d) = show n ++ "/" ++ show d

toFloat :: MyRational -> Float
toFloat (Frac n d) = (fromIntegral n) / (fromIntegral d)

instance Eq MyRational where
  (Frac n1 d1) == (Frac n2 d2) | n1*d2 == n2*d1   = True
                               | otherwise        = False

instance Ord MyRational where
  compare (Frac n1 d1) (Frac n2 d2) = compare (n1*d2) (n2*d1)

isInt :: MyRational -> Bool
isInt (Frac n d) | mod n d == 0   = True
                 | otherwise  = False

add :: MyRational -> MyRational -> MyRational
add (Frac n1 d1) (Frac n2 d2) = (makeRational (n1*d2+n2*d1) (d1*d2))

mult :: MyRational -> MyRational -> MyRational
mult (Frac n1 d1) (Frac n2 d2) = (makeRational (n1*n2) (d1*d2))

divide :: MyRational -> MyRational -> MyRational
divide (Frac n1 d1) (Frac n2 d2) | n2 == 0 = error "Two given rationals cannot be divided."
                                 | otherwise = (makeRational (n1*d2) (d1*n2))

invert :: MyRational -> MyRational
invert (Frac n d) | d == 0 = error "The given rational cannot be inverted."
                  | otherwise = (makeRational d n)

toLowestTerms :: MyRational -> MyRational
toLowestTerms (Frac n d) = (makeRational (div n (gcd (abs n) (abs d))) (div d (gcd (abs n) (abs d))))

harmonicSum :: Integer -> MyRational
harmonicSum n =  calcHarmonicSum [1 .. n]

calcHarmonicSum :: [Integer] -> MyRational
calcHarmonicSum [] = makeRational 0 1
calcHarmonicSum (x:xs) = add (makeRational 1 x) (toLowestTerms (calcHarmonicSum xs))

insert :: Ord a => a -> [a] -> [a]
insert x [] = [x]
insert x (y:ys) | x <= y    = x:y:ys
                | otherwise = y : (insert x ys)

insertionSort :: Ord a => [a] -> [a]
insertionSort []     = []
insertionSort (x:xs) = insert x (insertionSort xs)

randomList :: Int -> IO([Int])
randomList 0 = return []
randomList n = do r  <- randomRIO (1,5)
                  rs <- randomList (n-1)
                  return (r:rs) 

randomListPairs :: Int -> IO([(Int,Int)])
randomListPairs 0 = return []
randomListPairs n = do a <- randomRIO (1,10000)
                       b <- randomRIO (1,10000)
                       ps <- randomListPairs (n-1)
                       return ((a,b):ps) 


main =  do
let x = makeRational 1 3
let r0 = makeRational 2 6
let r1 = makeRational 2 3
let r2 = makeRational 6 3
let r3 = makeRational 8 3
putStrLn (show x)
putStrLn (show r0)
putStrLn (show r1)
print x
let y = getNum x
putStrLn (show y)
let z = toFloat(x)
putStrLn (show z)
print(x == r0)
print(compare x r0)
print(compare x r1)
print(compare r1 x)
putStrLn "isInt"
print(isInt r0)
print(isInt r2)
putStrLn "add"
print(add x r1)
putStrLn "mult"
print(mult x r1)
putStrLn "divide"
print(divide x r1)
putStrLn "invert"
print(invert r3)
putStrLn "toLowestTerms"
print(toLowestTerms r0)
print(harmonicSum 10)
putStrLn "Hello!"
putStrLn ""
putStrLn "Here's a list of 5 random numbers:"
lst <- randomList 5
putStrLn (show lst)