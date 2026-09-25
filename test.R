

music_raw <- readLines("palestrina.txt")


head(music_raw[10:20])

#PSEUDOCODE

#preprocessing
  #remove the initial metadata
  #remove the supplementary info from lines starting with #
  #separate pieces on the || symbol
  #separate lines on the | symbol
  #separate notes on the space symbol
#model

#generation

