// psychophysiological_analysis.js

'use strict';

const { Analysis } = require('jamovi-core');
const { processData } = require('./process_data');

class PsychophysiologicalAnalysis extends Analysis {
    constructor(options, data) {
        super(options, data);
    }

    async run() {
        // Check if required variables are selected
        if (!this.options.condicao || !this.options.eda || !this.options.ecg || !this.options.eeg_alpha || !this.options.eyetracking) {
            throw new Error('Some required variables are not selected.');
        }

        // Process the data
        let processedData;
        try {
            processedData = await processData(this.data);
        } catch (error) {
            throw new Error(`Error processing data: ${error.message}`);
        }

        // Perform the analysis (call R functions here)
        // ... (Your analysis logic using jmvcore.R.callFunction) ...

        // Example: Call the R function 'psychophysiologicalAnalysis'
        const results = await jmvcore.R.callFunction(
            'psychophysiologicalAnalysis', 
            processedData,
            this.options.condicao,
            this.options.eda,
            this.options.ecg,
            this.options.eeg_alpha,
            this.options.eyetracking
        );

        // Set the results
        this.results.set('summary', results.summary);
        this.results.set('anova', results.anova);
        this.results.set('plot', results.plot);
    }
}

module.exports = PsychophysiologicalAnalysis;