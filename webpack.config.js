let HtmlWebpackPlugin = require('html-webpack-plugin');
let CopyWebpackPlugin = require('copy-webpack-plugin');

const config = {
  entry: './src/index.js',
  output: {
    path: `${__dirname}/build`,
    filename: '[name].[hash].js'
  },
  module: {
    loaders: [
      {
        test: /Stylesheets\.elm$/,
        loader: 'style-loader!css-loader?url=false!elm-css-webpack-loader'
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader:
          process.env.NODE_ENV === 'production' ?
            'elm-webpack-loader' :
            'elm-hot-loader!elm-webpack-loader?debug=true'
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

module.exports = config;
