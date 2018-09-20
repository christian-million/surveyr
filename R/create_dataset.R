# Create Data Set From Survey Monkey Extract
# Use the Compact Column Extract From Survey Monkey

# Necessary Packages
library(readxl)
library(dplyr)
library(tidyr)

# Load Necessary Data
raw <- read_xlsx("data/raw/svdg_raw.xlsx")

schema <- read.csv("data/clean/svdg_schema.csv", stringsAsFactors = FALSE)

# Rename Variables Using SCHEMA Dataset
colnames(raw) <-  schema$q_varname

# Remove First Row
raw <- raw %>%
        filter(!is.na(id))

# Combine Roles Assumed (i.e., multiple choice answers)
clean <- raw %>%
        unite("roles_assumed", roles_assumed:roles_assumed7, sep = ";", remove = TRUE)%>%
        mutate(roles_assumed = gsub("NA;","",gsub(";NA","",roles_assumed)),
               roles_identified = coalesce(roles_identified, roles_identified_desc))%>%
        select(-c(roles_identified_desc))

# Write to file
write.csv(clean, file = "data/clean/svdg_clean.csv", row.names = FALSE)
