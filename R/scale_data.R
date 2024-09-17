# scale_data.R
# This file contains the function to scale data.

scaleData - function(data) {
  # Calculate the mean and standard deviation of the data
  data_mean - mean(data)
  data_sd - sd(data)
  
  # Scale the data using z-score standardization
  scaled_data - (data - data_mean)  data_sd
  
  return(scaled_data)
}