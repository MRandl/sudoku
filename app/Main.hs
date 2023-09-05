module Main (main) where

import Parser (parseSudoku)
import Solver (solveSudoku)
import Printer (showMaybeSudoku)

main :: IO ()
main = do
    contents <- readFile "sudoku_input.txt"
    let solved = parseSudoku contents >>= solveSudoku
    putStrLn ""
    putStrLn $ showMaybeSudoku solved