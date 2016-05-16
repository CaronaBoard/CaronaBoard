const WebpackBuildNotifierPlugin = require('webpack-build-notifier');
const webpack = require('webpack');

const config = {
  devtool: 'source-map',
  module: {
    loaders: [
      {
        test: /\.scss$/,
        loader: 'style!css!sass'
       }
    ]
  },
  entry: {
    app: ['webpack-dev-server/client?http://0.0.0.0:8079',
          'webpack/hot/only-dev-server']
  },
  plugins: [
    new webpack.DefinePlugin({
      'process.env': {
        'NODE_ENV': JSON.stringify('development')
      }
    }),
    new webpack.HotModuleReplacementPlugin(),
    new WebpackBuildNotifierPlugin({successSound:false})
  ],
};

module.exports = config;
