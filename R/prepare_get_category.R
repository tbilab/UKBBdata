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
    if (!is.null(keyorid)){
        id_loc = suppressWarnings(which(!is.na(as.numeric(keyorid))))
        id = keyorid[id_loc]
        keyorid[id_loc] = unlist(cat_list %>% filter(CategoryID %in% id) %>% select(Category))

        cat_list = cat_list[str_detect(cat_list$Category,paste(keyorid,collapse = '|')),]
        }
    return(cat_list)
}

# prepare_get_category(c("Asthma","blood","46"))
