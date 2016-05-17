const express = require('express');
const logger = require('../utils/logger');
const path = require('path');

const startApiServer = function(PORT) {
  const app = express();

  // app.use('/', express.static(path.join(`${__dirname}/../../build`)));
  app.get('/', (req, res) => {
    res.sendFile(path.resolve(`${__dirname}/../../index.html`));
  });

  app.get('/v2', (req, res) => {
    res.sendFile(path.resolve(`${__dirname}/../../build/index.html`));
  });

  app.listen(PORT, () => {
    logger.logSuccess('Express server started:', `http://localhost:${PORT}/`);
  });

  app.use(express.static(path.resolve(`${__dirname}/../../build`)));

};

module.exports = startApiServer;
