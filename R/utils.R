#' Get the number of available pages
#'
#' @param a_page any XML object
#'
#' @return number of pages availabl
#'
#' @importFrom xml2 xml_double xml_contents xml_find_all
get_n_pages <- function(a_page) {
  max(xml_double(xml_contents(xml_find_all(a_page, xpath = ".//select/option"))))
}