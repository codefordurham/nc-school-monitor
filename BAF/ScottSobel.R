library(lubridate)
library(microbenchmark)

nPolicies <- 1000

effDate <- as.Date("2011-01-01") + days(sample.int(nPolicies, size = 1000, replace = TRUE))
expDate <- effDate + months(6)

dfPolicy <- data.frame(EffectiveDate = effDate, ExpirationDate = expDate) %>% 
  mutate(CalYears = year(ExpirationDate) - year(EffectiveDate) + 1
         , EffectiveYear = year(EffectiveDate)) %>% 
  filter(!is.na(CalYears))

#===================
# CalYear1:
# Use a loop and concatenate results
CalYear1 <- function(df){
  # First, create “CalYear” to be the sequence of calendar years for row# 1:
  CalYear <- seq(from = df$EffectiveYear[1]
                 , to = df$EffectiveYear[1] + df$CalYears[1] - 1, by = 1)
  
  for (i in 2:nrow(df)) {
    CalYear <- c(CalYear, seq(from = df$EffectiveYear[i]
                              , to = df$EffectiveYear[i] + df$CalYears[i] - 1, by = 1))
  }
  CalYear
}

#==================
# CalYear2:
# mapply and then unlist
CalYear2 <- function(df){
  CalYear <- mapply(function(eff_year, num_years){
    seq(eff_year, length.out = num_years)
  }, df$EffectiveYear, df$CalYears)
  CalYear <- unlist(CalYear)
}

microbenchmark::microbenchmark(
  method1 <- CalYear1(dfPolicy)
  , method2 <- CalYear2(dfPolicy)
)
