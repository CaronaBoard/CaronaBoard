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

var ridesRef = firebase.database().ref('rides');

var toArrayOfObjects = function (object) {
  return Object.keys(object).reduce(function (accumulated, itemId) {
    var item = Object.assign({id: itemId}, object[itemId]);

    return accumulated.concat([item]);
  }, []);
};

module.exports = function (app) {
  var fetchRides = function () {
    firebase.database().ref('rides').on('value', function (rides) {
      app.ports.rides.send(toArrayOfObjects(rides.val()));
    });
  };

  app.ports.checkRegistration.subscribe(function (email) {
    firebase.auth().fetchProvidersForEmail(email).then(function (providers) {
      app.ports.checkRegistrationResponse.send(providers.length > 0);
    }).catch(function () {
      app.ports.checkRegistrationResponse.send(false);
    });
  });

  app.ports.signIn.subscribe(function (credentials) {
    firebase.auth().signInWithEmailAndPassword(credentials.email, credentials.password)
      .then(signInUser)
      .catch(function (error) {
        app.ports.signInResponse.send([error.message, null]);
      });
  });

  app.ports.signOut.subscribe(function () {
    firebase.auth().signOut().then(signOutUser);
  });

  var signInUser = function (user) {
    app.ports.signInResponse.send([null, {id: user.uid, name: user.displayName || ""}]);
    fetchRides();
  };

  var signOutUser = function () {
    app.ports.signOutResponse.send(null);
  };

  firebase.auth().onAuthStateChanged(function () {
    var user = firebase.auth().currentUser;
    if (user) {
      signInUser(user);
    } else {
      signOutUser();
    }
  });

  app.ports.passwordReset.subscribe(function (email) {
    firebase.auth().sendPasswordResetEmail(email).then(function () {
      app.ports.passwordResetResponse.send(null);
    }).catch(function (error) {
      app.ports.passwordResetResponse.send(error.message);
    });
  });

  app.ports.giveRide.subscribe(function (newRide) {
    newRide.formUrl = newRide.formUrl || '';
    firebase.database().ref('rides').push(newRide).then(function (rideRef) {
      rideRef.once('value').then(function (ride) {
        app.ports.giveRideResponse.send([null, Object.assign({id: ride.getKey()}, ride.val()) ]);
      });
    }).catch(function (error) {
      app.ports.giveRideResponse.send([error.message, null]);
    });
  });
}
