setwd("~/VP_Meta-Analysis/Screening")

#### Packages ####
library(metagear)

journal_unscreened <- read.csv("journal_articles.csv")

journal_unscreened <- effort_initialize(journal_unscreened)

journal_unscreened <- effort_distribute(journal_unscreened, reviewers = "Liam", save_split = TRUE)

