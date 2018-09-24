## Handling Factor and/or Ordered Factor Questions

## A couple thoughts:
  # Function to factor columns and vary levels
  # Then a get_factor_question function with factor_col embedded

library(dplyr)
survey <- read.csv("data/clean/svdg_clean.csv", stringsAsFactors = FALSE)
factor_df <- survey %>%
              select(id, member_length, ret_feel_connected, ret_skills_recognized, non_derby_participation)

# Function to factor columns with levels
factor_cols <- function(data, ..., lvls = NULL){

  df <- data
  
  cols <- sapply(substitute(list(...)),deparse)[-1]
  
  lvls_lst <- lvls
  
  df[cols] <- Map(factor, x = df[cols], levels = lvls_lst)
  
  return(df)
  
}

#Example

test <- factor_cols(data = factor_df, member_length, ret_skills_recognized, 
                    lvls = list(c("0 - 6 months",
                                    "1 - 2 years",
                                    "2 - 3 years",
                                    "5+ years",
                                    "6 months -  1 year",
                                    "Butt"),
                                  c(response_scale("agree"), "B")))