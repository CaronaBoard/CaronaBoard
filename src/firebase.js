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

var ridersRef = firebase.database().ref('riders');

var toArrayOfObjects = function (object) {
  return Object.keys(object).reduce(function (accumulated, itemId) {
    var item = Object.assign({id: itemId}, object[itemId]);

    return accumulated.concat([item]);
  }, []);
};

module.exports = function (app) {
  firebase.database().ref('riders').on('value', function (riders) {
    app.ports.riders.send(toArrayOfObjects(riders.val()));
  });

  app.ports.checkRegistration.subscribe(function (email) {
    // 50/50% of chance of the email to exist
    var randResult = Math.floor(Math.random() * 2);

    setTimeout(function () {
      app.ports.checkRegistrationResponse.send(!randResult);
    }, 2000);
  });

  app.ports.signIn.subscribe(function (credentials) {
    // 50/50% of success/error
    var randResult = Math.floor(Math.random() * 2);

    var result = [
      [null, { id: 'example-user-id', name: 'Fulano de Tal' }],
      ['Usuário/Senha Inválido', null]
    ][randResult];

    setTimeout(function () {
      app.ports.signInResponse.send(result);
    }, 3000);
  });
}
