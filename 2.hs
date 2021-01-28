

-- Zadatak 2:
--
-- Napisati program koji iz fajla čija je putanja data kao argument 
-- komandne linije, čita brojeve jedan po jedan, svaki u zasebnom redu.
-- Program ispisuje sve brojeve poravnate udesno u odnosu na najduži
-- broj, a zatim podvlaku i sumu svih brojeva
--
-- Na primer, za fajl:
--
-- 1020
-- 10
-- 3
-- 8000
-- 2000
-- 1
--
-- Treba ispisati:
--
--      1020
--        10
--         3
--      8000
--      2000
--         1
--     -----
--     11034

import System.Environment

main :: IO ()
main = do 
    (fpath:_) <- getArgs
    contents <- readFile fpath
    putStrLn $ process $ contents

process :: String -> String
process contents = contentToReturn where 
    contentAddedNewlines = map (\x -> if x == '\n' then ' ' else x) contents
    contentSplitByNewlines = words $ contents
    contentCastToInt = map (\x -> read x :: Integer) contentSplitByNewlines
    sumOfContent = sum $ contentCastToInt
    lenSumOfContent = length $ show $ sumOfContent
    numOfDashes = replicate lenSumOfContent '-'
    contentAddedSpaces = map (\x -> replicate (lenSumOfContent - length x) ' ' ++ x) contentSplitByNewlines

    contentToReturn = foldl (\x y -> x ++ y ++ "\n") "" contentAddedSpaces ++ numOfDashes ++ "\n" ++ (show sumOfContent) ++ "\n"
