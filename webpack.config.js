const webpack = require("webpack");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const StatsVisualizerPlugin = require("webpack-visualizer-plugin");

const config = {
  entry: "./src/index.js",
  output: {
    path: `${__dirname}/build`,
    filename: "[name].[hash].js"
  },
  module: {
    rules: [
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/, /Stylesheets\.elm$/],
        use: process.env.DEBUG
          ? ["elm-hot-loader", "elm-webpack-loader?debug=true"]
          : ["elm-webpack-loader"]
      },
      {
        test: /Stylesheets\.elm$/,
        use: ["style-loader", "css-loader?url=false", "elm-css-webpack-loader"]
      },
      {
        test: /\.html$/,
        use: ["raw-loader"]
      }
    ]
  },
  plugins: [
    new webpack.EnvironmentPlugin(["DEBUG"]),
    new HtmlWebpackPlugin({
      template: "src/index.ejs"
    }),
    new CopyWebpackPlugin([
      {
        from: "src/static",
        to: "static"
      }
    ]),
    new CopyWebpackPlugin([
      {
        from: "src/firebase-messaging-sw.js",
        to: ""
      }
    ]),
    new StatsVisualizerPlugin()
  ]
};

module.exports = config;
