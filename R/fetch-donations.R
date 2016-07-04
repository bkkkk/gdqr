#' Fetch donations from GDQ across multiple pages
#'
#' @param event name of the event
#' @param min_page first page to include
#' @param max_page last page to include
#'
#' @return data frame containing raw donations data
#' @export
#'
#' @examples
#' \donttest{fetch_donations("sgdq2016")}
#'
#' \donttest{fetch_donations("sgdq2016", 2, 30)}
#'
#' @importFrom dplyr bind_rows
#' @importFrom rvest html_table
fetch_donations <- function(
  event = c("cgdq", "agdq2011", "jrdq", "sgdq2011", "agdq2012", "sgdq2012",
            "spook", "agdq2013", "sgdq2013", "agdq2014", "sgdq2014", "agdq2015",
            "sgdq2015", "agdq2016", "sgdq2016"),
  min_page = 1,
  max_page = 0) {

  event <- match.arg(event)

  if (event == "") {
    stop("You must specify the event name")
  }

  if (min_page <= 0) {
    stop("First page must be 1 or larger")
  }

  if (max_page != 0 & max_page < min_page) {
    stop("First page cannot be after last page")
  }

  temp_response <- fetch_paginated_data(event, "donations", 1)
  total_pages <- get_n_pages(temp_response)

  if (max_page != 0) {
    total_pages <- min(total_pages, max_page)
  }

  if (min_page == total_pages) {
    return(html_table(fetch_paginated_data(event, "donations", min_page)))
  }

  raw_pages <- lapply(min_page:total_pages, function(x) { fetch_paginated_data(event, "donations", x) } )

  raw_donations <- bind_rows(sapply(raw_pages, html_table))

  return(raw_donations)
}
