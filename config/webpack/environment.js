const { environment } = require('@rails/webpacker')
const webpack = require('webpack')
const { BundleAnalyzerPlugin } = require('webpack-bundle-analyzer')

environment.plugins.append('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: ['popper.js', 'default']
  })
)
environment.plugins.append(
  'BundleAnalyzer', new BundleAnalyzerPlugin()
)
module.exports = environment
