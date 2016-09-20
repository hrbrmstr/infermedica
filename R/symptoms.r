#' Retrieve list of symptoms from Infermedica API
#'
#' @note The package expects \code{INFERMEDICA_APP_ID} and \code{INFERMEDICA_APP_KEY} to
#'     be in the environment. The easiest way to do this is to add entries to
#'     \code{~/.Renviron} and restart R.
#' @export
im_list_symptoms <- function() {

  res <- GET("https://api.infermedica.com/v2/symptoms",
             add_headers(app_id=Sys.getenv("INFERMEDICA_APP_ID"),
                         app_key=Sys.getenv("INFERMEDICA_APP_KEY")))

  stop_for_status(res)

  content(res, as="text", encoding="UTF-8") %>%
    fromJSON(flatten=TRUE)

}

#' Retrieve info for a specific symptom
#'
#' @note The package expects \code{INFERMEDICA_APP_ID} and \code{INFERMEDICA_APP_KEY} to
#'     be in the environment. The easiest way to do this is to add entries to
#'     \code{~/.Renviron} and restart R.
#' @param symptom_id valid Infermedica symptom id (use \code{im_list_symptoms()} to
#'     get a list of valid ids)
#' @export
im_get_symptom <- function(symptom_id) {

  res <- GET(sprintf("https://api.infermedica.com/v2/symptoms/%s", symptom_id),
             add_headers(app_id=Sys.getenv("INFERMEDICA_APP_ID"),
                         app_key=Sys.getenv("INFERMEDICA_APP_KEY")))

  stop_for_status(res)

  content(res, as="text", encoding="UTF-8") %>%
    fromJSON(flatten=TRUE)

}