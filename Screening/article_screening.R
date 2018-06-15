setwd("~/VP_Meta-Analysis/Screening")

#### Packages ####
library(metagear)
library(tidyverse)

journal_unscreened <- read.csv("journal_articles.csv")

journal_unscreened <- effort_initialize(journal_unscreened)

journal_unscreened <- rename(journal_unscreened, Authors = ï..Authors)

journal_unscreened <- effort_distribute(journal_unscreened, reviewers = "Liam", save_split = TRUE)

abstract_screener(file = "effort_Liam1.csv", aReviewer = "Liam", titleColumnName = "Title", abstractColumnName = "Abstract")
