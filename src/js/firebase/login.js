const firebase = require("firebase");
const success = require("./helpers").success;
const error = require("./helpers").error;
const saveProfileLocally = require("./profile").saveProfileLocally;

module.exports = (firebase, app) => {
  app.ports.checkRegistration.subscribe(email => {
    firebase
      .auth()
      .fetchProvidersForEmail(email)
      .then(providers => {
        app.ports.checkRegistrationResponse.send(success(providers.length > 0));
      })
      .catch(err => {
        app.ports.checkRegistrationResponse.send(error(err.message));
      });
  });

  app.ports.signIn.subscribe(credentials => {
    firebase
      .auth()
      .signInWithEmailAndPassword(credentials.email, credentials.password)
      .then(saveProfileLocally(firebase, app))
      .catch(err => {
        app.ports.signInResponse.send(error(err.message));
      });
  });

  app.ports.signOut.subscribe(() => {
    firebase
      .auth()
      .signOut()
      .then(signOutUser)
      .catch(err => {
        app.ports.signOutResponse.send(error(err.message));
      });
  });

  const signOutUser = () => {
    localStorage.removeItem("profile");
    app.ports.signOutResponse.send(success(true));
  };

  firebase.auth().onAuthStateChanged(() => {
    const user = firebase.auth().currentUser;
    if (user) {
      saveProfileLocally(firebase, app)(user);
    } else {
      signOutUser();
    }
  });

  app.ports.passwordReset.subscribe(email => {
    firebase
      .auth()
      .sendPasswordResetEmail(email)
      .then(() => {
        app.ports.passwordResetResponse.send(success(true));
      })
      .catch(err => {
        app.ports.passwordResetResponse.send(error(err.message));
      });
  });

  app.ports.signUp.subscribe(credentials => {
    firebase
      .auth()
      .createUserWithEmailAndPassword(credentials.email, credentials.password)
      .then(user => {
        app.ports.signUpResponse.send(success(true));
      })
      .catch(err => {
        app.ports.signUpResponse.send(error(err.message));
      });
  });
};
