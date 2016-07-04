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
fetch_runs <- function(
  event = c("cgdq", "agdq2011", "jrdq", "sgdq2011", "agdq2012", "sgdq2012",
            "spook", "agdq2013", "sgdq2013", "agdq2014", "sgdq2014", "agdq2015",
            "sgdq2015", "agdq2016", "sgdq2016")) {
  event <- match.arg(event)

  if (event == "") {
    stop("You must specify the event name")
  }

  html_table(fetch_data(event, "runs"))[[1]]
}