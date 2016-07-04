#' Get donation information from GDQ site
#'
#' @param event name of the event
#' @param min_page first page to include
#' @param max_page last page to include
#'
#' @return data frame containing all donation information
#' @export
#'
#' @examples
#' \donttest{fetch_event_donations("sgdq2016")}
#'
#' \donttest{fetch_event_donations("sgdq2016", 2, 30)}
fetch_event_donations <- function(
  event = c("sgdq2016", "sgdq2015", "agdq2016", "agdq2015", "agdq2014"),
  min_page = 1,
  max_page = 0) {
  event <- match.arg(event)

  if (min_page <= 0) {
    stop("First page must be 1 or larger")
  }

  first_page <- fetch_donation_page(event, min_page)
  total_pages <- get_n_pages(first_page)

  if (max_page != 0) {
    total_pages <- min(total_pages, max_page)
  }

  if (min_page == total_pages) {
    return(html_table(fetch_donation_page(min_page)))
  }

  raw_sgdq_pages <- lapply(min_page:total_pages, fetch_donation_page)

  raw_sgdq_tables <- sapply(raw_sgdq_pages, html_table)

  raw_sgdq_donations <- bind_rows(raw_sgdq_tables, html_table(first_page))

  return(raw_sgdq_donations)
}
