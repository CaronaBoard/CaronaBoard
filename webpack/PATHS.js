const path = require('path');

module.exports = {
  app: path.join(`${__dirname}/../src/public/index.jsx`),
  style: path.join(`${__dirname}/../src/public/css/main.scss`),
  build: path.join(`${__dirname}/../build`),
  pageTemplate: path.join(`${__dirname}/../src/public/index.html`),
  eslintConfig: path.join(`${__dirname}/../.eslintrc`)
}
