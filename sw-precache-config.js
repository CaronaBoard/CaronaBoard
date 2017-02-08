module.exports = {
  stripPrefix: 'build/',
  staticFileGlobs: [
    'build/*.html',
    'build/*.js',
    'build/manifest.json',
    'build/images/**/*'
  ],
  runtimeCaching: [{
    urlPattern: /cdnjs/,
    handler: 'cacheFirst'
  }],
  dontCacheBustUrlsMatching: /\.js/,
  swFilePath: 'build/service-worker.js'
};
