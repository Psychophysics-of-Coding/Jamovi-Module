// analyze_data.js

'use strict';

const { jmvcore } = require('jamovi-core');

// Function to perform the analysis
async function analyzeData(data, options) {

    // Perform repeated measures ANOVA
    const anovaResult = await jmvcore.R.callFunction(
        'runRepeatedMeasuresANOVA',
        data,
        options.eda,
        [options.condicao] 
    );

    // Perform Fourier Transform on EEG
    const fftResult = await jmvcore.R.callFunction(
        'runFourierTransform',
        data[options.eeg_alpha],
        500 
    );

    // Create visualizations
    const visualizations = await jmvcore.R.callFunction(
        'createVisualizations',
        data,
        options.condicao,
        options.eda
    );

    // Return the results
    return { 
        anovaResult: anovaResult, 
        fftResult: fftResult, 
        visualizations: visualizations 
    };
}

module.exports = analyzeData;