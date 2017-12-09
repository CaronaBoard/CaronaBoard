var firebase = require("firebase");
var success = require("./helpers").success;
var error = require("./helpers").error;
var saveProfileLocally = require("./profile").saveProfileLocally;

module.exports = function(firebase, app) {
  app.ports.checkRegistration.subscribe(function(email) {
    firebase
      .auth()
      .fetchProvidersForEmail(email)
      .then(function(providers) {
        app.ports.checkRegistrationResponse.send(success(providers.length > 0));
      })
      .catch(function(err) {
        app.ports.checkRegistrationResponse.send(error(err.message));
      });
  });

  app.ports.signIn.subscribe(function(credentials) {
    firebase
      .auth()
      .signInWithEmailAndPassword(credentials.email, credentials.password)
      .then(saveProfileLocally(firebase, app))
      .catch(function(err) {
        app.ports.signInResponse.send(error(err.message));
      });
  });

  app.ports.signOut.subscribe(function() {
    firebase
      .auth()
      .signOut()
      .then(signOutUser)
      .catch(function(err) {
        app.ports.signOutResponse.send(error(err.message));
      });
  });

  var signOutUser = function() {
    localStorage.removeItem("profile");
    app.ports.signOutResponse.send(success(true));
  };

  firebase.auth().onAuthStateChanged(function() {
    var user = firebase.auth().currentUser;
    if (user) {
      saveProfileLocally(firebase, app)(user);
    } else {
      signOutUser();
    }
  });

  app.ports.passwordReset.subscribe(function(email) {
    firebase
      .auth()
      .sendPasswordResetEmail(email)
      .then(function() {
        app.ports.passwordResetResponse.send(success(true));
      })
      .catch(function(err) {
        app.ports.passwordResetResponse.send(error(err.message));
      });
  });

  app.ports.signUp.subscribe(function(credentials) {
    firebase
      .auth()
      .createUserWithEmailAndPassword(credentials.email, credentials.password)
      .then(function(user) {
        app.ports.signUpResponse.send(success(true));
      })
      .catch(function(err) {
        app.ports.signUpResponse.send(error(err.message));
      });
  });
};
