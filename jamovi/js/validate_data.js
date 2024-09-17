function validateData(data) {
  if (!data || data.length === 0) {
    throw new Error("No data provided or data is empty.");
  }

  const requiredColumns = ["Participante", "Condição", "EDA_mean", "ECG_HR", "EEG_alpha", "EEG_beta", "EyeTracking_Fixations", "STAI_score", "SPSES_score"];

  const missingColumns = requiredColumns.filter(col => !data.columns.includes(col));
  
  if (missingColumns.length > 0) {
    throw new Error("Missing columns: " + missingColumns.join(", "));
  }

  return true; // Data is valid
}