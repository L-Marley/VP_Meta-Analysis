#### Formatting ####

# Follow the following format for keeping this log/history

# Publication ID
# Authors (year)
# Page number of the test/s

# Exemplar: 
# 35
# Smith and Jones (2009)
# pp. 15

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

#### History ####
