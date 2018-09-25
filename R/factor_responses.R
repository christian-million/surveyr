## Handling Factor and/or Ordered Factor Questions

## A couple thoughts:
  # Function to factor columns and vary levels
  # Then a get_factor_question function with factor_col embedded

library(dplyr)
survey <- read.csv("data/clean/svdg_clean.csv", stringsAsFactors = FALSE)
factor_df <- survey %>%
              select(id, member_length, ret_feel_connected, ret_skills_recognized, non_derby_participation)

# Function to factor columns with levels
factor_cols <- function(data, ..., lvls){

  df <- data
  cols <- sapply(substitute(list(...)),deparse)[-1]
  
  if (missing(lvls)){
    
    y <- Map(unique, df[cols])
    ind <- sapply(y, order)
    lvls_lst <- Map(function(x, i)unique(as.character(x)[i]), y, ind)
    
  } else if(length(lvls) == length(cols)){
    
    lvls_lst <- lvls
    
  } else {
    
   stop("# of Levels Does Not Equal Number of Columns")
  
  }
  
  df[cols] <- Map(factor, x = df[cols], levels = lvls_lst)
  
  return(df)
  
}

#Examples
#test <- factor_cols(data = factor_df, member_length, ret_skills_recognized, lvls = test_lvls)
#test_lvls <-  list(c("0 - 6 months","6 months -  1 year","1 - 2 years","2 - 3 years","5+ years","Butt"),c(response_scale("agree"), "B"))
#test <- factor_cols(data = factor_df, member_length, ret_skills_recognized)



get_factors <- function(...){
    factor_response_qs <- schema$q_varname[schema$q_type %in% c("factor", "ordered", "other_factor")]
    
    columns <- quos(...)
    
    if(length(columns) == 0){
      
      columns <- factor_response_qs
      
      out <- survey %>% select(one_of(columns))
    
    } else {
      out <- survey %>% select(!!!columns)
    }
    
   return(out) 
}

#get_factors(member_length)
