#' Build donations url
#'
#' @param event name of event to pull donations from
#'
#' @return url of the donations page for the specified event
#'
#' @importFrom httr modify_url
build_gdq_donations_url <- function(event) {
  path <- paste0("tracker/donations/", event)
  url <- modify_url("https://gamesdonequick.com", path = path)
  return(url)
}

#' Get the donations html page for the event specified
#'
#' @param event the name of the event from which to pull the donations page
#' @param page the page number from which to pull donations
#'
#' @return the html donations page
#'
#' @examples
#'
#' \donttest{fetch_donation_page("sgdq", 1)}
#'
#' @importFrom httr GET user_agent status_code http_type
fetch_donation_page <- function(event, page) {
  ua <- user_agent("http://github.com/bkkkk/gdqr")

  url <- build_gdq_donations_url(event)
  resp <- GET(url, ua, query = list(order = "1", page = as.character(page)))

  print(paste0("Fetching ", event, " page ", page))

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
