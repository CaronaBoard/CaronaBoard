const webpack = require('webpack');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const WebpackBuildNotifierPlugin = require('webpack-build-notifier');
const PATHS = require('../PATHS');

const config = {
  module: {
    loaders: [
       {
         test: /\.scss$/,
         loader: ExtractTextPlugin.extract('style', 'css', 'sass'),
         include: PATHS.style
       }
     ]
  },
  plugins: [
    new webpack.DefinePlugin({
      'process.env': {
        'NODE_ENV': JSON.stringify('production'),
        'BABEL_ENV': JSON.stringify('production')
      }
    }),
    new webpack.optimize.UglifyJsPlugin({
      compress: {
        warnings: false
      }
    }),
    new ExtractTextPlugin('[name].css')
  ]
}

module.exports = config;
