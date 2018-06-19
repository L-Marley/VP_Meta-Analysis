setwd("~/VP_Meta-Analysis/Screening")

#### Packages ####

library(metagear)
library(tidyverse)

#### Loading the Screening Data ####

records_unscreened <- read.csv("Zotero_Export.csv", header = TRUE)

records_unscreened <- effort_initialize(records_unscreened)

records_unscreened <- effort_distribute(records_unscreened, reviewers = "Liam", save_split = TRUE)

#### Begin screening abstracts ####

abstract_screener("effort_Liam.csv", aReviewer = "Liam", abstractColumnName = "Abstract.Note", titleColumnName = "Title")

records_screened <- read.csv("effort_Liam.csv", header = TRUE)
write.csv(records_screened, "all_records_firstscreen_Liam.csv")
