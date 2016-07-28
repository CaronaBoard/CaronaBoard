const HtmlWebpackPlugin = require('html-webpack-plugin');
const PATHS = require('../PATHS');
const common = {
    devtool: 'source-map',
    entry: {
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
          loaders: ['eslint-loader'],
          exclude: /node_modules/
        }
      ],
      loaders: [
        {
          test: /\.js|.jsx$/,
          exclude: /node_modules/,
          loader: 'babel-loader'
        },
        {
           test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
           loader: 'url-loader?limit=10000&mimetype=application/font-woff'
        },
        {
          test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
          loader: 'url-loader?limit=10000'
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
