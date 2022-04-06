# UK Biobank Dataset

## Intro: 

An R package for working with UKBB datasets including EHR, returns and somatic callings.

## How to use: 

Functions starting with "prepare" help users get familiar with the categories and fields before loading the data.

```r
library(aws.s3)
library(stringr)
library(dplyr)

prepare_get_category() # Get all Category and CategoryID
prepare_get_category(c("Asthma","blood","46")) # Get full name of categories by keywords

prepare_get_field_ids() # Get all Field and FieldID
prepare_get_field_ids(c("Dementia outcomes","Asthma outcomes","46")) # Get all Field and FieldID within specified categories

# load_ukbdata will create variable ukb_data_list and ukb_dic in the environment.
load_ukbdata() # Load all the EHR data, which takes long time and need large storage.
load_ukbdata(c("Asthma outcomes","Fluid intelligence / reasoning","46")) # Load data from interested categories only, and each category will be stored as one element in the list.

get_field_data(c("Sexually molested as a child","20179","20242","3160"), match_name = TRUE) # Get the data from fields in the categories that you have loaded in the environment.

filter_participants(rm_pp,names(ukb_data_list)) # Remove the participants that you do not need after loading the ukb_data_list

update_ukbdatabase(pp_to_rm[,1], prev_vid, new_vid) # Update the database when there are participants want to quit the study.
``` 

## Installing:

Currently this package is not on CRAN. To install use the `devtools` package: 

```r
devtools::install_github('tbilab/UKBBdata')
```
