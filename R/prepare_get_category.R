#'
#' Get name of the categories.
#'
#' @param keyorid: Category ID and/or name you need.
#'
#' @return:
#'  \itemize{
#'   \item `cat_list`: Category IDs and Names you need.
#' }
#'
#' @examples
#' \dontrun{prepare_get_category()}
#' \dontrun{prepare_get_category(c("Asthma"))}
#'


prepare_get_category = function(keyorid = NULL){
    cat_list = aws.s3::s3readRDS("s3://ukb.tbilab/genome/UKB_Category_ID.rds")
    # if (!is.null(keyorid)){
    #     key_loc = suppressWarnings(which(is.na(as.numeric(keyorid))))
    #     key = keyorid[key_loc]
    #     keyorid[key_loc] = cat_list[str_detect(cat_list$Category,paste(key,collapse = '|')),"CategoryID"]
    #     }
    return(cat_list %>% filter(CategoryID %in% keyorid))
}

prepare_get_category(c("Asthma","blood","46","3001"))
