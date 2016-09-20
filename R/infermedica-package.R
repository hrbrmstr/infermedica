#' Interface to the Infermedica API
#'
#' A set of tools that provide programmatic access to the Infermedica medical
#' inference engine API. Functions are provided that enable uploading of patient’s health
#' data (such as symptoms, risk factors, lab tests results or demographics) to the
#' Infermedica AI inference engine which will analyze it and return a list of likely
#' conditions and relevant observations to verify. For more information please visit
#' \url{http://infermedica.com}.
#'
#' @name infermedica
#' @docType package
#' @author Bob Rudis (bob@@rud.is)
#' @importFrom dplyr bind_rows bind_cols data_frame
#' @import httr
#' @importFrom jsonlite fromJSON unbox toJSON
NULL


#' infermedica exported operators
#'
#' The following functions are imported and then re-exported
#' from the infermedica package to enable use of the magrittr
#' pipe operator with no additional library calls
#'
#' @name infermedica-exports
NULL

#' @importFrom dplyr %>%
#' @name %>%
#' @export
#' @rdname infermedica-exports
NULL