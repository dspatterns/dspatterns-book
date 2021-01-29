#' Use the RegExplain gadget with some example text
#'
#' @param text Text to experiment with in the RegExplain gadget. If nothing is
#' provided then the following sentence/string will be used:
#' `"The quick brown fox jumps over the lazy dog"`.
#'
#' @export
edr_regexplain_gadget <- function(text = NULL) {

  if (is.null(text)) {
    text <- "The quick brown fox jumps over the lazy dog"
  }

  regexplain::regex_gadget(
    text = text,
    start_page = "RegEx"
  )
}
