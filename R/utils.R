# Get a path to a file in `inst`
dspatterns_file_path <- function(...) {
  system.file(..., package = "dspatterns")
}
