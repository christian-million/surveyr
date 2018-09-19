## Handling Open Ended Questions

library(dplyr)
library(tidytext)
library(wordcloud)

clean <- read.csv("data/clean/svdg_clean.csv", stringsAsFactors = FALSE)


openize <- function(data, column, n = 1){
  
  open_col <- enquo(column)
  dataFrame <- data
  
  
  tok_df <- dataFrame %>%
            select(new_col = UQ(open_col))
  
  tok_df <- tok_df %>%
              dplyr::filter(!is.na(new_col)) %>%
              tidytext::unnest_tokens(word, new_col, token = "ngrams", n = n) %>%
              dplyr::anti_join(stop_words) %>%
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

#Find best way to handle ... arguments passed to sub-functions

#Examples
#openize(clean, svdg_actions, n=2)
#my_wordcloud(clean, svdg_actions, n = 1, min.freq = 2, max.words = 20)
