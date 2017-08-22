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
  devServer: {
    host: "0.0.0.0",
    disableHostCheck: true
  },
  plugins: [
    new webpack.EnvironmentPlugin([
      "DEBUG",
      "FIREBASE_API_KEY",
      "FIREBASE_AUTH_DOMAIN",
      "FIREBASE_DATABASE_URL",
      "FIREBASE_STORAGE_BUCKET",
      "FIREBASE_MESSAGING_SENDER_ID"
    ]),
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
        to: "",
        transform: content =>
          content
            .toString()
            .replace(
              "process.env.FIREBASE_MESSAGING_SENDER_ID",
              `"${process.env.FIREBASE_MESSAGING_SENDER_ID}"`
            )
      }
    ]),
    new StatsVisualizerPlugin()
  ]
};

module.exports = config;
