#' Write an edr dataset to a CSV file
#'
#' @param dataset The name of a dataset in the \pkg{edr} package.
#' @param path The path to which the dataset will be written. If no `path` is
#' provided then the dataset will be written to the working directory. The
#' resulting filename will be the name of the dataset with the `.csv` extension.
#' @importFrom readr write_csv
#' @importFrom here here
#' @export
dataset_to_csv <- function(dataset,
                           path = NULL) {

  if (!(dataset %in% edr_datasets())) {
    stop("The `dataset` must be one of those available in the `edr` package:\n",
         paste0(" * `", edr_datasets(), "`\n"), call. = FALSE)
  }

  # Write the output file name
  file_name <- paste0(dataset, ".csv")

  if (!is.null(path)) {

    if (!dir.exists(path)) {
      stop("The provided `path` must already exist in the filesystem",
           call. = FALSE)
    }

    file_path_name <- file.path(path, file_name)

    # Write the CSV
    readr::write_csv(
      eval(parse(text = dataset)),
      file = file_path_name
    )

    path_desc <- paste0("`", file_path_name, "`")

  } else {

    # Write the CSV
    readr::write_csv(
      eval(parse(text = dataset)),
      file = file_name
    )

    path_desc <- paste0("the working directory (`", here::here(), "`)")
  }

  # Display a message
  message(
    paste0("The CSV file `", file_name, "` was written to ", path_desc)
  )
}
