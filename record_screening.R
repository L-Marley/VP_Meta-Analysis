setwd("~/VP_Meta-Analysis/Screening")

#### Packages ####

library(metagear)
library(tidyverse)

#### Loading the Screening Data ####

records_unscreened <- read.csv("Zotero_Export.csv", header = TRUE)

records_unscreened <- effort_initialize(records_unscreened)

records_unscreened <- effort_distribute(records_unscreened, reviewers = "Liam", save_split = TRUE)

#### Begin screening abstracts ####

abstract_screener("effot_Liam.csv", aReviewer = "Liam", abstractColumnName = "Abstract", titleColumnName = "Title")