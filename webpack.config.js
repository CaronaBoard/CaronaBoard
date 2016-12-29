let HtmlWebpackPlugin = require('html-webpack-plugin');
let CopyWebpackPlugin = require('copy-webpack-plugin');
let validate = require('webpack-validator');

const config = {
  entry: './src/index.js',
  output: {
    path: `${__dirname}/build`,
    filename: '[name].[hash].js'
  },
  module: {
    loaders: [
      {
        test: /\.s?css$/,
        loaders: ['raw-loader', 'sass-loader']
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: 'elm-webpack-loader'
      },
      {
        test: /\.html$/,
        loader: 'raw-loader'
      }
    ]
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: 'src/index.ejs'
    }),
    new CopyWebpackPlugin([{
      from: 'src/images',
      to: 'images'
    }])
  ]
};

module.exports = validate(config);
