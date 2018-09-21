library(ggplot2)
library(dplyr)
library(tidyr)

survey <- read.csv("data/clean/svdg_clean.csv", stringsAsFactors = FALSE)


## Matrix Questions are just a group of questions with the same response variables and preamble.
## Structuring them in a matrix saves space and cognitive load for the survey respondent.
## Consider Changing "Matrix" to something a little more evocative and distinct.
get_matrix_questions<- function(data, lead_chars, scale = NULL){
  
  dataFrame <- data %>%
               dplyr::select(dplyr::starts_with(lead_chars)) %>%
               tidyr::gather(questions, responses, dplyr::starts_with(lead_chars))
  
  if(!is.null(scale)){
   dataFrame$responses <- factor(dataFrame$responses, levels = response_scale(scale))
  }
              
  dataFrame
}

## Examples
#get_matrix_questions(survey, "ret_", scale = "agree")%>%
#  filter(!is.na(responses))

plot_matrix_questions <- function(data){
  ggplot2::ggplot(data, ggplot2::aes(x = responses))+
    ggplot2::geom_bar()+
    ggplot2::facet_wrap(~ questions)+
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, hjust = 1))
}

## Examples
#plot_matrix_questions(get_matrix_questions(survey, "ret_", scale = "agree")%>%filter(!is.na(responses)))
