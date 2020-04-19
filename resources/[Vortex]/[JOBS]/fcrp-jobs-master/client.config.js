const path = require('path');
const webpack = require('webpack');
const JscramblerWebpack = require('jscrambler-webpack-plugin');

module.exports = {
  entry: "./src/client/client.js",
  module: {
    rules: [
      {
        test: /\.js?$/,
        exclude: /node_modules/
      }
    ]
  }, 
  plugins: [
    // other plugins
    new JscramblerWebpack({
      enable: true, // optional, defaults to true
      chunks: ['client.js'], // optional, defaults to all chunks
      params: [], // optional, can be used to override .jscramblerrc
      applicationTypes: {} // optional
      // and other jscrambler configurations
    })
  ],
  resolve: {
    extensions: [".tsx", ".ts", ".js"]
  },
  output: {
    filename: "client.js",
    path: path.resolve(__dirname, "../", "../", "fcrp-newgamemode/", "resources/", "[FCRP]/", "[JOBS]/", "fcrp_carteiro")
  }
};
