#' Write an R Markdown file containing code listings for a chapter
#'
#' @param path The path to which the R Markdown file will be written. If no
#'   `path` is provided then the file will be written to the working directory.
#'
#' @export
dsp_code_rmd <- function(chapter = 1:12,
                         path = NULL) {

  # Get the output file name
  file_name <-
    paste0(
      "chapter_code_",
      formatC(chapter, width = 2, format = "d", flag = "0"),
      ".Rmd"
    )

  if (!is.null(path)) {

    if (!dir.exists(path)) {
      stop("The provided `path` must already exist in the filesystem",
           call. = FALSE)
    }

    file_path_name <- file.path(path, file_name)

    # Write the file
    file.copy(
      from = dspatterns_file_path(paste0("code_rmd/", file_name)),
      to = file_path_name
    )

    path_desc <- paste0("`", file_path_name, "`")

  } else {

    # Write the file
    file.copy(
      from = dspatterns_file_path(paste0("code_rmd/", file_name)),
      to = file_name
    )

    path_desc <- paste0("the working directory (`", here::here(), "`)")
  }

  # Display a message
  message(
    paste0("The .Rmd file `", file_name, "` was written to ", path_desc, ".")
  )
}
