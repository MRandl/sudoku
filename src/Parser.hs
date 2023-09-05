module Parser (Sudoku, parseSudoku) where

import qualified Data.Vector as Boxed

type Sudoku = Boxed.Vector (Boxed.Vector Int)

parseSudoku :: String -> Maybe Sudoku
parseSudoku input =
    let allLines = (traverse parseLine . lines) input in -- traverse here is [Maybe a] -> Maybe [a]
    case allLines of
        Just x | length x == 9 -> Just $ Boxed.fromList x
        _ -> Nothing

parseLine :: String -> Maybe (Boxed.Vector Int)
parseLine s | length s == 9 = Just $ Boxed.fromList $ map parseChar s
parseLine _ = Nothing

parseChar :: Char -> Int
parseChar s
    | s `elem` ['1' .. '9'] = read [s]
    | otherwise = 0