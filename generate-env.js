function generateEnvironmentContent() {
  return `export const environment = {
  production: ${process.env.IS_PRODUCTION || false},
  HOST: "${process.env.HOST || 'http://localhost:4200'}",
  API_URL: "${process.env.API_URL || 'http://localhost:3000/api'}"
  };`;
}
(function generateEnvironment() {
  const fs = require('fs');
  const fileName = 'environment.ts'; // you can this as hard coded name, or you can use your own unique name
  const content = generateEnvironmentContent();
  process.chdir(`apps/fe/src/environments`); // This is the directory where you created the environment file. you can use your own path, but for this I used the Angular default environment directory
  fs.writeFile(fileName, content, (err) => {
    err ? console.log(err) : console.log('env is generated!');
  });
})();
