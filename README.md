
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ukmap

<!-- badges: start -->
<!-- badges: end -->

ukmap provides a wrapper around the ONS (Offce for National Statistics)
[API for UK geospatial data](http://statistics.data.gov.uk/).

## Installation

ukmap is currently in the early stages of development, you can install
it from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("piersyork/ukmap")
```

## Example

The core function of ukmap is `uk_map()` which takes an area code or
vector of area codes and returns the spatial features map data for the
area. To get the area codes for different area types you can use
`uk_codes()`, which takes an area type code or vector of codes and
returns all the area codes for that area type.

``` r
library(ukmap)

# get map data for london boroughs
london <- uk_codes("E09") %>% 
  uk_map()
#>   |                                                                              |                                                                      |   0%  |                                                                              |==                                                                    |   3%  |                                                                              |====                                                                  |   6%  |                                                                              |======                                                                |   9%  |                                                                              |========                                                              |  12%  |                                                                              |===========                                                           |  15%  |                                                                              |=============                                                         |  18%  |                                                                              |===============                                                       |  21%  |                                                                              |=================                                                     |  24%  |                                                                              |===================                                                   |  27%  |                                                                              |=====================                                                 |  30%  |                                                                              |=======================                                               |  33%  |                                                                              |=========================                                             |  36%  |                                                                              |============================                                          |  39%  |                                                                              |==============================                                        |  42%  |                                                                              |================================                                      |  45%  |                                                                              |==================================                                    |  48%  |                                                                              |====================================                                  |  52%  |                                                                              |======================================                                |  55%  |                                                                              |========================================                              |  58%  |                                                                              |==========================================                            |  61%  |                                                                              |=============================================                         |  64%  |                                                                              |===============================================                       |  67%  |                                                                              |=================================================                     |  70%  |                                                                              |===================================================                   |  73%  |                                                                              |=====================================================                 |  76%  |                                                                              |=======================================================               |  79%  |                                                                              |=========================================================             |  82%  |                                                                              |===========================================================           |  85%  |                                                                              |==============================================================        |  88%  |                                                                              |================================================================      |  91%  |                                                                              |==================================================================    |  94%  |                                                                              |====================================================================  |  97%  |                                                                              |======================================================================| 100%
# use the tmap package to easily see what the map data looks like
tmap::qtm(london)
```

<img src="man/figures/README-example-1.png" width="100%" />
