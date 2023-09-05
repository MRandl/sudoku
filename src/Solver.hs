module Solver(solveSudoku) where

import Parser ( Sudoku )
import Data.Maybe (listToMaybe, mapMaybe)

import qualified Data.Vector as Boxed
import Data.Vector ((!), update, singleton)

solveSudoku :: Sudoku -> Maybe Sudoku
solveSudoku s = 
    if checkPosition s then
        solvePosition (0, 0) s
    else 
        Nothing

solvePosition :: (Int, Int) -> Sudoku -> Maybe Sudoku
solvePosition (i, j) s =
    -- recursion invariant : 'checkPosition s' must be proven by caller
    let nextPos = if j == 8 then (i+1, 0) else (i, j+1) in
    let isDone = i == 8 && j == 8 in
    if s ! i ! j /= 0 then
        if isDone then
            -- you've been given a filled sudoku grid, just return it
            Just s 
        else
            -- the square being investigated is already populated, go to next
            solvePosition nextPos s
    else
        let candidates = map (updateCoordinate (i, j) s) [1..9] in
        let successSolved = filter checkPosition candidates in
        if isDone then
            -- that was the last square, return first immediate solution if any
            listToMaybe successSolved
        else
            -- recurse further on children, return first solution if any
            listToMaybe $ mapMaybe (solvePosition nextPos) successSolved

-- set the entry of a grid at a given position to contain a new value
updateCoordinate :: (Int, Int) -> Sudoku -> Int -> Sudoku
updateCoordinate (i, j) s newval =
    let replace ind element vec = update vec (singleton (ind, element)) in
    let newline =  replace j newval (s ! i) in
    replace i newline s

-- checks that the sudoku does not contain contradictions (even before being filled entirely).
-- this is used for early backtracking
checkPosition :: Sudoku -> Bool
checkPosition s =
    let rowsOk = all (`checkRow` s) [0..8] in
    let colsOk = all (`checkColumn` s) [0..8] in
    let squaresOk = all (`checkSquare` s) [0..8] in
    rowsOk && colsOk && squaresOk

checkRow :: Int -> Sudoku -> Bool
checkRow i grid = checkNoDouble $ grid ! i

checkColumn :: Int -> Sudoku -> Bool
checkColumn j grid = checkNoDouble (Boxed.map (! j) grid)

-- checks that the i-th square (in reading order) does not contain the same 
-- number twice
checkSquare :: Int -> Sudoku -> Bool
checkSquare index grid =
    let access3next list ind = [list ! (ind * 3), list ! (ind * 3 + 1), list ! (ind * 3 + 2)] in
    let usefulLines = access3next grid (div index 3) in
    let usefulSubLines = map (\l -> Boxed.fromList $ access3next l (mod index 3)) usefulLines in
        checkNoDouble $ Boxed.concat usefulSubLines

checkNoDouble :: Boxed.Vector Int -> Bool
checkNoDouble l = all (\n -> count l n < 2) [1..9]

count :: Boxed.Vector Int -> Int -> Int
count vec i = Boxed.foldr (\curr acc -> if curr == i then acc + 1 else acc) 0 vec