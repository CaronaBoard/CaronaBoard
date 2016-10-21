const express = require('express');
const path = require('path');

const app = express();
const port = process.env.PORT || 8080;

app.get('/', (req, res) => {
  res.sendFile(path.resolve(`${__dirname}/../index.html`));
});

app.get('/v2', (req, res) => {
  res.sendFile(path.resolve(`${__dirname}/../build/index.html`));
});

app.listen(port, () => {
  console.log('Express server started:', `http://localhost:${port}/`);
});

app.use(express.static(path.resolve(`${__dirname}/../build`)));
