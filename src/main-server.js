const logger = require('./utils/logger');
const PORT = process.env.PORT || 8080;
const PROD = process.env.NODE_ENV === 'production';

logger.logSuccess('Environment', process.env.NODE_ENV);

if(PROD) {
  const expressServer = require('./express/server');
  expressServer(PORT);
} else {
  const webpackServer = require('./webpack/server');
  webpackServer(PORT - 1);
}
