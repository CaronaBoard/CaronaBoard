const HtmlWebpackPlugin = require('html-webpack-plugin');
const PATHS = require('../PATHS');

const common = {
    entry: {
      style: [PATHS.style],
      app: [PATHS.app]
    },
    output: {
      path: PATHS.build,
      filename: '[name].[hash].js'
    },
    module: {
      preLoaders: [
        {
          test: /\.js|.jsx?$/,
          loaders: ['eslint'],
          exclude: /node_modules/,
        }
      ],
      loaders: [
        {
          test: /\.js|.jsx$/,
          exclude: /node_modules/,
          loader: 'babel'
        },
        {
          test: /\.(png|jpg|gif)$/,
          loader: 'url-loader?limit=8192'
        }
      ]
    },
    plugins: [
      new HtmlWebpackPlugin({
        template: PATHS.pageTemplate
      })
    ],
    eslint: {
      configFile: PATHS.eslintConfig,
      emitError: true
    }
};


module.exports = common;
