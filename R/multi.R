# Multiple Choice Funciton
# Stolen From https://github.com/dgrtwo/stacksurveyr/blob/master/R/stack_multi.R

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

  clean %>%
    dplyr::select(id, one_of(columns)) %>%
    tidyr::gather(q_varname, answer, -id) %>%
    dplyr::filter(!is.na(answer)) %>%
    tidyr::unnest(answer = stringr::str_split(answer, ";"))
}
