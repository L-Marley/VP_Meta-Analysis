#### Formatting ####

# Follow the following format for keeping this log/history

#### Publication ID
# Authors (year)
# Page number of the statistic
# Calculation

# Exemplar: 
#### Pub_ID: 35
# Smith and Jones (2009)
# pp. 15
# Exact p-values

#### Functions ####

# t-test
p_from_t <- function(t, df) {
  round(2*pt(t, df, lower.tail = F), 3)
}

# F-test
p_from_F <- function(f, df1, df2) {
  round(pf(f, df1, df2, lower.tail = F), 3)
}

# Pearson's correlation
p_from_r <- function(r, df) {
  rt <-  sqrt(df) * r/sqrt(1 - r^2)
  pval <- round(2 * min(pt(rt, df), pt(rt, df, lower.tail = FALSE)), 3)
  return(pval)
}

# Standard deviation of the mean

# If the standard error is provided
# where se = the standard error, and n = group size

SD_from_SE <- function(se, n) {
  n <- sqrt(n)
  sd <- round((se/n), 2)
  return(sd)
}

#### History ####

#### Pub_ID: 177 ####
# Chu et al. (2015)
# pp. 768

# Standard deviation of the mean for BDI 

# Control Group

SD_from_SE()

# Suicide Attempt

SD_from_SE()

# Standard deviation of the means for delayed task recall

# Field perspective - Control group
SD_from_SE(.14, 74)

# Observer perspective - Control group
SD_from_SE(.12, 74)

# Field perspective - Suicide attempt
SD_from_SE(.35, 17)

# Observer perspective - Suicide attempt
SD_from_SE(.27, 17)