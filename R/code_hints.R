#' @export
code_hints <- function(title = "CODE",
                       entries = NULL,
                       hints = "Code Hints") {

  markdownify <- function(text) {
    vapply(
      text,
      FUN.VALUE = character(1),
      USE.NAMES = FALSE,
      FUN = function(x) {

        x <- gsub("~~", "`", x)
        x <- commonmark::markdown_html(x)
        x <- gsub("<p>", "", x, fixed = TRUE)
        x <- gsub("</p>", "", x, fixed = TRUE)
        x <- gsub("\n", "", x, fixed = TRUE)
        x
      }
    )
  }

  title <- markdownify(title)

  if (is.null(entries)) {

    title_tag <-
      htmltools::tagList(
        htmltools::tags$p(
          style = paste(
            "margin-bottom: 0;",
            "font-size: 14px",
            sep = " "
          ),
          htmltools::HTML(title)
        )
      )

    return(title_tag)
  }

  entries <- markdownify(entries)
  hints <- markdownify(hints)

  entries <-
    vapply(
      entries,
      FUN.VALUE = character(1),
      USE.NAMES = FALSE,
      FUN = function(x) {

        x_split <- unlist(strsplit(x, " "))

        paste0(
          "<span ",
          "style=\"color:steelblue;font-weight:bold;\">",
          x_split[1], " ",
          "</span>",
          paste(x_split[2:length(x_split)], collapse = " ")
        )
      }
    )

  entries <- paste(entries, collapse = "<br>")

  htmltools::tagList(
    htmltools::tags$p(
      style = paste(
        "margin-bottom: 0;",
        "font-size: 14px",
        sep = " "
      ),
      htmltools::HTML(title)
    ),
    htmltools::tags$details(
      style = paste(
        "font-family: 'Open Sans', sans-serif;",
        "color: #333333;",
        "font-size:10px;",
        "margin:0 !important",
        sep = " "
      ),
      htmltools::tags$summary(
        style = paste(
          "outline-style: none;",
          "margin-left: 2px;",
          "cursor: pointer;"
        ),
        htmltools::HTML(hints)
      ),
      htmltools::HTML(entries),
      htmltools::tags$br(
        style = "font-size: 14px;"
      )
    )
  )
}
