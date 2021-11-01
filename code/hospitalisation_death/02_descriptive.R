##########################################################
## Title: 1st dose COVID-19 vaccine waning
## Code author(s): Rachel Mulholland <rachel.mulholland@ed.ac.uk> 
##                 Chris Robertson <chrisrobertson@nhs.net>
## Description: 02_descriptive - Descriptive analyses on the
##              baseline cohort
##########################################################


# Libraries
library("finalfit")

source('./code/hospitalisation/00_functions.R')

##### 1 Summary tables (weights) ####
# Uses function summary_factorlist_wt from 00_functions.R

df_cohort$Total = 'Total'

## Full cohort summary tables
rgs <- colnames(df_cohort)[startsWith(colnames(df_cohort), "Q")]

explanatory <- c("Total",
                 "Sex", 
                 "ageYear", 
                 "age_grp",  
                 "vacc_type_comb",
                 "simd", 
                 "ur6_2016", 
                 "n_risk_gps",
                 "n_tests", 
                 "ave_hh_age", 
                 "n_hh_gp", 
                 "bmi_cat", 
                 rgs,
                 'EAVE_Smoke',
                 'EAVE_BP')


summary_tbl_wt_chrt <- summary_factorlist_wt(df_cohort, "Total", explanatory = explanatory) 

names(summary_tbl_wt_chrt) <- c('Characteristic', 'Levels', 'Total')

summary_tbl_wt_chrt$Characteristic[duplicated(summary_tbl_wt_chrt$Characteristic)] <- ''

summary_tbl_wt_chrt[1, 'Levels'] <- ''

write.csv(summary_tbl_wt_chrt , "./output/summary_table_weights_cohort.csv", row.names = F)


# Summary table for those who were sequenced
explanatory <- c("Sex", 
                 "ageYear", 
                 "age_grp",
                 "vs",
                 "in_hosp_at_test",
                 "lab",
                 "hosp_covid",
                 "hosp_covid_emerg",
                 "death_covid",
                 "death",
                 "simd", 
                 "ur6_2016", 
                 "n_risk_gps",
                 "n_tests", 
                 "ave_hh_age", 
                 "n_hh_gp", 
                 "bmi_cat", 
                 rgs,
                 'EAVE_Smoke',
                 'EAVE_BP')

summary_tbl_seq <- summary_factorlist(df_seq, "variant", explanatory = explanatory, add_col_totals = TRUE) %>%
                  rename(Characteristic = label, Levels = levels)

write.csv(summary_tbl_seq, "./output/summary_table_weights_seq.csv", row.names = F)
