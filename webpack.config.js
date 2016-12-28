let HtmlWebpackPlugin = require('html-webpack-plugin');
let CopyWebpackPlugin = require('copy-webpack-plugin');
let validate = require('webpack-validator');

const config = {
  devtool: 'source-map',
  entry: './src/index.js',
  output: {
    path: `${__dirname}/build`,
    filename: '[name].[hash].js'
  },
  module: {
    loaders: [
      {
        test: /\.s?css$/,
        loaders: ['style-loader', 'css-loader', 'sass-loader']
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: 'elm-webpack-loader'
      }
    ]
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: 'src/index.html'
    }),
    new CopyWebpackPlugin([{
      from: 'src/images',
      to: 'images'
    }])
  ]
};

module.exports = validate(config);
