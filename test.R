

music_raw <- readLines("palestrina.txt")


head(music_raw[10:20])

#PSEUDOCODE

#preprocessing
preprocess <- function(x){

  #remove the initial metadata -Ben
  
  #remove the supplementary info from lines starting with # -Ben
  music_raw <- music_raw[!startsWith(music_raw, "#")]

  #separate pieces on the || symbol, replacing current blank line  
  music_raw[ music_raw == ""] <- "||"
  #separate lines on the | symbol, replacing current newline (except last line, which I think we can detect by presence of a blank next line?)
  ifelse (lead(music_raw) != "||") {
    music_raw <- paste(music_raw, sep = " ", "|") 
  }
  #separate notes on the space symbol
  
head(music_raw[10:20])
#model

#generation

