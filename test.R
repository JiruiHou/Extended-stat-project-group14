
music_raw <- readLines("palestrina.txt")
###H: Show the 10-20 lines, so I add 'n=11' to show or only show 6
head(music_raw[10:20], n=11)

#PSEUDOCODE

#preprocessing
preprocess <- function(x){

  #remove the the first three lines
  x <- x[-(1:3)]
  
  #remove the supplementary info from lines starting with # -Ben

  x <- x[!startsWith(x, "#")]

  #separate pieces on the || symbol, replacing current blank line  

  x[x == ""] <- " ||"

  
  #separate lines on the | symbol, replacing current newline (except last line, which I think we can detect by presence of a blank next line?)
  not_end <- x != " ||"
  next_is_end <- c(not_end[-1] == FALSE, FALSE)
  barline <- not_end & !next_is_end
  x[barline] <- paste(x[barline], "|")
  
  #separate notes on the space symbol
  tokens <- unlist(strsplit(x, split = "\\s+"))
  tokens <- tokens[tokens != ""]
  return(tokens)
}
music_clean <- preprocess(music_raw) 
tail(music_clean, n = 10)
notes <- unique(music_clean) #creates a table of unique notes

tokens <- match(x=music_clean, table = notes) # matches notes to their indices in the table of unique notes

#making matrices
make_matrix <- function(tokens, end, mlag = 4) {
  #for the sake of comprehensibility I'm going to feed columns into the vector that 
  #becomes our matrix one at a time. If we were doing this at much larger scale there might be a more efficient vectorized method
  temp <- vector()
  
  temptokens<- tokens
  for (i in (0:mlag)) { #creates the token vector minus the last mlag elements, then iterates over shifted versions of the token vector
    temptokens <- tokens[seq_along(tokens) > i]
    temp <-  append(temp, temptokens[1:(length(temptokens)-(mlag-i))])
    
    
  }
  M <- matrix ( temp, nrow = length(tokens) -mlag, ncol = mlag + 1)
  #now we need to filter out the rows that contain the stop sequence
  print("which1")
  print(which(M[,1:mlag] == end, arr.ind = TRUE))

  M <- M[rowSums(M[,1:mlag] == end) == 0,]
  print("which2")
  print(which(M[,1:mlag] == end, arr.ind = TRUE))
  
  
}
make_matrix(tokens, end = which(notes=="||"), 4)
#generation