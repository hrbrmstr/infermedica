
#' Start building a diagnosis request object for the Infermedica API
#'
#' Meant to be used in a "pipe"
#'
#' TODO: Add support for \code{observed_at}, \code{extras} and \code{evaluated_at}
#'
#' @note The package expects \code{INFERMEDICA_APP_ID} and \code{INFERMEDICA_API_KEY} to
#'     be in the environment. The easiest way to do this is to add entries to
#'     \code{~/.Renviron} and restart R.
#' @export
#' @examples
#' im_start_diagnosis() %>%
#'   im_add_patient_info(29, "male") %>%
#'   im_add_evidence("s_21", "present") %>%
#'   im_get_diagnosis()
im_start_diagnosis <- function() {
  return(list(age=NULL, sex=NULL))
}


#' Add patient info to a diagnosis request object
#'
#' Meant to be used in a "pipe"
#'
#' TODO: Add support for \code{observed_at}, \code{extras} and \code{evaluated_at}
#'
#' @note The package expects \code{INFERMEDICA_APP_ID} and \code{INFERMEDICA_API_KEY} to
#'     be in the environment. The easiest way to do this is to add entries to
#'     \code{~/.Renviron} and restart R.
#' @param diag_obj diagnosis request object started with \code{im_start_dignosis()}.
#' @param age age of subject
#' @param sex sex of subject
#' @export
#' @examples
#' im_start_diagnosis() %>%
#'   im_add_patient_info(29, "male") %>%
#'   im_add_evidence("s_21", "present") %>%
#'   im_get_diagnosis()
im_add_patient_info <- function(diag_obj, age, sex) {
  diag_obj$age <- unbox(as.numeric(age))
  diag_obj$sex <- unbox(sex)
  diag_obj
}

#' Add evidence to a diagnosis request object
#'
#' Meant to be used in a "pipe" and will build the JSON array for POSTing to the
#' Infermedica API automagically in the background. Chain multiple calls together
#' to add additional evidence components.
#'
#' TODO: Add support for \code{observed_at}, \code{extras} and \code{evaluated_at}
#'
#' @note The package expects \code{INFERMEDICA_APP_ID} and \code{INFERMEDICA_API_KEY} to
#'     be in the environment. The easiest way to do this is to add entries to
#'     \code{~/.Renviron} and restart R.
#' @param diag_obj diagnosis request object started with \code{im_start_dignosis()}.
#' @param id a symptom
#' @export
#' @examples
#' im_start_diagnosis() %>%
#'   im_add_patient_info(29, "male") %>%
#'   im_add_evidence("s_21", "present") %>%
#'   im_get_diagnosis()
im_add_evidence <- function(diag_obj, id, choice=c('present', 'absent', 'unknown')) {

  choice <- match.arg(choice, c('present', 'absent', 'unknown'))

  df <- data_frame(id=id, choice_id=choice)

  if (length(diag_obj$evidence) == 0) {
    diag_obj$evidence <- df
  } else {
    bind_rows(diag_obj$evidence, df)
  }

  diag_obj

}

#' Send built diagnosis request to Infermedica API
#'
#' Meant to be used in a "pipe".
#'
#' TODO: Add support for \code{observed_at}, \code{extras} and \code{evaluated_at}
#' @note The package expects \code{INFERMEDICA_APP_ID} and \code{INFERMEDICA_API_KEY} to
#'     be in the environment. The easiest way to do this is to add entries to
#'     \code{~/.Renviron} and restart R.
#' @export
#' @examples
#' im_start_diagnosis() %>%
#'   im_add_patient_info(29, "male") %>%
#'   im_add_evidence("s_21", "present") %>%
#'   im_get_diagnosis()
im_get_diagnosis <- function(diag_obj) {

  res <- POST("https://api.infermedica.com/v2/diagnosis",
              add_headers(app_id=Sys.getenv("INFERMEDICA_APP_ID"),
                          app_key=Sys.getenv("INFERMEDICA_APP_KEY")),
              body=diag_obj,
              encode="json",
              verbose())

  stop_for_status(res)

  content(res, as="text", encoding="UTF-8") %>%
    fromJSON(flatten=TRUE)

}
