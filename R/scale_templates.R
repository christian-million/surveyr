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

response_scale <- function(scale = NULL, reverse = FALSE){
  
  if(scale == "agree"){
    agree_scale(reverse)
  }
  
  if(scale == "often"){
    often_scale(reverse)
  }
  
  return(lvl)
  
}

## Best way to incorporate functions into a general function? i.e., how to generalize formals of response scale?