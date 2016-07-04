#' Tidy runs data obtained from the fetch_runs function
#'
#' @param data raw data frame obtained from fetch_runs
#'
#' @return data frame containing runs information in tidy format
#' @export
#'
#' @examples
#'
#' \donttest{
#' raw_runs <- fetch_runs("sgdq2015")
#' tidy_sgdq2015 <- tidy_runs(raw_runs)
#' }
#'
#' @importFrom dplyr rename mutate
#' @importFrom lubridate mdy_hms
tidy_runs <- function(data) {
  data <- rename(
    data,
    game = Name,
    players = Players,
    description = Description,
    start_time = `Start Time`,
    end_time = `End Time`,
    has_bid_wars = `Bid Wars`
  )
  data <- mutate(
    data,
    start_time = mdy_hms(start_time),
    end_time = mdy_hms(end_time),
    has_bid_wars = if_else(has_bid_wars == "Yes", TRUE, FALSE)
  )

  return(data)
}