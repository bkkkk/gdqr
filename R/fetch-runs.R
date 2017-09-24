#' Fetch runs data from GDQ for a given event
#'
#' @param event name of the event
#'
#' @return data frame containing run information
#' @export
#'
#' @examples
#' \donttest{fetch_runs_data("sgdq2016")}
#'
#' \donttest{fetch_runs_data("sgdq2016", 2, 30)}
#'
#' @importFrom rvest html_table
#' @importFrom tibble as_tibble
fetch_runs <- function(event = c("cgdq", "agdq2011", "jrdq", "agdq2016", "sgdq2016")) {
  if (event == "") {
    stop("You must specify the event name")
  }

  as_tibble(html_table(fetch_data(event, "runs"))[[1]])
}