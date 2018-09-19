agree_scale <- function(reverse = FALSE){
  
  lvl <- c("Strongly Agree", "Agree", "Neither Agree or Disagree", 
           "Disagree", "Strongly Disagree")
   
  if(reverse){
   lvl <- rev(lvl)
  }
   
  return(lvl)
  
}


often_scale <- function(reverse = FALSE){
  
  lvl <- c("Very Often", "Often", "Sometimes", "Rarely", "Never")
   
  if(reverse){
   lvl <- rev(lvl)
  }

  return(lvl)
  
}
