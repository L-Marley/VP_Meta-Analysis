# Script to see how extracting the coding information from the qualtrics output
# will work

library(tidyverse)
library(metafor)
test_file <- read_csv("fake_data_for_practice.csv")

vivid_dat <- select(test_file, Pub_ID:Study_ID, "Vividness - Pre_Mean":"Vividness - Within_Test")
colnames(vivid_dat) <- c("Pub_ID", "Study_ID", "Pre_Mean", "Pre_SD", "Pre_N","Post_Mean", "Post_SD", "Post_N")

vivid_dat <- escalc(measure = "SMD", m1i = Pre_Mean, sd1i = Pre_SD, n1i = Pre_N, 
                          m2i = Post_Mean, sd2i = Post_SD, n2i = Post_N, data = vivid_dat)
vivid_dat <- vivid_dat %>%
  rename(viv_yi = "yi", viv_vi = "vi")

posi_dat <- select(test_file, Pub_ID:Study_ID, "Positive Emotion - Pre_Mean":"Positive Emotion - Within_Test")
colnames(posi_dat) <- c("Pub_ID", "Study_ID", "Pre_Mean", "Pre_SD", "Pre_N","Post_Mean", "Post_SD", "Post_N")

posi_dat <- vivid_dat <- escalc(measure = "SMD", m1i = Pre_Mean, sd1i = Pre_SD, n1i = Pre_N, 
                                m2i = Post_Mean, sd2i = Post_SD, n2i = Post_N, data = posi_dat)
posi_dat <- posi_dat %>% 
  rename(pos_yi = "yi", pos_vi = "vi")

vivid_posi_dat <- full_join(vivid_dat, posi_dat, by = c("Pub_ID", "Study_ID"))
