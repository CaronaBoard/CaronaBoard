const WebpackBuildNotifierPlugin = require('webpack-build-notifier');
const webpack = require('webpack');

const config = {
  output: {
    publicPath: "http://localhost:8079/",
  },
  module: {
    loaders: [
      {
        test: /\.css$/,
        loaders: ['style-loader', 'css-loader?sourceMap']
      },
      {
        test: /\.scss$/,
        loaders: ['style-loader', 'css-loader?sourceMap', 'sass-loader?sourceMap']
      },
    ]
  },
  entry: {
    app: [
      'webpack-dev-server/client?http://0.0.0.0:8079',
      'webpack/hot/only-dev-server'
    ]
  },
  plugins: [
    new webpack.DefinePlugin({
      'process.env.NODE_ENV': '"development"',
      'process.env.BABEL_ENV': '"development"'
    }),
    new webpack.HotModuleReplacementPlugin(),
    new WebpackBuildNotifierPlugin({successSound:false})
  ],
};

module.exports = config;
