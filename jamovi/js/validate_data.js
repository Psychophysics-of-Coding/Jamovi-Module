// validate_data.js
// This file validates the presence of required columns and data types.

'use strict';

const { jmvcore } = require('jamovi-core');

// Function to validate the data
async function validateData(data) {
    // Required columns
    const requiredColumns = [
        'Participante',
        'Condição',
        'EDA_mean',
        'ECG_HR',
        'EEG_alpha',
        'EEG_beta',
        'EyeTracking_Fixations',
        'STAI_score',
        'SPSES_score'
    ];

    // Check if all required columns are present
    const missingColumns = requiredColumns.filter(col => !(col in data));
    if (missingColumns.length > 0) {
        throw new Error(`Missing columns in data: ${missingColumns.join(', ')}`);
    }

    // Validate data types (you might need to adjust this based on your data)
    for (let col of requiredColumns) {
        if (typeof data[col][0] !== 'number' && col !== 'Participante' && col !== 'Condição') { // Assuming numeric data except for Participante and Condição
            throw new Error(`Column '${col}' should be numeric.`);
        }
    }

    console.log('Data validation successful.');
}

module.exports = validateData;