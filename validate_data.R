validateData <- function(data) {
  
  # List of required columns
  required_columns <- c("Participante", "Condição", "EDA_mean", 
                        "ECG_HR", "EEG_alpha", "EEG_beta", 
                        "EyeTracking_Fixations", "STAI_score", 
                        "SPSES_score")
  
  # Check if all required columns are present
  missing_columns <- setdiff(required_columns, colnames(data))
  if (length(missing_columns) > 0) {
    stop("The following required columns are missing: ", paste(missing_columns, collapse = ", "))
  }
  
  # Validate column types
  data <- validateColumnTypes(data)
  
  return(data)
}

required_columns <- c("Participante", "Condição", "EDA_mean", 
                      "ECG_HR", "EEG_alpha", "EEG_beta", 
                      "EyeTracking_Fixations", "STAI_score", 
                      "SPSES_score")
missing_columns <- setdiff(required_columns, colnames(data))
if (length(missing_columns) > 0) {
  stop("The following required columns are missing: ", paste(missing_columns, collapse = ", "))
}

data <- validateColumnTypes(data)

validateData <- function(data) {
  required_columns <- c("Participante", "Condição", "EDA_mean", 
                        "ECG_HR", "EEG_alpha", "EEG_beta", 
                        "EyeTracking_Fixations", "STAI_score", 
                        "SPSES_score")
  
  missing_columns <- setdiff(required_columns, colnames(data))
  if (length(missing_columns) > 0) {
    stop("The following required columns are missing: ", paste(missing_columns, collapse = ", "))
  }
  
  data <- validateColumnTypes(data)
  
  return(data)
}

