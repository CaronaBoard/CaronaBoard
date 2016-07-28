import express from 'express';
import session from 'express-session';
import logger from '../utils/logger';
import path from 'path';
import querystring from 'querystring';
import {OKTA_CONFIG, SERVER_CONFIG} from './config';
import bodyParser from 'body-parser';
import jwt from 'jsonwebtoken';
import morgan from 'morgan';
import FEATURES from '../features';

const startExpressServer = (oktaFetcher, PORT) => {
  const app = express();
  app.use(bodyParser.json());
  app.use(bodyParser.urlencoded({ extended: false }));
  app.use(session({ secret: SERVER_CONFIG.SESSION_SECRET,
                    resave: true,
                    saveUninitialized: false }));
  app.use(morgan('combined'));

  if(JSON.parse(FEATURES.OKTA_INTEGRATION)) {
    app.post('/login/callback', (req, res) => {
      const token = req.body.id_token;
      const dirtyToken = jwt.decode(token, {complete: true});
      // need to validate token before setting user to session here
      // const verifiedToken = jwt.verify(token, OKTA_CONFIG.OKTA_PUBLIC_KEYS, {algorithms: ['RS256']});
      req.session.user = dirtyToken.payload.email;
      res.redirect('/');
    });

    app.use((req, res, next) => {
      if(!req.session.user) {
        // if there is no user in session, redirect to okta
        const params = querystring.stringify({
          redirect_uri: OKTA_CONFIG.OKTA_REDIRECT_URI,
          client_id: OKTA_CONFIG.OKTA_CLIENT_ID,
          response_type: 'id_token',
          response_mode: 'form_post',
          scope: 'openid email groups',
          state: 'carona-board'
        });
        const encodedURI = `${OKTA_CONFIG.OKTA_BASE_URL}/oauth2/v1/authorize?${params}`;
        res.redirect(encodedURI);
      } else {
        next();
      }
    });
  }

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

export default startExpressServer;
