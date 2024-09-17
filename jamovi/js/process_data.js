// process_data.js
// This file handles the pre-processing and filtering of neurophysiological data.

'use strict';

const { jmvcore } = require('jamovi-core'); 
const R = jmvcore.R;

// Function to import data from the CSV file
async function importData(filePath) {
    try {
        const data = await R.readCsv(filePath);
        return data;
    } catch (error) {
        throw new Error(`Error importing CSV file: ${error.message}`);
    }
}

// Function to apply signal filtering (EEG and ECG)
async function filterSignal(data, columnName, lowFreq, highFreq, sampleRate) {
    try {
        const filteredData = await R.callFunction('filterSignal', data[columnName], lowFreq, highFreq, sampleRate);
        return filteredData;
    } catch (error) {
        throw new Error(`Error filtering signals: ${error.message}`);
    }
}

// Function for artifact detection and correction in EDA and ECG
async function correctArtifacts(data, columnName) {
    try {
        const correctedData = await R.callFunction('correctArtifacts', data[columnName]);
        return correctedData;
    } catch (error) {
        throw new Error(`Error correcting artifacts: ${error.message}`);
    }
}

// Function to scale data
async function scaleData(data, columnName) {
    try {
        const scaledData = await R.callFunction('scaleData', data[columnName]);
        return scaledData;
    } catch (error) {
        throw new Error(`Error scaling data: ${error.message}`);
    }
}

// Main function to process the data
async function processData(filePath) {
    if (!filePath) {
        throw new Error('No file path provided.');
    }

    // Import the data
    let data;
    try {
        data = await importData(filePath);
    } catch (error) {
        throw new Error(`Error importing data: ${error.message}`);
    }

    // Apply signal filtering to ECG and EEG
    try {
        data['ECG_HR'] = await filterSignal(data, 'ECG_HR', 0.5, 50, 500);  // Example ECG filtering
        data['EEG_alpha'] = await filterSignal(data, 'EEG_alpha', 8, 12, 500);  // Example EEG alpha band filtering
        data['EEG_beta'] = await filterSignal(data, 'EEG_beta', 13, 30, 500);   // Example EEG beta band filtering
    } catch (error) {
        throw new Error(`Error filtering signals: ${error.message}`);
    }

    // Apply artifact correction to EDA and ECG signals
    try {
        data['EDA_mean'] = await correctArtifacts(data, 'EDA_mean');
        data['ECG_HR'] = await correctArtifacts(data, 'ECG_HR');
    } catch (error) {
        throw new Error(`Error correcting artifacts: ${error.message}`);
    }

    // Scale the neurophysiological data
    try {
        data['EDA_mean'] = await scaleData(data, 'EDA_mean');
        data['ECG_HR'] = await scaleData(data, 'ECG_HR');
        data['EEG_alpha'] = await scaleData(data, 'EEG_alpha');
        data['EEG_beta'] = await scaleData(data, 'EEG_beta');
    } catch (error) {
        throw new Error(`Error scaling data: ${error.message}`);
    }

    console.log('Data processed successfully.');
    return data;
}

module.exports = { processData, importData };