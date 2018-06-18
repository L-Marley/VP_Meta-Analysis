setwd("C:/Users/Liam Marley/OneDrive/University Work/MRes/Research Dissertation/Analysis Project/VP_Meta-Analysis/Screening")

#### Packages ####
library(metagear)
library(tidyverse)

#### Loading and Screening ####

journal_unscreened <- read.csv("journal_articles.csv")

journal_unscreened <- effort_initialize(journal_unscreened)

journal_unscreened <- rename(journal_unscreened, Authors = ï..Authors)

journal_unscreened <- effort_distribute(journal_unscreened, reviewers = "Liam", save_split = TRUE)

abstract_screener(file = "effort_Liam1.csv", aReviewer = "Liam", titleColumnName = "Title", abstractColumnName = "Abstract")

# I failed to realise the DOIs hadn't exported properly when exporting from endnote
# and carried on regardless
# subsequent script is to add the available DOIs to the abstract screened file

journal_screened <- read_csv("effort_Liam1.csv")

doi_dat <- read_csv("all_journal_dois.csv")

journal_screenedtemp <- full_join(journal_screened, doi_dat)

# merging is a mess, duplicates are everywhere