## Handling Factor and/or Ordered Factor Questions

## A couple thoughts:
  # Function to factor columns and vary levels
    # For factor_cols add "add level" argument to add 1 level to end of unique()
  # Then a get_factor_question function with factor_col embedded

#library(dplyr)

# Function to factor columns with levels
factor_cols <- function(data, ..., lvls){

  df <- data
  colnames <- rlang::quos(...)
  cols <- as.character(sapply(colnames, rlang::quo_get_expr))

    if (missing(lvls)){

      y <- Map(unique, df[cols])
      ind <- lapply(y, order)
      lvls_lst <- Map(function(x, i)unique(as.character(x)[i]), y, ind)

    } else if(length(lvls) == length(cols)){

      lvls_lst <- lvls

    } else {

     stop("# of Levels Does Not Equal Number of Columns")

    }

  df[cols] <- Map(factor, x = df[cols], levels = lvls_lst)

  return(df)

}


get_factors <- function(..., factor_lvls = NULL){
    factor_response_qs <- schema$q_varname[schema$q_type == "binary" |
                                           schema$q_type == "ordinal" |
                                           schema$q_type == "categorical"]
    columns <- quos(...)

    if(is.null(factor_lvls)){
      fctr <- NULL
      } else if(is.logical(factor_lvls)){
      fctr <- TRUE
      } else if(is.list(factor_lvls)){
      fctr <- "okay"
      }

    if(length(columns) == 0){

      columns <- factor_response_qs

      out <- survey %>% select(one_of(columns))

    } else {
      out <- survey %>% select(!!!columns)
    }


    if(!is.null(fctr)){
      if(fctr == TRUE){
      out <- factor_cols(data = out, !!!columns)
      } else {
      out <- factor_cols(data = out, !!!columns, lvls = factor_lvls)
      }
    }

   return(out)
}

