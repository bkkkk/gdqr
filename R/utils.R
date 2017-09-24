#' Get the number of available pages
#'
#' @param x any XML object
#'
#' @return number of pages availabl
#'
#' @importFrom xml2 xml_double xml_find_first
get_n_pages <- function(x) {
  xml_double(xml_find_first(x, xpath = ".//input[@id='page']/@max"))
}