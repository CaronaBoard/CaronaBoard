const webpack = require('webpack');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const WebpackBuildNotifierPlugin = require('webpack-build-notifier');
const PATHS = require('../PATHS');

const config = {
  module: {
    loaders: [
       {
         test: /\.scss$/,
         loader: ExtractTextPlugin.extract('style', 'css?sourceMap', 'sass?sourceMap')
       },
       {
         test: /\.css$/,
         loader: ExtractTextPlugin.extract('style', 'css?sourceMap')
       }
     ]
  },
  plugins: [
    new webpack.DefinePlugin({
      'process.env.NODE_ENV': '"production"',
      'process.env.BABEL_ENV': '"production"'
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
