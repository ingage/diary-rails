const glob = require("glob")
const path = require("path")

const { WebpackManifestPlugin } = require('webpack-manifest-plugin');

let entries = {}
glob.sync("./entries/*.js").map(file => {
  let name = file.split("/")[2].split(".")[0]
  entries[name] = file
})

module.exports = {
  mode: "development",
  entry: entries,
  plugins: [
    new WebpackManifestPlugin({
      fileName: 'manifest.json',
      publicPath: "/assets/",
      writeToFileEmit: true,
    }),
  ],
  output: {
    filename: "javascripts/[name]-[hash].js",
    path: path.resolve(__dirname, "../public/assets"),
  },

  devServer: {
    host: 'localhost',
    port: 3035,
    publicPath: 'http://localhost:3035/assets/',
    contentBase: path.resolve(__dirname, '../public/assets'),
    hot: true,
    disableHostCheck: true,
    historyApiFallback: true
  },
}
