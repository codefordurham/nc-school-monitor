library(dplyr)
library(RSQLite)
library(tidyr)

con <- dbConnect(drv = SQLite(), dbname = "./cleaned/disag.db")
dfDisag <- dbGetQuery(con, "SELECT * FROM disag")

dfDisag <- dfDisag %>% 
  mutate(num_glp = as.numeric(num_glp)
         , pct_glp = num_glp / num_tested
         , SchoolYearInt = as.integer(substr(school_year, 1, 4)))

# dfDisagWide <- dfDisag %>% 
#   filter(school_code == '00A000') %>% 
#   select(school_code, subject, grade, type, subgroup, pct_glp) %>% 
#   spread(subgroup, pct_glp)

dfSchool <- dfDisag %>% 
  select(school_code) %>% 
  unique()

dfSchoolYear <- dfDisag %>% 
  select(school_code, school_year) %>% 
  unique()

dfPctAIG <- dfDisag %>% 
  filter(subgroup %in% c('AIG', 'ALL')
         , subject == 'ALL'
         , grade == 'ALL'
         , type == 'ALL') %>% 
  select(school_code, school_year, subgroup, num_tested) %>% 
  spread(subgroup, num_tested, fill = 0) %>% 
  mutate(PctAIG = AIG / ALL)

dfPctGender <- dfDisag %>% 
  filter(subgroup %in% c('FEM', 'MALE')
         , subject == 'ALL'
         , grade == 'ALL'
         , type == 'ALL') %>% 
  select(school_code, school_year, subgroup, num_tested) %>% 
  spread(subgroup, num_tested, fill = 0) %>% 
  mutate(Total = MALE + FEM
         , PctMale = MALE / Total
         , PctFemale = FEM / Total)

dfSchoolComposition <- dfSchoolYear %>% 
  left_join(dfPctAIG) %>% 
  left_join(dfPctGender)

dfEOG <- dfDisag %>% 
  filter(subject == "EOG"
         , subgroup == "ALL"
         , !is.na(pct_glp)) %>% 
  select(school_code, school_year, type, grade, SchoolYearInt, num_tested, num_glp, pct_glp) %>% 
  left_join(dfSchoolComposition)

save(file = "disag.rda"
     , dfDisag
     , dfSchool
     , dfSchoolYear
     , dfPctAIG
     , dfPctGender
     , dfSchoolComposition
     , dfEOG)
     # , dfDisagWide)