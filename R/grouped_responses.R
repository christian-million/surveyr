## Grouped Questions (Previously referred to as Matrix Questions)

## Start with just grouped "factor" questions. Then, incorporate other response types.

library(dplyr)
library(tidyr)

get_grouped <- function(...){
  
  colnames <- rlang::quos(...)
  
  cols <- as.character(sapply(colnames, rlang::quo_get_expr))
  
  grouped_cols <- schema$q_varname[schema$q_group %in% cols]
  
  out <- survey %>% 
          dplyr::select(one_of(grouped_cols))%>%
          tidyr::gather(key = "questions", value = "responses")
  
  out <- factor_cols(out, responses, lvls = list(agree_scale()))
  
  return(out)
}


plot_grouped_questions <- function(data){
  ggplot2::ggplot(data, ggplot2::aes(x = responses))+
    ggplot2::geom_bar()+
    ggplot2::facet_wrap(~ questions)+
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, hjust = 1))
}

