const glob = require("glob")
const path = require("path")

const { WebpackManifestPlugin } = require('webpack-manifest-plugin');
const { VueLoaderPlugin } = require('vue-loader');
const ESLintPlugin = require('eslint-webpack-plugin');

const MODE = 'development';

// ソースマップの利用有無(productionのときはソースマップを利用しない)
const enabledSourceMap = MODE === 'development';

let entries = {}
glob.sync('./entries/*.[jt]s').map(file => {
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
    new ESLintPlugin({
      fix: true,
      extensions: ['js', 'ts'],
      files: [
        'views/**/*',
        'entries/**/*',
        'lib/**/*',
        'plugins/**/*',
      ],
    }),
    new VueLoaderPlugin(),
  ],
  output: {
    filename: "javascripts/[name]-[hash].js",
    path: path.resolve(__dirname, "../public/assets"),
  },
  module: {
    rules: [{
      test: /\.ts$/,
      use: [{
        loader: 'ts-loader',
        options: {
          appendTsSuffixTo: [/\.vue$/],
          // transpileOnly: true
        },
      }],
    }, {
      test: /\.vue$/,
      use: 'vue-loader'
    }, {
      // CSS, Sassファイルの読み込みとコンパイル
      test: /\.s(c|a)ss$/,
      use: [{
        loader: "vue-style-loader",
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
          implementation: require('sass'),
        },
      }],
    }, {
      test: /\.css$/,
      use: [{
        loader: "style-loader", // linkタグに出力する機能
      }, {
        loader: 'css-loader',
      }],
    }, {
      test: /\.(eot|svg|ttf|woff|woff2)$/,
      loader: 'file-loader',
      options: {
        name: '[name].[ext]',
        // 出力先 path
        outputPath: 'fonts/',
        // template, css で指定する url path
        publicPath: `/assets/fonts`,
      },
    }, {
      // 対象となるファイルの拡張子
      test: /\.(gif|png|jpg|ttf|svg)$/,
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
    extensions: ['.vue', '.js', '.ts', '.scss', 'css', ' '],
    // Webpackで利用するときの設定
    alias: {
      vue: "vue/dist/vue.js",
      '@':  path.resolve(__dirname, './lib'),
      '@v': path.resolve(__dirname, './views'),
      '@p': path.resolve(__dirname, './plugins'),
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
