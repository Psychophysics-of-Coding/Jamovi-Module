processData <- function(filePath) {
  if (missing(filePath)) {
    stop("O caminho do arquivo não foi fornecido.")
  }

  # Importar os dados utilizando readr
  data <- tryCatch({
    readr::read_csv(filePath, show_col_types = FALSE)
  }, error = function(e) {
    stop("Erro ao ler o arquivo CSV: ", e$message)
  })
  
  # Verificar colunas necessárias
  required_columns <- c("Participante", "Condição", "EDA_mean", "ECG_HR", "EEG_alpha", "EEG_beta", "EyeTracking_Fixations", "STAI_score", "SPSES_score")
  
  missing_columns <- setdiff(required_columns, colnames(data))
  
  if (length(missing_columns) > 0) {
    stop("Colunas ausentes: ", paste(missing_columns, collapse = ", "))
  }
  
  # Converter tipos de dados
  data <- tryCatch({
    data %>%
      dplyr::mutate(
        Participante = as.factor(Participante),
        Condição = as.factor(Condição),
        EDA_mean = as.numeric(EDA_mean),
        ECG_HR = as.numeric(ECG_HR),
        EEG_alpha = as.numeric(EEG_alpha),
        EEG_beta = as.numeric(EEG_beta),
        EyeTracking_Fixations = as.numeric(EyeTracking_Fixations),
        STAI_score = as.numeric(STAI_score),
        SPSES_score = as.numeric(SPSES_score)
      )
  }, error = function(e) {
    stop("Erro ao converter tipos de dados: ", e$message)
  })

  return(data)
}