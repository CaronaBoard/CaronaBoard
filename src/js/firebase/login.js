import { error, success } from "./helpers";
import { saveProfileLocally } from "./profile";

export default (firebase, ports) => {
  const { auth } = firebase;

  ports.checkRegistration.subscribe(email =>
    auth()
      .fetchProvidersForEmail(email)
      .then(providers =>
        ports.checkRegistrationResponse.send(success(providers.length > 0))
      )
      .catch(err => ports.checkRegistrationResponse.send(error(err.message)))
  );

  ports.signIn.subscribe(credentials =>
    auth()
      .signInWithEmailAndPassword(credentials.email, credentials.password)
      .then(saveProfileLocally(firebase, ports))
      .catch(err => ports.signInResponse.send(error(err.message)))
  );

  ports.signOut.subscribe(() =>
    auth()
      .signOut()
      .then(signOutUser)
      .catch(err => ports.signOutResponse.send(error(err.message)))
  );

  const signOutUser = () => {
    localStorage.removeItem("profile");
    ports.signOutResponse.send(success(true));
  };

  auth().onAuthStateChanged(() => {
    const user = auth().currentUser;
    if (user) {
      saveProfileLocally(firebase, ports)(user);
    } else {
      signOutUser();
    }
  });

  ports.passwordReset.subscribe(email =>
    auth()
      .sendPasswordResetEmail(email)
      .then(() => ports.passwordResetResponse.send(success(true)))
      .catch(err => ports.passwordResetResponse.send(error(err.message)))
  );

  ports.signUp.subscribe(credentials =>
    auth()
      .createUserWithEmailAndPassword(credentials.email, credentials.password)
      .then(user => ports.signUpResponse.send(success(true)))
      .catch(err => ports.signUpResponse.send(error(err.message)))
  );
};
