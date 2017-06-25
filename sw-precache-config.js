module.exports = {
  stripPrefix: 'build/',
  staticFileGlobs: [
    'build/*.{html,js,css}',
    'build/*.js',
    'build/manifest.json',
    'build/static/**/*'
  ],
  runtimeCaching: [{
    urlPattern: /cdnjs|fonts\.googleapis/,
    handler: 'cacheFirst'
  }],
  dontCacheBustUrlsMatching: /\.js/,
  swFilePath: 'build/service-worker.js'
};
