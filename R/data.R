#' UK 2019 Election Data
#'
#' A dataset containing the results of the 2019 UK general election.
#'
#' @format A data frame with 650 rows and 19 variables:
#' \describe{
#'   \item{area_code}{the ons area code}
#'   \item{region_code}{the ons region code}
#'   \item{constituency_name}{the ons region code}
#'   \item{county_name}{the ons region code}
#'   \item{region_name}{the ons region code}
#'   \item{country_name}{the ons region code}
#'   \item{constituency_type}{the ons region code}
#'   \item{party_name}{the ons region code}
#'   \item{party_abbreviation}{the ons region code}
#'   \item{firstname}{the ons region code}
#'   \item{surname}{the ons region code}
#'   \item{gender}{the ons region code}
#'   \item{sitting_mp}{the ons region code}
#'   \item{former_mp}{the ons region code}
#'   \item{votes}{the ons region code}
#'   \item{share}{the ons region code}
#'   \item{change}{the ons region code}
#'   \item{fullname}{the ons region code}
#'   \item{mp_status}{the ons region code}
#'   ...
#' }
#' @source \url{House of Commons}
"uk_election_2019"

#' UK Unemployment Data
#'
#' A dataset containing UK unemployment data for local authorities.
#'
#' @format A data frame with 372 rows and 3 variables:
#' \describe{
#'   \item{area_name}{the local authority name}
#'   \item{area_code}{the ons area code}
#'   \item{unemployment_rate}{percent of people unemployed}
#'   ...
#' }
#' @source \url{ONS}
"uk_unemployment"
