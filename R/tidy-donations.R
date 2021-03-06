
#' Tidy up the results of fetching GDQ donations
#'
#' @param data raw donations data frame from fetch_event_donations
#'
#' @return data frame containing donation data in tidy format
#' @export
#'
#' @examples
#' \donttest{
#' donations <- fetch_event_donations("sgdq2016")
#' donations <- tidy_donations(donations)
#' }
#'
#' @importFrom tibble as_tibble
#' @importFrom dplyr mutate rename_ if_else
#' @importFrom lubridate mdy_hms
tidy_donations <- function(data) {
  data <- as_tibble(data)
  data <- rename_(
    data,
    donator = "Name",
    date = as.name("Time ReceivedAscDsc"),
    amount = "AmountAscDsc",
    with_comment = "Comment"
  )
  data <- mutate(
    data,
    amount = as.numeric(gsub("\\$|,", "", amount)),
    date = mdy_hms(date),
    with_comment = if_else(with_comment == "Yes", TRUE, FALSE)
  )

  return(data)
}
