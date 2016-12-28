module.exports = {
  stripPrefix: 'build/',
  staticFileGlobs: [
    'build/*.html',
    'build/*.js',
    'build/manifest.json',
    'build/images/**/*'
  ],
  dynamicUrlToDependencies: {
    '/v2': ['build/index.html']
  },
  dontCacheBustUrlsMatching: /\.js/,
  swFilePath: 'build/service-worker.js'
};
