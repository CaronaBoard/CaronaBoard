import logger from './utils/logger';
import requestPromise from 'request-promise';
import OktaFetcher from './fetchers/OktaFetcher';
import startExpressServer from './express/server';
import startWebpackServer from './webpack/server';

const PORT = process.env.PORT || 8080;
const PROD = process.env.NODE_ENV === 'production';

logger.logSuccess('Environment', process.env.NODE_ENV);

if(PROD) {
  startExpressServer(new OktaFetcher(requestPromise), PORT);
} else {
  startWebpackServer(PORT - 1);
}
