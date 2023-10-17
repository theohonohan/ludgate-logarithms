import qualified Data.Map as Map
import Data.List
import Control.Monad.State
import Control.Monad

all_digital_products = [x*y | x <- [1..maxdigit], y <- [1..maxdigit]]

type Number = Int
type Index = Int
type Factors = [Number]
type Table = Map.Map Number Index

products :: Table
products = Map.fromList [(1,0)]

maxdigit = 9

primes :: [Number]
primes = [2,3,5,7,11]

------ appalling linear search code

table_to_probe_list :: [Number] -> Table -> [Index]
table_to_probe_list (d:ds) m = case (d >= 1) && (d <= maxdigit) of
                                 True -> (Map.findWithDefault 0 d m):table_to_probe_list ds m
                                 False -> table_to_probe_list ds m
table_to_probe_list _ _ = []

scan_for_slot candidate indices m = case (all ((==) False) (test_range (offset_by_candidate indices candidate) m)) of
                                         True -> candidate
                                         False -> scan_for_slot (candidate+1) indices m

offset_by_candidate indices candidate = map ((+) candidate) indices

test_range indices m = map test indices
                       where elems = Map.elems m
                             test = \i -> elem i elems

------- appalling linear search code ends

alloc :: [Factors] -> Number -> StateT Table IO [Factors]
alloc existing_digits new_prime_digit = do
  m <- get
  let i2 = table_to_probe_list (map product existing_digits) m
  let s2 = scan_for_slot 0 i2 m
  modify (Map.insert new_prime_digit s2)

  let new_digits = new_digit_as_prime_factors new_prime_digit

  let new_products = [x ++ y | x <- existing_digits, y <- new_digits, 1 < (product x) * (product y) && (product x) * (product y) <= maxdigit*maxdigit]

  let new_valid_products = filter (\n -> elem (product n) all_digital_products) new_products

  traverse assign_index new_valid_products

  return (existing_digits ++ (filter (\d -> product d <= maxdigit) new_products))

assign_index :: [Number] -> StateT Table IO ()
assign_index n = modify (\s -> Map.insert (product n) (sum $ map (\f -> Map.findWithDefault 0 f s) n) s)

new_digit_as_prime_factors p = takeWhile (\d -> (product d) <= 81) $ powers p
powers n = iterate ((:) n) [n]

assign :: Factors -> Table -> Table
assign n m = Map.insert (product n) (foldl' (\v z -> v + case (Map.lookup z m) of Just(d) -> d) 0 n) m


digits :: [Factors]
digits = [[]]

main :: IO ()
main = do
   s <- runStateT (foldM alloc digits primes) (Map.fromList [(1,0)])
   putStrLn $ show s
