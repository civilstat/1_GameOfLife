# HW_0
36-750 Stat Computing HW_0: Conway's Game Of Life

Task:
* Your program should accept as input a text file giving an initial state G for the grid of cells and the number n of generations to simulate.
* Your program should produce text output giving the grid’s state n generations after G.
* You should include one to three distinct input files on which your program runs. If the input/output format will be unclear to a typical observer, please include a brief explanation.

Program input: create a text file whose 1st line is a single positive integer (the number of generations to advance) and whose remaining lines are a binary matrix with 1s at live cells and 0s at dead cells.
For example:

```
2
010
111
010
```

Run the program from the command line using Rscript,
with your input file as a final argument:
> Rscript 0_GameOfLife.R myInputFile.txt

Output will be written to 0_GameOfLife_Out.txt