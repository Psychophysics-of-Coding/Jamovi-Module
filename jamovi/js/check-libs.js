const { execSync } = require('child_process');

// Função para garantir que os pacotes necessários estão instalados e carregados
function ensurePackages(packages) {
    packages.forEach(pkg => {
        try {
            // Verifica se o pacote está resolvido
            require.resolve(pkg);
        } catch (e) {
            console.log(`Pacote ausente: ${pkg}. Instalando...`);
            // Instala o pacote usando npm
            execSync(`npm install ${pkg}`, { stdio: 'inherit' });
        }

        try {
            // Tenta carregar o pacote
            require(pkg);
            console.log(`${pkg} carregado com sucesso.`);
        } catch (e) {
            throw new Error(`Falha ao carregar o pacote: ${pkg}. Erro: ${e.message}`);
        }
    });
}

// Lista de pacotes necessários
const requiredPackages = ['dplyr', 'readr', 'ggplot2', 'plotly'];

// Garante que os pacotes estão instalados
ensurePackages(requiredPackages);

// Verifica a presença do GitHub PAT
if (!process.env.GITHUB_PAT) {
    throw new Error('Erro: O GitHub PAT (Personal Access Token) não está configurado. Use gitcreds::gitcreds_set() para adicionar o seu.');
} else {
    console.log('GitHub PAT encontrado.');
}

try {
    // Comando para instalar o pacote jmvcore via remotes
    execSync('Rscript -e "remotes::install_github(\'jamovi/jmvcore\')"', { stdio: 'inherit' });
    console.log('Pacote jmvcore instalado com sucesso.');
} catch (e) {
    throw new Error('Erro ao instalar o pacote jmvcore: ' + e.message);
}