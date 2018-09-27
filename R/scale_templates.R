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
  lvl <- agree_scale(reverse)
  }

  if(scale == "often"){
  lvl <- often_scale(reverse)
  }

  return(lvl)

}

## Best way to incorporate functions into a general function? i.e., how to generalize formals of response scale?
## Also, try to make response scale look to the environment above it
## to see if it can grab a unique() list of the responses.
