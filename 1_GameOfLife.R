#####
# Jerzy Wieczorek
# 36-750 Statistical Computing
# HW1: Game of Life
# 1/8/2015
#
# Program input: create a text file
# whose 1st line is a single positive integer
# (the number of generations to advance)
# and whose remaining lines are a binary matrix
# with 1s at live cells and 0s at dead cells.
# For example:
# 
# 2
# 010
# 111
# 010
# 
# Run the program from the command line using Rscript,
# with your input file as a final argument:
# > Rscript 1_GameOfLife.R myInputFile.txt
# 
# Output will be written to 1_GameOfLife_Out.txt
#####

#####
# Define functions

# updateG returns the matrix G, updated once,
# based on the number of living neighbors of each cell
updateG <- function(G){
  Nbrs <- countNeighbors(G)
  # Loop over each cell
  for(cell in 1:prod(dim(G))){
    if (Nbrs[cell]==2 & G[cell]==1) {
      # If has 2 neighbors and is already alive,      
      # remain alive (i.e. do no update)
    } else if (Nbrs[cell]==3) {
      # Else if has 3 neighbors, make sure it's alive
      G[cell]=1
    } else G[cell]=0 # Else it dies
  }
  return(G)
}

# countNeighbors returns a matrix the same shape as G
# where each cell contains the nr of living neighbors
# of the corresponding cell in G
countNeighbors <- function(G){
  Nbrs <- G
  rows <- nrow(G)
  cols <- ncol(G)
  for(i in 1:rows){
    for(j in 1:cols){
      # Set the up/down and left/right limits of indices
      # of neighbors of the current cell
      U = max(1,i-1); D = min(rows,i+1)
      L = max(1,j-1); R = min(cols,j+1)
      # Check for life in that 3x3 square, but ignore the current cell
      Nbrs[i,j] = sum(G[U:D,L:R]) - G[i,j]
      # An alternate "cleaner" sol'n because does not subtract middle index,
      # though in fact messier code to read and probably not any faster:
      #Nbrs[i,j] = sum(G[as.matrix(expand.grid(U:D,L:R)[-5])])
    }
  }
  return(Nbrs)
}

#####
# Read in command line arguments
args <- commandArgs(trailingOnly = TRUE)

#####
# Check command line arguments:
# should be just one, the name of the input text file
stopifnot(length(args)==1)
cat(paste0("Input file: ", args, "\n"))
inputfile <- args

#####
# Read in and check the contents of the text file

# First line should be a positive integer,
# the number of generations to advance
ngen <- scan(inputfile, n=1, quiet=TRUE)
stopifnot(is.numeric(ngen))
ngen <- as.integer(ngen)
stopifnot(ngen>0)
cat(paste0("Nr generations to advance: ", ngen, "\n"))

# Second line should be first row of G matrix:
# figure out how many columns it has
ncol <- nchar(scan(inputfile, what=character(), skip=1, n=1, quiet=TRUE))

# Read in the entire matrix in fixed-width format
G <- as.matrix(read.fwf(inputfile, skip=1, widths=rep(1,ncol)))
stopifnot(is.numeric(G))
stopifnot(all(G %in% 0:1))
cat("Initial state:\n")
cat(t(G), fill=ncol, sep="")

#####
# Loop over generations:
for(gen in 1:ngen){
  # Count neighbors and update status
  G <- updateG(G)
}
cat("Final state:\n")
cat(t(G), fill=ncol, sep="")

#####
# Write output to a text file
write.table(G, "1_GameOfLife_Out.txt", sep="",
            row.names=FALSE, col.names=FALSE)
