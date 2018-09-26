## Run this file when starting up

survey <- read.csv("data/sample/sample_survey.csv", stringsAsFactors = FALSE)
schema <- read.csv("data/sample/sample_schema.csv", stringsAsFactors = FALSE)

source("R/scale_templates.R")
