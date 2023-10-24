#'
#' Retrieve data from selected fields.
#'
#' @param keyorid: list of field keyorid.
#' @param match_name: return will have column names with name or id, default=FALSE, which is field ids.
#'
#' @return: a list of data frames for fields
#'
#' @examples
#' \dontrun{get_field_data(ids = c("20179","20242"))}
#'


get_field_data = function(keyorid = NULL,match_name=FALSE){
  # if (!is.null(keyorid)){
  #   id_loc = suppressWarnings(which(is.na(as.numeric(keyorid))))
  #   keyorid[id_loc] = ukb_dic[str_detect(ukb_dic$Field,paste(keyorid[id_loc],collapse = "|")),"FieldID"]
  # }
  cats = unlist(ukb_dic %>% filter(FieldID %in% keyorid) %>% distinct(Category))
  loaded_cats = names(ukb_data_list)
  patterns = paste0("^",keyorid,"-")
  output = list()

  if (loaded_cats[1] == "ALL"){
    output = ukb_data_list[["ALL"]][str_detect(colnames(ukb_data_list[["ALL"]]),paste(patterns,collapse = "|"))]
  }
  else{
    for (cat in cats){
      if (cat %in% loaded_cats){
        found = ukb_data_list[[cat]][str_detect(colnames(ukb_data_list[[cat]]),paste(patterns,collapse = "|"))]
        if (ncol(found)>0){
          output[[cat]] = cbind(data.frame(eid = ukb_data_list[[cat]][,1]),found)
        }
      }
      else{
        print(paste0("You need to load the category: ",cat))
      }
    }
  }

  if (match_name){
    for (n in names(output)){
      field = sapply(colnames(output[[n]]),function(x){strsplit(x,"-")}[[1]][1])
      postfix = sapply(colnames(output[[n]]),function(x){strsplit(x,"-")}[[1]][2])
      colnames(output[[n]])[-1] = sapply(2:ncol(output[[n]]),function(i){paste0(ukb_dic[ukb_dic$FieldID==field[i],"Field"],"-",postfix[i])})
    }
  }

  return (output)
}


# output = get_field_data(c("Sexually molested as a child","20179","20242","3160"), match_name = TRUE)
# output
# length(output)
# names(output)
