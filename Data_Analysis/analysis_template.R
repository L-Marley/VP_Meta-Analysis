#### Packages ####
library(tidyverse)
library(metafor)

#### Load in the data ####

setwd("~/VP_Meta-Analysis/Data_Analysis")

qual_export <- read_csv("qual_export_21-07-18.csv")

#### Tidying the data ####

# 1. drop unnecessary qualtrics variables
# 2. drop the memory level and correlational studies

qual_tidy <- 
  qual_export %>%
  select(-c(`Start Date`:`User Language`)) %>%
  filter(Analysis_Level == "Participants") %>%
  filter(Design_1 == "Experimental")

#### Perspective Use 1st data - 8 studies ####

vivid_dat <- 
  qual_tidy %>%
  select(Pub_ID:Study_ID, Emo_Mod, `Outcome - Perspective Use 1st`, `Perspective Use 1st - First_Mean`:`Perspective Use 1st - Between_Test`,
         -c(`Perspective Use 1st - First_Corr`, `Perspective Use 1st - Third_Corr`, `Perspective Use 1st - What was the correlation with [Field-1] perspective?`)) %>%
  rename(outcome = `Outcome - Perspective Use 1st`, first_mean = `Perspective Use 1st - First_Mean`, third_mean = `Perspective Use 1st - Third_Mean`, 
         first_sd = `Perspective Use 1st - First_SD`, third_sd = `Perspective Use 1st - Third_SD`, 
         first_n = `Perspective Use 1st - First_N`, third_n = `Perspective Use 1st - Third_N`) %>%
  drop_na()

# recode missing SDs as NAs
vivid_dat$first_sd <- na_if(vivid_dat$first_sd, -99.00)
vivid_dat$third_sd<- na_if(vivid_dat$third_sd, -99.00)

# recode missing Ns as NAs
vivid_dat$first_n <- na_if(vivid_dat$first_n, -99)
vivid_dat$third_n <- na_if(vivid_dat$third_n, -99)

# calculate effect sizes for non-shifted Perspective Use 1st studies
vivid_dat <- escalc("SMD", m1i = first_mean, m2i = third_mean, sd1i = first_sd,
                        sd2i = third_sd, n1i = first_n, n2i = third_n, data = vivid_dat)

# if the missing data studies are excluded we'd only be left with 6
# yet the techniques for imputing SDs seem dubious, and especially so for some given the small
# number of studies to work from here

#### Analytic Choice: Exclude missing data studies ####
# BUT these will be retained in the data frame to illustrate the existence of 
# these studies. 

# Retain only the effect sizes and variance for combination into the main data set

vivid_dat <- 
  vivid_dat %>%
  select(Pub_ID: outcome, yi, vi)

#### Emotional Intensity ####

intense_dat <- qual_tidy %>%
  select(Pub_ID:Study_ID, Emo_Mod, `Outcome - Emotional Intensity`, `Emotional Intensity - First_Mean`:`Emotional Intensity - Between_Test`, 
         -c(`Emotional Intensity - First_Corr`, `Emotional Intensity - Third_Corr`, `Emotional Intensity - What was the correlation with [Field-1] perspective?`)) %>%
  rename(outcome = `Outcome - Emotional Intensity`, first_mean = `Emotional Intensity - First_Mean`, third_mean = `Emotional Intensity - Third_Mean`, 
         first_sd = `Emotional Intensity - First_SD`, third_sd = `Emotional Intensity - Third_SD`, 
         first_n = `Emotional Intensity - First_N`, third_n = `Emotional Intensity - Third_N`)

# recode missing SDs as NAs
intense_dat$first_sd <- na_if(intense_dat$first_sd, -99.00)
intense_dat$third_sd<- na_if(intense_dat$third_sd, -99.00)

# calculate effect sizes and drop the missing data study

intense_dat <- 
  escalc("SMD", m1i = first_mean, m2i = third_mean, sd1i = first_sd, 
         sd2i = third_sd, n1i = first_n, n2i = third_n, data = intense_dat)

# Retain only the effect sizes and variance for combination into the main data set

intense_dat <- 
  intense_dat %>%
  select(Pub_ID:outcome, yi:vi)

#### Use of first person perspective ####

first_dat <- 
  qual_tidy %>%
  select(Pub_ID:Study_ID, Emo_Mod, `Outcome - Perspective Use 1st`, `Perspective Use 1st - First_Mean`:`Perspective Use 1st - Between_Test`,
         -c(`Perspective Use 1st - First_Corr`, `Perspective Use 1st - Third_Corr`, `Perspective Use 1st - What was the correlation with [Field-1] perspective?`)) %>%
  rename(outcome = `Outcome - Perspective Use 1st`, first_mean = `Perspective Use 1st - First_Mean`, third_mean = `Perspective Use 1st - Third_Mean`, 
         first_sd = `Perspective Use 1st - First_SD`, third_sd = `Perspective Use 1st - Third_SD`, 
         first_n = `Perspective Use 1st - First_N`, third_n = `Perspective Use 1st - Third_N`) %>%
  drop_na()


#### Use of third person perspective ####

third_dat <- qual_tidy %>%
  select(Pub_ID:Study_ID, Emo_Mod, `Outcome - Perspective Use 3rd`, `Perspective Use 3rd - First_Mean`:`Perspective Use 3rd - Between_Test`, 
         -c(`Perspective Use 3rd - First_Corr`, `Perspective Use 3rd - Third_Corr`, `Perspective Use 3rd - What was the correlation with [Field-1] perspective?`)) %>%
  rename(outcome = `Outcome - Perspective Use 3rd`, first_mean = `Perspective Use 3rd - First_Mean`, third_mean = `Perspective Use 3rd - Third_Mean`, 
         first_sd = `Perspective Use 3rd - First_SD`, third_sd = `Perspective Use 3rd - Third_SD`, 
         first_n = `Perspective Use 3rd - First_N`, third_n = `Perspective Use 3rd - Third_N`) %>%
  drop_na()