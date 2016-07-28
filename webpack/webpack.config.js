const validate = require('webpack-validator');
const configGenerator = require('./configGenerator');

const currentConfig = configGenerator(process.env.NODE_ENV || 'development');

module.exports = validate(currentConfig);
