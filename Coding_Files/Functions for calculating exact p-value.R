#### Functions for Calculating the exact p-value from test statistics and degrees of freedom ####

#### t-test ####
# run this to define the necessary function
p_from_t <- function(t, df) {
  round(2*pt(t, df, lower.tail = F), 3)
}

# Example of how to use the function
p_from_t(t = 3.11, df = 31)
# or
p_from_t(3.11, 31) # this is equivalent 

#### F-test ####

# Define function
# run this to define the necessary function
p_from_F <- function(f, df1, df2) {
  round(pf(f, df1, df2, lower.tail = F), 3)
}

# Example - (again the extra f = x arguments aren't strictly necessary)
p_from_F(f = 9.67, df1 = 1, df2 = 31)

#### Pearson's Correlation ####

# define the function

p_from_r <- function(r, df) {
  rt <-  sqrt(df) * r/sqrt(1 - r^2)
  pval <- round(2 * min(pt(rt, df), pt(rt, df, lower.tail = FALSE)), 3)
  return(pval)
}

# example of using the function
# if df aren't specified then it's simply the sample size - 2 (N - 2)

p_from_r(r = .303, df = 68)
