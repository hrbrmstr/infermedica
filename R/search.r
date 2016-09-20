#' Returns list of observations matching the given phrase from Infermedica API
#'
#' @note The package expects \code{INFERMEDICA_APP_ID} and \code{INFERMEDICA_APP_KEY} to
#'     be in the environment. The easiest way to do this is to add entries to
#'     \code{~/.Renviron} and restart R.
#' @param phrase search terms/phrase
#' @param sex male/female or NULL
#' @param type character vector or NULL. If not NULL or a single string, should be
#'     a character vector composed of "symptom", "risk_factor", "lab_test"
#' @param max_results limit the number of search results (default == 8)
#' @export
#' @examples
#' im_search("bleeding", "male", type="symptom")
im_search <- function(phrase, sex=NULL, type=NULL, max_results=8) {

  params <- list(phrase=phrase, max_results=max_results)

  if (length(sex) > 0) params$sex <- sex

  if (length(type) > 0) {
    type <- setNames(as.list(type), rep("type", length(type)))
    params <- c(params, type)
  }


  res <- GET("https://api.infermedica.com/v2/search",
             add_headers(app_id=Sys.getenv("INFERMEDICA_APP_ID"),
                         app_key=Sys.getenv("INFERMEDICA_APP_KEY")),
             query=params)

  stop_for_status(res)

  content(res, as="text", encoding="UTF-8") %>%
    fromJSON(flatten=TRUE)

}


#' Returns a single observation matching given phrase from Infermedica API
#'
#' @note The package expects \code{INFERMEDICA_APP_ID} and \code{INFERMEDICA_APP_KEY} to
#'     be in the environment. The easiest way to do this is to add entries to
#'     \code{~/.Renviron} and restart R.
#' @param phrase search terms/phrase
#' @param sex male/female or NULL
#' @export
#' @examples
#' im_lookup("search phrase")
im_lookup <- function(phrase, sex=NULL) {

  params <- list(phrase=phrase)

  if (length(sex) > 0) params$sex <- sex

  res <- GET("https://api.infermedica.com/v2/lookup",
             add_headers(app_id=Sys.getenv("INFERMEDICA_APP_ID"),
                         app_key=Sys.getenv("INFERMEDICA_APP_KEY")),
             query=params)

  stop_for_status(res)

  content(res, as="text", encoding="UTF-8") %>%
    fromJSON(flatten=TRUE)

}
