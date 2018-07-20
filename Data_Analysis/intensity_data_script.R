library(tidyverse)
library(metafor)

qual_export <- read_csv(file.choose())

# drop redundant qualtrics variables
qual_tidy <- qual_export %>%
  select(-c(`Start Date`:`User Language`))

# drop the memory level and correlational studies to be analysed separately
qual_tidy <- qual_tidy %>%
  filter(Analysis_Level == "Participants") %>%
  filter(Design_1 == "Experimental")

# extract emotional intensity for the non-shifted studies - 7 studies

intense_noshift <- qual_tidy %>%
  select(Pub_ID:Study_ID, Emo_Mod, `Emotional Intensity - First_Mean`:`Emotional Intensity - Between_Test`,
         -c(`Emotional Intensity - First_Corr`, `Emotional Intensity - Third_Corr`, `Emotional Intensity - What was the correlation with [Field-1] perspective?`)) %>%
  rename(first_mean = `Emotional Intensity - First_Mean`, third_mean = `Emotional Intensity - Third_Mean`, 
         first_sd = `Emotional Intensity - First_SD`, third_sd = `Emotional Intensity - Third_SD`, 
         first_n = `Emotional Intensity - First_N`, third_n = `Emotional Intensity - Third_N`) %>%
  drop_na()

# recode missing SDs as NAs
intense_noshift$first_sd <- na_if(intense_noshift$first_sd, -99.00)
intense_noshift$third_sd<- na_if(intense_noshift$third_sd, -99.00)

# calculate effect sizes

intense_noshift <- escalc("SMD", m1i = first_mean, m2i = third_mean, sd1i = first_sd,
                        sd2i = third_sd, n1i = first_n, n2i = third_n, data = intense_noshift)
intense_noshift <- intense_noshift %>%
  rename(intense_yi = yi, intense_vi = vi)

############# note: publication 255 is likely a carried over error ##############