#' Get the boundary data for a single area
#'
#' @param area_code An ONS area code
#'
#' @return The boundary data for the area code with class "sfc"
#' @export
#'
#' @import dplyr
#'
get_boundary <- function(area_code) {
  raw <- readLines(paste0("http://statistics.data.gov.uk/sparql.json?query=DESCRIBE+%3Chttp://statistics.data.gov.uk/id/statistical-geography/", area_code, "/geometry%3E"))
  wkt_raw <- raw[2] %>%
    stringr::str_remove(paste0('<http://statistics.data.gov.uk/id/statistical-geography/', area_code, '/geometry> <http://www.opengis.net/ont/geosparql#asWKT> "')) %>%
    stringr::str_remove('"\\^\\^<http://www.opengis.net/ont/geosparql#wktLiteral> .')

  wkt <- rgeos::readWKT(wkt_raw)
  sfc_out <- sf::st_as_sfc(wkt)
  return(sfc_out)
}

#' Get map data for UK Area
#'
#' @param area_codes The ONS area codes to be included in the map.
#'
#' @return
#' @export
#'
#' @examples
uk_map <- function(area_codes) {

  if (is.data.frame(area_codes)) {
    area_codes <- area_codes$area_code
  }

  # progress bar setup
  pb <- txtProgressBar(style = 3)
  pb_add <- seq(1/length(area_codes), 1, 1/length(area_codes)) # amount to add each loop

  boundaries <- list()

  for (i in 1:length(area_codes)) {
    # print(area_codes[i])
    boundaries[[i]] <- tryCatch({
      get_boundary(area_codes[i])
    }, error = function(e) {
      warning(paste("Unable to get data for area code:", area_codes[i]))

      return(NULL)
      })
    # if (is.null(boundaries[[i]])) {
    #   null_indices <- c(null_indices, i)
    #   print(i)
    # }
    setTxtProgressBar(pb, pb_add[i])
  }
  null_indices <- (1:length(boundaries))[sapply(boundaries, is.null)]


  boundaries[sapply(boundaries, is.null)] <- NULL
  close(pb)
  names <- find_area_names(area_codes)
  sf_data <- sf::st_sf(boundary = Reduce(c, boundaries))
  sf_data$area_code <- if (length(null_indices) == 0) area_codes else area_codes[-null_indices]
  sf_data %>% left_join(names, by = "area_code") %>%
    sf::st_make_valid()
}
