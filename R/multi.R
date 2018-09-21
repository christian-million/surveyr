# Multiple Choice Funciton
# Stolen From https://github.com/dgrtwo/stacksurveyr/blob/master/R/stack_multi.R


# Does it really need STRINGR?
multi <- function(columns = NULL) {
  
  multi_response_qs <- schema$q_varname[schema$q_type == "multi"]

  if (is.null(columns)) {
    columns <- multi_response_qs
  } else {
    dif <- setdiff(columns, multi_response_qs)
    if (length(dif) > 0) {
      stop(dif[1], " is not a multi-response column in survey")
    }
  }

  survey %>%
    dplyr::select(id, dplyr::one_of(columns)) %>%
    tidyr::gather(q_varname, responses, -id) %>%
    dplyr::filter(!is.na(responses)) %>%
    tidyr::unnest(responses = stringr::str_split(responses, ";"))
}
