const express = require('express');
const logger = require('../utils/logger');
const path = require('path');

const startApiServer = function(PORT) {
  const app = express();

  app.use('/', express.static(path.join(`${__dirname}/../../build`)));

  app.listen(PORT, () => {
    logger.logSuccess('Express server started:', `http://localhost:${PORT}/`);
  });
};

module.exports = startApiServer;
