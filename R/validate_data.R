# validate_data.R
# This file validates the presence of required columns and data types.

# Import necessary libraries
library(readr) # For reading CSV files

# Function to check if all required columns are present
checkRequiredColumns - function(data, requiredColumns) {
  missingColumns - setdiff(requiredColumns, names(data))
  if (length(missingColumns)  0) {
    stop(paste(Missing columns in data file, paste(missingColumns, collapse = , )))
  }
}

# Function to validate the data types of columns
validateColumnTypes - function(data) {
  columnTypes - c(
    Participante = factor,
    Condição = factor,
    EDA_mean = numeric,
    ECG_HR = numeric,
    EEG_alpha = numeric,
    EEG_beta = numeric,
    EyeTracking_Fixations = numeric,
    STAI_score = numeric,
    SPSES_score = numeric
  )

  for (col in names(columnTypes)) {
    expectedType - columnTypes[col]
    actualType - class(data[[col]])[1] 

    if (expectedType == factor && actualType != character) { 
      stop(paste(Column, col, should be a factor, but found, actualType))
    }
    if (expectedType == numeric && actualType != numeric) {
      stop(paste(Column, col, should be numeric, but found, actualType))
    }
  }
}

# Main function for data validation
validateData - function(filePath) {
  # Check if the file path is provided
  if (missing(filePath)) {
    stop(No file path provided.)
  }

  # Import the data from the CSV file
  data - readrread_csv(filePath, show_col_types = FALSE)

  # Required columns
  requiredColumns - c(
    Participante,
    Condição,
    EDA_mean,
    ECG_HR,
    EEG_alpha,
    EEG_beta,
    EyeTracking_Fixations,
    STAI_score,
    SPSES_score
  )

  # Check if all required columns are present
  checkRequiredColumns(data, requiredColumns)

  # Validate data types
  validateColumnTypes(data)

  cat(Data validation successful.n)
}