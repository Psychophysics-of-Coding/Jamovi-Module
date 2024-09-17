# check-libs.R
# This file checks for the presence of essential libraries for module execution.

# Function to check and install R packages if necessary
ensurePackages <- function(packages) {
  for (pkg in packages) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      install.packages(pkg, dependencies = TRUE)
    }
    library(pkg, character.only = TRUE) 
  }
}

# Essential R packages for the module
requiredPackages <- c(
  "dplyr",
  "readr",
  "ggplot2",
  "ez",
  "pracma",
  "signal",
  "jmvcore" 
)

# Check and install packages
ensurePackages(requiredPackages)

cat("All necessary R packages are installed and loaded successfully.\n")