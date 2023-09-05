module Printer (showSudoku, showMaybeSudoku) where

import Parser (Sudoku)
import qualified Data.Vector as Boxed


showMaybeSudoku :: Maybe Sudoku -> String
showMaybeSudoku Nothing = "FAILED SOLVING"
showMaybeSudoku (Just s) = showSudoku s

showSudoku :: Sudoku -> String
showSudoku = concatMap ((++ "\n") . showline)

showline :: Boxed.Vector Int -> String
showline = Boxed.foldr (\i b -> showEntry i ++ " " ++ b) ""

showEntry :: Int -> String
showEntry i
    | i `elem` [0..9] = show i
    | otherwise = "?"