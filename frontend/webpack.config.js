const glob = require("glob")
const path = require("path")

const { WebpackManifestPlugin } = require('webpack-manifest-plugin');

const MODE = 'development';

// ソースマップの利用有無(productionのときはソースマップを利用しない)
const enabledSourceMap = MODE === 'development';

let entries = {}
glob.sync('./entries/*.js').map(file => {
  let name = file.split('/')[2].split('.')[0]
  entries[name] = file
})

module.exports = {
  // モード値を production に設定すると最適化された状態で、
  // development に設定するとソースマップ有効でJSファイルが出力される
  mode: MODE,
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
  module: {
    rules: [{
      test: /\.ts$/,
      // TypeScript をコンパイルする
      use: 'ts-loader',
    }, {
      // CSS, Sassファイルの読み込みとコンパイル
      test: /\.(c|sc)ss$/,
      use: [{
        loader: "style-loader", // linkタグに出力する機能
      }, {
        loader: "css-loader", // CSSをバンドルするための機能
        options: {
          // オプションでCSS内のurl()メソッドを取り込む
          url: true,
          // ソースマップの利用有無
          sourceMap: enabledSourceMap,

          // 0 => no loaders (default);
          // 1 => postcss-loader;
          // 2 => postcss-loader, sass-loader
          importLoaders: 2,
        },
      }, {
        loader: "sass-loader", // Sassをバンドルするための機能
        options: {
          // ソースマップの利用有無
          sourceMap: enabledSourceMap,
        },
      }],
    }, {
      // 対象となるファイルの拡張子
      test: /\.(gif|png|jpg|eot|wof|woff|ttf|svg)$/,
      // 画像をBase64として取り込む
      type: "asset/inline",
    }],
  },
  // import 文で .ts ファイルを解決するため
  // これを定義しないと import 文で拡張子を書く必要が生まれる。
  // フロントエンドの開発では拡張子を省略することが多いので、
  // 記載したほうがトラブルに巻き込まれにくい。
  resolve: {
    // 拡張子を配列で指定
    extensions: ['.js', '.ts'],
    // Webpackで利用するときの設定
    alias: {
      vue: "vue/dist/vue.js",
      '@':  path.resolve(__dirname, './typescripts'),
      '@c': path.resolve(__dirname, './components'),
    },
  },

  devServer: {
    host: '0.0.0.0',
    port: 3040,
    publicPath: '/assets/',
    contentBase: path.resolve(__dirname, '../public/assets'),
    hot: true,
    disableHostCheck: true,
    historyApiFallback: true
  },
}
