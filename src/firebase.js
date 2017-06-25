var firebase = require('firebase');

var config = {
  apiKey: 'AIzaSyDfwHLwWKTqduazsf4kjbstJEA2E1sCeoI',
  authDomain: 'caronaboard-61f75.firebaseapp.com',
  databaseURL: 'https://caronaboard-61f75.firebaseio.com',
  storageBucket: 'caronaboard-61f75.appspot.com',
  messagingSenderId: '617045704123'
};

firebase.initializeApp(config);

var database = firebase.database();

module.exports = function (app) {
  require('./firebase/login')(firebase, database, app);
  require('./firebase/rides')(firebase, database, app);
  require('./firebase/notifications')(firebase, database, app);
}
