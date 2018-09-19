library(ggplot2)
library(dplyr)
library(tidyr)

tidy_clean <- clean %>%
              gather("questions", "answers", roles_assumed:final_comments)

q_ret <- tidy_clean %>% filter(grepl("^ret", questions))

q_ret$answers <- factor(q_ret$answers,
                        levels = agree_scale())

q_ret <- q_ret%>%filter(!is.na(answers))

ggplot(q_ret, aes(x = answers))+
  geom_bar()+
  facet_wrap(~ questions)+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))