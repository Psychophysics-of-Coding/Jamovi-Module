analyzeData <- function(filePath) {
  if (missing(filePath)) {
    stop("No file path provided.")
  }

  # Process the data (assuming processData is defined elsewhere)
  data <- processData(filePath)

  # Perform repeated measures ANOVA
  anovaResult <- runRepeatedMeasuresANOVA(data, "Condition", "EDA_mean", "ECG_HR", "EEG_alpha", "EEG_beta")

  # Generate visualizations
  tryCatch({
    plot <- ggplot(data) + 
      aes(x = XPosition, y = YPosition, fill = Fixations) + 
      geom_tile() +
      theme_minimal()

    return(list(plot = plot, anovaResult = anovaResult))
  }, error = function(e) {
    stop(paste("Error creating visualizations:", e$message))
  })
}

heatmap <- function(data) {
  tryCatch({
    plot <- ggplot(data) + 
      aes(x = PosiçãoX, y = PosiçãoY, fill = Fixações) + 
      geom_tile() +
      theme_minimal()

    return(plot)
  }, error = function(e) {
    stop(paste("Error creating visualizations:", e$message))
  })
}