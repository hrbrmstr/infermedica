#' Retrieve Infermedica API info
#'
#' @note The package expects \code{INFERMEDICA_APP_ID} and \code{INFERMEDICA_APP_KEY} to
#'     be in the environment. The easiest way to do this is to add entries to
#'     \code{~/.Renviron} and restart R.
#' @export
im_info <- function() {

  res <- GET("https://api.infermedica.com/v2/info",
             add_headers(app_id=Sys.getenv("INFERMEDICA_APP_ID"),
                         app_key=Sys.getenv("INFERMEDICA_APP_KEY")))

  stop_for_status(res)

  content(res, as="text", encoding="UTF-8") %>%
    fromJSON(flatten=TRUE)

}
