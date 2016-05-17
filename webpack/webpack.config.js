const merge = require('webpack-merge');
const validate = require('webpack-validator');
const commonConfig = require('./config/webpack.common.config.js');
const devConfig = require('./config/webpack.development.config');
const prodConfig = require('./config/webpack.production.config');

const bundleConfig = function(environment) {

  switch(environment) {
    case 'development':
      return merge(commonConfig, devConfig);
    case 'production':
      return merge(commonConfig, prodConfig);
    default:
      return commonConfig;
  }

};

const currentConfig = bundleConfig(process.env.NODE_ENV);

module.exports = validate(currentConfig);
