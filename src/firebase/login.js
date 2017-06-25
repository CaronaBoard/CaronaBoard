var firebase = require('firebase');
var fetchRides = require('./rides').fetchRides;

module.exports = function (firebase, database, app) {
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
    fetchRides(firebase, database, app);
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
}
