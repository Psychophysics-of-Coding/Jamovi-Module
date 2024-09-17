'use strict';

const { Analysis } = require('jamovi-core');
const { processData } = require('./process_data');

class PsychophysiologicalAnalysis extends Analysis {
    constructor(options, data) {
        super(options, data);
    }

    async run() {
        // Verificar se as variáveis necessárias foram selecionadas
        if (!this.options.condicao || !this.options.eda || !this.options.ecg || !this.options.eeg_alpha || !this.options.eyetracking) {
            throw new Error('Some required variables are not selected.');
        }

        // Processar os dados
        let processedData;
        try {
            processedData = await processData(this.data);
        } catch (e) {
            throw new Error('Error processing data: ' + e.message);
        }

        // Realizar análise (assumindo que uma função de análise exista)
        try {
            const analysisResult = await this.performAnalysis(processedData);
            return analysisResult;
        } catch (e) {
            throw new Error('Error performing analysis: ' + e.message);
        }
    }

    async performAnalysis(data) {
        // Implementar lógica de análise aqui
        // Exemplo: realizar ANOVA ou correlações
        return {}; // Retornar resultados
    }
}

module.exports = PsychophysiologicalAnalysis;