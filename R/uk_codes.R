#' Get ONS area codes for UK area types
#'
#' @param type The Area Collection Code to get area codes for. E.g. "E09" for London Boroughs. All possible collection codes area available at http://statistics.data.gov.uk/atlas
#'
#' @return A character vector of area codes
#'
#' @import RCurl XML
#' @export
#'
#' @examples
#' uk_codes("E09")
uk_codes <- function(type) {
  SPARQL::SPARQL(url = "http://statistics.data.gov.uk/sparql.xml", query =
                   paste0(
'PREFIX wkt: <http://www.opengis.net/ont/geosparql#asWKT>
PREFIX label: <http://www.w3.org/2000/01/rdf-schema#label>
PREFIX name: <http://statistics.data.gov.uk/def/statistical-geography#officialname>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX member: <http://publishmydata.com/def/ontology/foi/memberOf>
PREFIX active: <http://publishmydata.com/def/ontology/foi/active>

SELECT DISTINCT ?label ?name

WHERE {
	?o label: ?label ;
  	   name: ?name  ;
       active: ?active ;
	   member: ?member .
  FILTER (', paste0("?member = <http://statistics.data.gov.uk/def/geography/collection/", type, ">", collapse = " || "), ')
  FILTER (?active = TRUE)
}'))$results %>%
    rename(area_code = label, area_name = name)
}

#' Add More ONS Codes for an area type
#'
#' @param uk_codes
#' @param type
#'
#' @return
#' @export
#'
#' @examples
add_codes <- function(uk_codes, type) {
  if (is.data.frame(uk_codes)) {
    rbind(
      uk_codes,
      uk_codes(type)
    )
  } else {
    c(uk_codes, uk_codes(type))
  }

}

#' Return the Area Name for a given Area Code
#'
#' @param area_code An ONS Area Code
#'
#' @return The area name
#' @export
#'
find_area_name <- function(area_code) {
  SPARQL::SPARQL(url = "http://statistics.data.gov.uk/sparql.xml", query =
                   paste0(
                     'PREFIX label: <http://www.w3.org/2000/01/rdf-schema#label>
PREFIX name: <http://statistics.data.gov.uk/def/statistical-geography#officialname>

SELECT DISTINCT ?label ?name

WHERE {
	?o label: ?label ;
  	   name: ?name  .
  FILTER (?label = "', area_code, '")
}'))$results %>%
    rename(area_code = label, area_name = name)
}

#' Return the area names for given area codes
#'
#' @param area_codes The ONS area codes to find area names for
#'
#' @return A dataframe of area names and the corresponding area code
#' @export
#'
find_area_names <- function(area_codes) {
  if (FALSE) {
    results <- list()
    for (i in 1:length(area_codes)) {
      results[[i]] <- find_area_name(area_codes[i])
    }
    bind_rows(results)
  } else {
    indices <- c(seq(1, length(area_codes), 50), length(area_codes))
    results <- list()
    for (i in 1:(length(indices) - 1)) {
      results[[i]] <- SPARQL::SPARQL(url = "http://statistics.data.gov.uk/sparql.xml", query =
                                       paste0(
                                         'PREFIX label: <http://www.w3.org/2000/01/rdf-schema#label>
PREFIX name: <http://statistics.data.gov.uk/def/statistical-geography#officialname>

SELECT DISTINCT ?label ?name

WHERE {
	?o label: ?label ;
  	   name: ?name  .
  FILTER (', paste0('?label = ', '"', area_codes[indices[i]:indices[i+1]], '"', collapse = " || "), ')
}'))$results %>%
        rename(area_code = label, area_name = name)
    }
    bind_rows(results)
  }
}
