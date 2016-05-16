const webpack = require('webpack');
const WebpackDevServer = require('webpack-dev-server');
const logger = require('../utils/logger');
const config = require('../../webpack/webpack.config.js');

const startWebpackServer = function (PORT) {
  const server = new WebpackDevServer(webpack(config), {
    // proxy: {
    //   '*' : `http://localhost:${PORT + 1}`
    // },
     historyApiFallback: true,
     hot: true,
     inline: true,
     progress: true,
     stats: 'errors-only'
    //  host: process.env.HOST,
    //  port: process.env.PORT

  });
  server.listen(PORT, 'localhost');
  logger.logSuccess('webpack server started', `http://localhost:${PORT}`);
};

module.exports = startWebpackServer;
