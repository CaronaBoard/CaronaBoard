let HtmlWebpackPlugin = require('html-webpack-plugin');
let CopyWebpackPlugin = require('copy-webpack-plugin');
let StatsVisualizerPlugin = require('webpack-visualizer-plugin');

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
        exclude: [/elm-stuff/, /node_modules/, /Stylesheets\.elm$/],
        loader:
          process.env.DEBUG ?
            'elm-hot-loader!elm-webpack-loader?debug=true' :
            'elm-webpack-loader'
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
    }]),
    new StatsVisualizerPlugin()
  ]
};

module.exports = config;
