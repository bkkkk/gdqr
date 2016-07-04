#' Preprocess the raw response from the site
#'
#' @param response the GET response from the GDQ site
#'
#' @return an S3:gdq_donations_query object that contains the reponse and original query
preprocess_response <- function(response) {
  structure(
    list(
      content = read_html(response),
      query = response$url,
      response = resp
    ),
    class = "gdq_donations_query"
  )
}
