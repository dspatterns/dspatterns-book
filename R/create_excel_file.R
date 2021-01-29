#' Write an example Excel file based on `us_cities`
#'
#' @param path The path to which the Excel file will be written. If no `path` is
#'   provided then the file will be written to the working directory. The
#'   resulting filename will be `us_cities.xlsx`.
#' @importFrom here here
#'
#' @export
create_excel_file <- function(path = NULL) {

  # Write the output file name
  file_name <- "us_cities.xlsx"

  if (!is.null(path)) {

    if (!dir.exists(path)) {
      stop("The provided `path` must already exist in the filesystem",
           call. = FALSE)
    }

    file_path_name <- file.path(path, file_name)

    # Write the file
    file.copy(
      from = system.file("us_cities.xlsx", package = "edr"),
      to = file_path_name)

    path_desc <- paste0("`", file_path_name, "`")

  } else {

    # Write the file
    file.copy(
      from = system.file("us_cities.xlsx", package = "edr"),
      to = file_name)

    path_desc <- paste0("the working directory (`", here::here(), "`)")
  }

  # Display a message
  message(
    paste0("The Excel file `", file_name, "` was written to ", path_desc)
  )
}
