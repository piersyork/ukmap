### declare global variables
globalVariables(c("label", "name", "URLencode", "txtProgressBar", "setTxtProgressBar"))

#' Internal function for making SPARQL queries to gov API
#'
#' @param query A SPARQL query
#'
#' @return A dataframe of the results
#'
ons_query <- function(query) {
  url <- paste0("http://statistics.data.gov.uk/sparql.json?query=",
                gsub("\\+", "%2B", URLencode(query, reserved = TRUE)))

  return <- jsonlite::read_json(url)$results$bindings

  len <- length(return[[1]])

  out <- list()
  col_names <- names(return[[1]])
  for (i in 1:len) {
    out[[i]] <- unlist(lapply(return, function(x, n) x[[n]][[2]], i))
  }
  df_out <- cbind.data.frame(out) %>%
    `colnames<-`(col_names)
  return(df_out)
}
