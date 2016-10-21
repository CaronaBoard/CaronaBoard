let HtmlWebpackPlugin = require('html-webpack-plugin');
let CopyWebpackPlugin = require('copy-webpack-plugin');
let ExtractTextPlugin = require('extract-text-webpack-plugin');
let validate = require('webpack-validator');

const config = {
  devtool: 'source-map',
  entry: './src/public/index.js',
  output: {
    path: 'build',
    filename: '[name].[hash].js'
  },
  module: {
    loaders: [
      {
        test: /\.s?css$/,
        loader: ExtractTextPlugin.extract('style-loader', 'css-loader?sourceMap!sass-loader?sourceMap')
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: 'elm-webpack'
      },
      {
        test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: "url-loader?limit=10000&mimetype=application/font-woff"
      },
      {
        test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: "url-loader?limit=10000"
      }
    ]
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: 'src/public/index.html'
    }),
    new CopyWebpackPlugin([
      { from: 'src/public/images', to: 'images' }
    ]),
    new ExtractTextPlugin('[name].css')
  ]
};

module.exports = validate(config);
