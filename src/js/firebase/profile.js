const firebase = require("firebase");
const checkNotificationToken = require("./notifications")
  .checkNotificationToken;
const success = require("./helpers").success;
const error = require("./helpers").error;

const getProfile = (firebase, app) => {
  return () => {
    return firebase
      .database()
      .ref("profiles/" + firebase.auth().currentUser.uid)
      .once("value");
  };
};

const saveProfileLocally = (firebase, app) => {
  return user => {
    getProfile(firebase, app)().then(profile => {
      localStorage.setItem("profile", JSON.stringify(profile.val()));
      app.ports.signInResponse.send(
        success({
          user: { id: user.uid },
          profile: profile.val()
        })
      );
    });
    checkNotificationToken(firebase, app);
  };
};

module.exports = (firebase, app) => {
  app.ports.saveProfile.subscribe(profile => {
    const currentUser = firebase.auth().currentUser;

    const pathsToUpdate = {};
    pathsToUpdate["profiles/" + currentUser.uid] = profile;

    profile.uid = currentUser.uid;

    firebase
      .database()
      .ref("rides/" + currentUser.uid)
      .once("value", rides => {
        Object.keys(rides.val() || {}).forEach(key => {
          pathsToUpdate[
            "rides/" + currentUser.uid + "/" + key + "/profile"
          ] = profile;
        });

        firebase
          .database()
          .ref()
          .update(pathsToUpdate)
          .then(profileRef => {
            app.ports.profileResponse.send(success(profile));
            saveProfileLocally(firebase, app)(currentUser);
          })
          .catch(err => {
            app.ports.profileResponse.send(error(err.message));
          });
      });
  });
};
module.exports.getProfile = getProfile;
module.exports.saveProfileLocally = saveProfileLocally;
