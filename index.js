const express = require('express');
const app = express();
const babelify = require('babelify');
const browserify = require('browserify-middleware');

const PORT = process.env.PORT || 3000;

app.get('/js/common.js', browserify(['react', 'react-router', 'react-dom'], {
  cache: true,
  precompile: true
}));

app.use('/js', browserify(`${__dirname}/public/app/index.jsx`, {
  extensions: ['.js', '.jsx'],
  transform: [babelify.configure({
    presets: ['es2015', 'react']
  })]
}));

app.get('/', (req, res) => {
  res.sendFile(`${__dirname}/index.html`);
});

app.get('/v2', (req, res) => {
  res.sendFile(`${__dirname}/index2.html`);
});

app.use(express.static(`${__dirname}/public`));
app.listen(PORT, () => {
  console.log(`Listening on ${PORT}`);
});
