###H: We should delete these!!!!
install.packages("tidyverse")
library(tidyverse)
music_raw <- readLines("palestrina.txt")
###H: Show the 10-20 lines, so I add 'n=11' to show or only show 6
head(music_raw[10:20], n=11)

#PSEUDOCODE

#preprocessing
preprocess <- function(x) {

  #remove the the first three lines
  x <- x[-(1:3)]
  
  #remove the supplementary info from lines starting with # -Ben
  #H: Ben, you should use x to express variable in here!!!!
  music_raw <- music_raw[startsWith(music_raw, "#")]

  #separate pieces on the || symbol, replacing current blank line  
  x <- str_replace(x, "^$", "||")
  
  #separate lines on the | symbol, replacing current newline (except last line, which I think we can detect by presence of a blank next line?)
  not_end <- x != "| |"
  next_is_end <- c(not_end[-1] == FALSE, FALSE)
  barline <- not_end & !next_is_end
  x[barline] <- paste(x[barline], "|")
  
  #separate notes on the space symbol
  tokens <- unlist(strsplit(x, split = "\\s+"))
  tokens <- tokens[tokens != ""]
  return(tokens)
}
music_raw <- preprocess(music_raw)


#generation