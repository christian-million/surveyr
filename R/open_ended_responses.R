## Handling Open Ended Questions

library(dplyr)
library(tidytext)
library(wordcloud)

survey <- read.csv("data/clean/svdg_clean.csv", stringsAsFactors = FALSE)

## Get Open Ended Questions

# Takes Column Names
# If no argument, then gets all open ended questions

get_open <- function(data = survey, ...){
    
    if(!missing(data)){
      survey <- data
    }
    
    open_response_qs <- schema$q_varname[schema$q_type == "open"]
    columns <- sapply(substitute(list(...)), deparse)[-1]
    
    if(length(columns) == 0){
      columns <- open_response_qs
    }
    
    survey %>%
        select(one_of(columns))
}

#get_open(first_learn, why_join, svdg_actions)

openize <- function(data, column, n = 1){
  
  open_col <- rlang::enquo(column)
  dataFrame <- data
  
  
  tok_df <- dataFrame %>%
            dplyr::select(new_col = UQ(open_col))
  
  tok_df <- tok_df %>%
              dplyr::filter(!is.na(new_col)) %>%
              tidytext::unnest_tokens(word, new_col, token = "ngrams", n = n) %>%
              dplyr::anti_join(tidytext::stop_words) %>%
              dplyr::count(word, sort = TRUE)
  
  return(tok_df)
}

my_wordcloud <- function(data, column, n = 1, ...){
  
  open_col <- rlang::enquo(column)
  dataFrame <- data
  
  wordcloud::wordcloud((openize(dataFrame, UQ(open_col), n))$word,
                       (openize(dataFrame, UQ(open_col), n))$n,
                       ...)
  }

# Find best way to handle ... arguments passed to sub-functions

#Examples
#openize(survey, svdg_actions, n=2)
#my_wordcloud(survey, svdg_actions, n = 1, min.freq = 2, max.words = 20)
