# analyze_data.R
# This file contains functions for analyzing the psychophysiological data.

# Import necessary libraries
library(ggplot2) # For data visualization
library(ez)      # For repeated measures ANOVA
library(pracma)  # For Fourier Transform
library(jmvcore)

# Function to perform repeated measures ANOVA
runRepeatedMeasuresANOVA - function(data, dependentVar, factors) {
  tryCatch({
    ezANOVA - ezezANOVA(
      data = data,
      dv = dependentVar,
      wid = .(Participante), # Use .(Participante) for within-subjects factor
      within = factors
    )
    return(ezANOVA)
  }, error = function(e) {
    stop(paste(Error performing ANOVA, e$message))
  })
}

# Function to perform Fourier Transform on EEG data
runFourierTransform - function(signalData, sampleRate) {
  tryCatch({
    fftResult - pracmafft(signalData, sampleRate)
    return(fftResult)
  }, error = function(e) {
    stop(paste(Error performing Fourier Transform, e$message))
  })
}

# Function to generate data visualization plots
createVisualizations - function(data) {
  tryCatch({
    plot - ggplot2ggplot(data) +
      ggplot2aes(x = Condição, y = EDA_mean, fill = Condição) +
      ggplot2geom_bar(stat = identity) +
      ggplot2theme_minimal()

    heatmap - ggplot2ggplot(data) + 
      ggplot2aes(x = PosiçãoX, y = PosiçãoY, fill = Fixações) + 
      ggplot2geom_tile() +
      ggplot2theme_minimal()

    return(list(plot = plot, heatmap = heatmap))
  }, error = function(e) {
    stop(paste(Error creating visualizations, e$message))
  })
}

# Main function for data analysis
analyzeData - function(filePath) {
  if (missing(filePath)) {
    stop(No file path provided.)
  }

  # Process the data (assuming processData is defined elsewhere)
  data - processData(filePath)

  # Perform repeated measures ANOVA
  anovaResult - runRepeatedMeasuresANOVA(data, EDA_mean, Condição)

  # Perform Fourier Transform on EEG
  fftResult - runFourierTransform(data$EEG_alpha, 500) # Example using EEG_alpha

  # Create visualizations
  visualizations - createVisualizations(data)

  return(list(anovaResult = anovaResult, fftResult = fftResult, visualizations = visualizations))
}