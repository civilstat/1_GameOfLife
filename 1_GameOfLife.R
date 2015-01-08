#####
# Jerzy Wieczorek
# 36-750 Statistical Computing
# HW1: Game of Life
# 1/8/2015
#
# For program input, create a text file
# whose 1st line is a single positive integer
# (n, the number of generations to advance)
# and whose remaining lines are a binary matrix
# with 1s at live cells and 0s at dead cells.
# For example:
# 
# 3
# 010
# 111
# 010
# 
# Run the program from the command line like so:
# Rscript 1_GameOfLife.R myInputFile.txt
# 
# Output will be written to 1_GameOfLife_Out.txt
#####

# Read in command line arguments
args <- commandArgs(trailingOnly = TRUE)

# Check command line arguments:
# should be just one, the name of the input text file
print(args)
inputfile <- args

# Read in and check the contents of the text file
ngen <- scan(inputfile, n=1)
print(ngen)

ncol <- nchar(scan(inputfile, what=character(), skip=1, n=1))

G <- as.matrix(read.fwf(inputfile, skip=1, widths=rep(1,ncol)))
print(G)

# Loop over generations:
# Count neighbors and update status

# Write output to a text file
write.table(G, "1_GameOfLife_Out.txt", sep="",
            row.names=FALSE, col.names=FALSE)
