import webpack from 'webpack';
import WebpackDevServer from 'webpack-dev-server';
import logger from '../utils/logger';
import config from '../../webpack/webpack.config.js';

const startWebpackServer = (PORT) => {
  const server = new WebpackDevServer(webpack(config), {
     historyApiFallback: true,
     hot: true,
     inline: true,
     progress: true,
     stats: 'errors-only',
     port: PORT

  });
  server.listen(PORT, 'localhost');
  logger.logSuccess('webpack server started', `http://localhost:${PORT}`);
};

export default startWebpackServer;
