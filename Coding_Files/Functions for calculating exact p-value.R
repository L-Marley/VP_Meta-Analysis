#### Functions for Calculating the exact p-value from test statistics and degrees of freedom ####

#### t-test ####

# run this to define the function

p_from_t <- function(t, df) {
  round(2*pt(t, df, lower.tail = F), 3)
}

# Example of how to use the function

p_from_t(t = 3.11, df = 31)

# or use

p_from_t(3.11, 31) # this is equivalent 

#### F-test ####

# run this to define the function
p_from_F <- function(f, df1, df2) {
  round(pf(f, df1, df2, lower.tail = F), 3)
}

# Example - (again the extra f = , df1 = arguments aren't strictly necessary)
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

#### Standard Deviation of the Mean ####

# If the standard error is provided
# where se = the standard error, and n = group size

SD_from_SE <- function(se, n) {
  n <- sqrt(n)
  sd <- round( (se/n), 2 )
  return(sd)
}

#### Independent Samples t-test ####

# m1, m2: the sample means
# s1, s2: the sample standard deviations
# n1, n2: the same sizes
# m0: the null value for the difference in means to be tested for. Default is 0. 
# equal.variance: whether or not to assume equal variance. Default is FALSE. 
t_test2 <- function(m1, m2, sd1, sd2, n1, n2, m0=0, equal.variance = FALSE)
{
  if(equal.variance == FALSE) 
  {
    se <- sqrt( (sd1^2/n1) + (sd2^2/n2) )
    # welch-satterthwaite df
    df <- ( (sd1^2/n1 + sd2^2/n2)^2 )/( (sd1^2/n1)^2/(n1-1) + ( sd2^2/n2)^2/(n2-1) )
  } else
  {
    # pooled standard deviation, scaled by the sample sizes
    se <- sqrt( (1/n1 + 1/n2) * ( (n1-1)*sd1^2 + (n2-1)*sd2^2)/(n1+n2-2) ) 
    df <- n1+n2-2
  }      
  t <- (m1-m2-m0)/se 
  dat <- c(m1-m2, se, t, df, 2*pt( -abs(t), df) )    
  names(dat) <- c("Difference of means", "Std Error", "t", "df", "p-value")
  return(dat) 
}