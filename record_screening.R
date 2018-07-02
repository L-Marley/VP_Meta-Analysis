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
# post extra duplicate removal
records_screened <- read_csv("all_records_firstscreen_Liam.csv")

records_screened <- records_screened %>%
  select(STUDY_ID:INCLUDE, Item.Type:Publication.Title, DOI:Date, Pages:Volume) %>%
  filter(INCLUDE == "YES" | INCLUDE == "MAYBE")

# Alter the working directory so it's out of GitHub and I'm not breaching any
# copyright rules

setwd("~/meta_analysis_pdfs")


collection_outcome <- PDFs_collect(as.data.frame(records_screened), DOIcolumn = "DOI", FileNamecolumn = "STUDY_ID", quiet = TRUE, WindowsProxy = TRUE)
