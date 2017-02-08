module.exports = {
  stripPrefix: 'build/',
  staticFileGlobs: [
    'build/*.html',
    'build/*.js',
    'build/manifest.json',
    'build/images/**/*'
  ],
  dontCacheBustUrlsMatching: /\.js/,
  swFilePath: 'build/service-worker.js'
};
