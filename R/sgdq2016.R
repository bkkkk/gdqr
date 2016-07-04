#' Schedule for SGDQ2016
#'
#' Contains expected schedule information for all games at SGDQ2016. The start time is shown
#' in GMT.
#'
#' @section Variables:
#'
#'   \itemize{
#'   \item \code{start_time}: the time the game is scheduled to start
#'   \item \code{game}: Name of the game being run
#'   \item \code{run_type}: For example, Any%. Contains bid war info and game specific runs
#'   \item \code{runners}: Names of all the runners involved
#'   \item \code{length}: Expected length of the run in seconds
#'   }
#'
#' @format A data frame with 343 observations of 5 variables.
#'
#' @examples
#' head(sgdq2016_schedule)
"sgdq2016_schedule"