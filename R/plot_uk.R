#' Title
#'
#' @param region
#'
#' @import ggplot2
#'
#' @return
#' @export
#'
plot_ukmap <- function(region = "countries", data = data.frame()) {
  map_data <- uk_map(region = region)

  if (!nrow(data) == 0) {
    map_data <- left_join(map_data, data, by = "area_code")
  }

  ggplot2::ggplot(map_data, aes(fill = )) +
    ggplot2::geom_sf(colour = "black", fill = "white", size = 0.2) +
    ggplot2::theme_void()


  # theme(plot.background = element_rect(fill = "#7ebffc", colour = "#7ebffc"))

}

#' Title
#'
#' @param region
#'
#' @return
#' @export
#'
uk_map <- function(region = "countries") {
  map_data <- readRDS(system.file("extdata", paste0("uk_", region, ".rds"), package = "ukmap"))
  if (colnames(map_data)[1] == "OBJECTID") map_data <- map_data[, -1]
  colnames(map_data)[1:2] <- c("area_code", "area_name")
  return(map_data)
}


