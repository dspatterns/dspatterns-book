#' @export
figure_title <- function(title = "title text") {

  title <- markdownify(title)

  htmltools::tags$p(
    style = paste(
      "margin-bottom: 6px;",
      "font-size: 15px",
      sep = " "
    ),
    htmltools::HTML(title)
  )
}

#' @export
code_details <- function(entries = NULL,
                         label = "Notes on the code") {

  entries <- markdownify(entries)
  label <- markdownify(label)

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

  htmltools::tags$details(
    style = paste(
      "font-family: 'Open Sans', sans-serif;",
      "color: #333333;",
      "font-size: 12px;",
      "margin-bottom: 12px;",
      "padding-top: 4px;",
      "padding-bottom: 4px;",
      sep = " "
    ),
    htmltools::tags$summary(
      style = paste(
        "outline-style: solid;",
        "outline-width: 1px;",
        "outline-color: #B6B4FA;",
        "background-color: white;",
        "margin-left: 0.5px;",
        "margin-top: -10px;",
        "padding-left: 5px;",
        "text-indent: 1px;",
        "cursor: pointer;",
        "font-size: 12px;",
        "display: list-item;"
      ),
      htmltools::HTML(label)
    ),
    htmltools::HTML(entries),
    htmltools::tags$br(
      style = "font-size: 14px;"
    )
  )
}

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


#' @export
code_hints <- function(title = "CODE",
                       entries = NULL,
                       hints = "Notes on the Code") {

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
        "font-size:11px;",
        "margin-bottom: 2px;",
        "padding-top: 4px;",
        "padding-bottom: 4px;",
        sep = " "
      ),
      htmltools::tags$summary(
        style = paste(
          "outline-style: solid;",
          "outline-width: 1px;",
          "outline-color: #B6B4FA;",
          "background-color: white;",
          "margin-left: -0.5px;",
          "margin-bottom: 6px;",
          "text-indent: 6px;",
          "cursor: pointer;",
          "font-size: 10px;",
          "display: list-item;"
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
