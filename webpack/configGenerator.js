const merge = require('webpack-merge');
const commonConfig = require('./config/webpack.common.config.js');
const devConfig = require('./config/webpack.development.config');
const prodConfig = require('./config/webpack.production.config');

const configGenerator = (environment) => {

  switch(environment) {
    case 'development':
      return merge(commonConfig, devConfig);
    case 'production':
      return merge(commonConfig, prodConfig);
    default:
      return commonConfig;
  }

};

module.exports = configGenerator;
