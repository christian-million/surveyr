## Handling Open Ended Questions

#library(dplyr)
#library(tidytext)
#library(wordcloud)

## Get Open Ended Questions

# Takes Column Names
# If no argument, then gets all open ended questions

get_open <- function(...){

    open_response_qs <- schema$q_varname[schema$q_type == "open"]

    columns <- quos(...)

    if(length(columns) == 0){

      columns <- open_response_qs

      out <- survey %>% select(one_of(columns))

    } else {
      out <- survey %>% select(!!!columns)
    }

   return(out)
}

openize <- function(column, n = 1){

  column1 <- rlang::enquo(column)

  tok_df <- get_open(!!column1)

  tok_df <- tok_df %>%
              dplyr::filter(!is.na(!!column1)) %>%
              tidytext::unnest_tokens(word, !!column1, token = "ngrams", n = n) %>%
              dplyr::anti_join(tidytext::stop_words) %>%
              dplyr::count(word, sort = TRUE)

  return(tok_df)
}

my_wordcloud <- function(data, column, n = 1, ...){

  open_col <- rlang::enquo(column)
  dataFrame <- data

  wordcloud::wordcloud((openize(UQ(open_col), n))$word,
                       (openize(UQ(open_col), n))$n,
                       ...)
  }

# Find best way to handle ... arguments passed to sub-functions

#Examples
#openize(open1, n=2)
#my_wordcloud(survey, open1, n = 2, min.freq = 2, max.words = 20)
