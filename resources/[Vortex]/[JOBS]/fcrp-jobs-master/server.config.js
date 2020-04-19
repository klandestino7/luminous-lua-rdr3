const path = require('path');
const webpack = require('webpack');

module.exports = {
  target: 'node',
  entry: "./src/server/server.js",
  module: {
    rules: [
      {
        test: /\.js?$/,
        exclude: /node_modules/
      }
    ]
  },
  resolve: {
    extensions: [".tsx", ".ts", ".js"]
  },
  output: {
    filename: "server.js",
    path: path.resolve(__dirname, "../", "../", "fcrp-newgamemode/", "resources/", "[FCRP]/", "[JOBS]/", "fcrp_carteiro")
  }
};
