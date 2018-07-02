#### Functions for Calculating the exact p-value from test statistics and degrees of freedom ####

#### t-test ####
p_from_t <- function(t, df) {
  round(2*pt(t, df, lower.tail = F), 3)
}

# Example of the usage
p_from_t(t = 3.11, df = 31)

p_from_t(3.11, 31) # this is equivalent 

#### F-test ####

# Define function
p_from_F <- function(f, df1, df2) {
  round(pf(f, df1, df2, lower.tail = F), 3)
}

# Example - (again the extra f = x arguments aren't strictly necessary)
p_from_F(f = 9.6721, df1 = 1, df2 = 31)

# for correlations you'll have to convert it to a z-score from which you'll know the significance level.