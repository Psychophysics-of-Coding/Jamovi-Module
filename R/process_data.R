# Function to ensure required packages are installed and loaded
ensure_packages <- function(packages) {
  for (pkg in packages) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      message(paste("Installing package:", pkg))
      install.packages(pkg)
    }
    suppressPackageStartupMessages(library(pkg, character.only = TRUE))
  }
}

# List of essential packages
required_packages <- c("remotes", "jmvcore")

# Ensure packages are installed
ensure_packages(required_packages)

# Check if 'remotes' package is available and install 'jmvcore' from GitHub
if (requireNamespace("remotes", quietly = TRUE)) {
  tryCatch({
    remotes::install_github("jamovi/jmvcore")
    remotes::install_deps(dependencies = TRUE)
    message("'jmvcore' package and its dependencies installed successfully.")
  }, error = function(e) {
    stop("Error installing 'jmvcore' package: ", e$message)
  })
} else {
  stop("Error: 'remotes' package is not available.")
}

# Verify if 'jmvcore' was installed correctly
if (!requireNamespace("jmvcore", quietly = TRUE)) {
  stop("Error: 'jmvcore' package was not installed correctly.")
} else {
  message("'jmvcore' package installed successfully!")
}