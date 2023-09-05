# sudoku
I once got humiliated by a hard sudoku on the screen at the back of an airplane 
seat. I built this program to avenge me. It does it well.

# to run
Write your sudoku problem in [sudoku_input.txt](sudoku_input.txt). 
An example is provided for you.
You may then call ``stack run`` and observe the result in the standard output.
Any sudoku with a solution will be solved, any sudoku without one will be
reported as such by this program. Easy sudokus are solved instantly, 
very hard ones in a few seconds.


This requires [Stack](https://docs.haskellstack.org/en/stable/), the main 
Haskell package manager/build tool.

Note: Your first build might require an internet connection to 
download library deps. 

Note 2: To avoid downloading a whole compiler, you might want
to bump the compiler version number in [stack.yaml](stack.yaml) to one that you
have installed locally.

# license
This is licensed under the Creative Commons Zero license. See the LICENSE file.