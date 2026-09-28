install.packages("tidyverse")
library(tidyverse)
music_raw <- readLines("palestrina.txt")


head(music_raw[10:20])

#PSEUDOCODE

#preprocessing
preprocess <- function(x) {

  #remove the initial metadata -Ben
  
  #remove the supplementary info from lines starting with # -Ben
  music_raw <- music_raw[startsWith(music_raw, "#")]

  #separate pieces on the || symbol, replacing current blank line  
  x <- str_replace(x, "^$", "||")
  #separate lines on the | symbol, replacing current newline (except last line, which I think we can detect by presence of a blank next line?)
  next_is_piece_end <- lead(x) =="||" | is.na(lead(x))
  is_measure <- x != "||" & !next_is_piece_end
  x[is_measure] <- paste0(x[is_measure]," |")
  #separate notes on the space symbol
  return(x)
}
music_raw <- preprocess(music_raw)


#generation

