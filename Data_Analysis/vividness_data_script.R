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

# make the 'main dataset' with only the study info and moderators

# extract the vividness data for non-shifted studies - 6 studies
vivid_noshift <- qual_tidy %>%
  select(Pub_ID:Study_ID, Emo_Mod, `Vividness - First_Mean`:`Vividness - Between_Test`,
         -c(`Vividness - First_Corr`, `Vividness - Third_Corr`, `Vividness - What was the correlation with [Field-1] perspective?`)) %>%
  rename(first_mean = `Vividness - First_Mean`, third_mean = `Vividness - Third_Mean`, 
         first_sd = `Vividness - First_SD`, third_sd = `Vividness - Third_SD`, 
         first_n = `Vividness - First_N`, third_n = `Vividness - Third_N`) %>%
  drop_na()

# recode missing SDs as NAs
vivid_noshift$first_sd <- na_if(vivid_noshift$first_sd, -99.00)
vivid_noshift$third_sd<- na_if(vivid_noshift$third_sd, -99.00)

# recode missing Ns as NAs
vivid_noshift$first_n <- na_if(vivid_noshift$first_n, -99)
vivid_noshift$third_n <- na_if(vivid_noshift$third_n, -99)

# calculate effect sizes for non-shifted vividness studies
vivid_noshift <- escalc("SMD", m1i = first_mean, m2i = third_mean, sd1i = first_sd,
                        sd2i = third_sd, n1i = first_n, n2i = third_n, data = vivid_noshift)

# extract the vividness data for shifted studies - 8 studies
vivid_shifted <- qual_tidy %>%
  select(Pub_ID:Study_ID, Shift_Type:Emo_Mod, `Vividness - Pre_Mean`:`Vividness - Within_Test`) %>%
  rename(pre_mean = `Vividness - Pre_Mean`, pre_SD = `Vividness - Pre_SD`, pre_n = `Vividness - Pre_N`,
         post_mean = `Vividness - Post_Mean`, post_SD = `Vividness - Post_SD`, post_n = `Vividness - Post_N`,
         within_test = `Vividness - Within_Test`)

# calculate effect sizes for vividness (shifted) studies
# can't be done without correlation coefficient for the change scores. 

vivid_shifted <- escalc(measure = "SMCR", m1i = pre_mean, m2i = post_mean, sd1i = pre_SD,
                        sd2i = post_SD, ni = post_N, data = vivid_shifted)

# in this case, it becomes post-test vs post test for each group because they're shifting
# in different ways
# I'm sure there'll be a way to do this in R, but rather than faff about for too long
# then potentially have more issues down the road, I'll simply recode these studies and 
# have an extra question about them being shifted ones as a moderator

#vivid_shifted2 <- 
 # vivid_shifted %>%
#  select(., -starts_with("pre")) %>%
   #drop_na() %>%
 # gather(key = "key", value = "value", -c(Pub_ID, Study_ID, Emo_Mod, Shift_Type)) %>%
#  spread(key = )