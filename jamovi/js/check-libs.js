// check-libs.js
// This file checks for the presence of essential libraries for module execution.

const { execSync } = require('child_process');

// Function to check and install R packages if necessary
function ensurePackages(packages) {
    packages.forEach(pkg => {
        try {
            execSync(`Rscript -e "if (!requireNamespace('${pkg}', quietly = TRUE)) install.packages('${pkg}', dependencies = TRUE)"`, { stdio: 'inherit' });
            execSync(`Rscript -e "library('${pkg}')"`, { stdio: 'inherit' });
        } catch (error) {
            console.error(`Error installing/loading R package: ${pkg}`);
            process.exit(1);  // Exit with error code
        }
    });
}

// Essential R packages for the module
const requiredPackages = [
    'dplyr',
    'readr',
    'ggplot2',
    'ez',
    'pracma',
    'signal',
    'jmvcore' // Use jmvcore instead of jamovi
];

// Check and install the packages
ensurePackages(requiredPackages);

console.log("All necessary R packages are installed and loaded successfully.");