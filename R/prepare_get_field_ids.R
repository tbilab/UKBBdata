#'
#' Get Field IDs in the Category before loading the data.
#'
#' @param keyorid: Category ID and/or name you need.
#'
#' @return:
#'  \itemize{
#'   \item `field_ids`: Field IDs in the category you input.
#' }
#'
#' @examples
#' \dontrun{prepare_get_field_ids()}
#' \dontrun{prepare_get_field_ids(c("Dementia outcomes","Asthma outcomes"))}
#'


prepare_get_field_ids = function(keyorid = NULL){
    ukb_dic = aws.s3::s3readRDS("s3://ukb.tbilab/genome/UKB_Field_Dictionary.rds")

    if (is.null(keyorid)){
        field_ids = ukb_dic %>% select(Category,FieldID,Field)
    }
    else{
        key_loc = suppressWarnings(which(is.na(as.numeric(keyorid))))
        key = keyorid[key_loc]
        keyorid[key_loc] = unique(ukb_dic[str_detect(ukb_dic$Category,paste(key,collapse = '|')),"CategoryID"])
        field_ids = ukb_dic %>% filter(CategoryID %in% keyorid) %>% select(Category,FieldID,Field)
    }
    return(field_ids)
}


# prepare_get_field_ids(c("Dementia outcomes","Asthma outcomes","46"))

