#' Get an html page from a data type
#'
#' @param event the name of the event from which to pull the donations page
#' @param type the type of resource to fetch such as donations, runs, and bids
#' @param query (Optional) a list of params and values to append to the url
#'
#' @return the html page of the specified data type
#'
#' @examples
#'
#' \donttest{fetch_data("sgdq", "donations")}
#'
#' @importFrom httr GET user_agent status_code http_type modify_url
#' @importFrom xml2 read_html
fetch_data <- function(event, type, query = NULL) {
  ua <- user_agent("http://github.com/bkkkk/gdqr")
  path <- paste0("tracker/", type, "/", event)

  resp <- GET("https://gamesdonequick.com", ua, query = query, path = path)

  if (http_type(resp) != "text/html") {
    stop("Request did not return html", call. = FALSE)
  }

  if (status_code(resp) != 200) {
    stop(
      sprintf("Grabbing donations page failed [%s]", status_code(resp)),
      call. = FALSE
    )
  }

  return(read_html(resp))
}


#' Get an html page for a paginated data type
#'
#' @param event event name
#' @param type resource type
#' @param page page to fetch
#'
#' @return html page of resources
#'
#' @examples
#' \donttest{
#' fetch_paginated_data("sgdq2015", "donations", 1)
#' }
fetch_paginated_data <- function(event, type, page) {
  fetch_data(event, type, list(order = "1", page = as.character(page)))
}
