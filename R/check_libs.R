function ensurePackages(packages) {
    const execSync = require('child_process').execSync;

    packages.forEach(pkg => {
        try {
            require.resolve(pkg);
        } catch (e) {
            console.log(`Installing missing package: ${pkg}`);
            execSync(`npm install ${pkg}`, { stdio: 'inherit' });
        }

        try {
            require(pkg);
            console.log(`${pkg} loaded successfully.`);
        } catch (e) {
            throw new Error(`Failed to load package: ${pkg}. Error: ${e.message}`);
        }
    });
}

const requiredPackages = ['dplyr', 'readr', 'ggplot2', 'plotly'];
ensurePackages(requiredPackages);