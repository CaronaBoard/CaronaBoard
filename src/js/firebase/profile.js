const firebase = require("firebase");
const checkNotificationToken = require("./notifications")
  .checkNotificationToken;
const success = require("./helpers").success;
const error = require("./helpers").error;

const getProfile = ({ database, auth }, ports) => () =>
  database()
    .ref("profiles/" + auth().currentUser.uid)
    .once("value");

const saveProfileLocally = (firebase, ports) => user => {
  getProfile(firebase, ports)().then(profile => {
    localStorage.setItem("profile", JSON.stringify(profile.val()));

    ports.signInResponse.send(
      success({
        user: { id: user.uid },
        profile: profile.val()
      })
    );
  });

  checkNotificationToken(firebase, ports);
};

module.exports = (firebase, ports) => {
  const { auth, database } = firebase;

  ports.saveProfile.subscribe(profile => {
    const currentUser = auth().currentUser;

    const pathsToUpdate = {};
    pathsToUpdate["profiles/" + currentUser.uid] = profile;

    profile.uid = currentUser.uid;

    database()
      .ref("rides/" + currentUser.uid)
      .once("value", rides => {
        Object.keys(rides.val() || {}).forEach(key => {
          pathsToUpdate[
            "rides/" + currentUser.uid + "/" + key + "/profile"
          ] = profile;
        });

        database()
          .ref()
          .update(pathsToUpdate)
          .then(profileRef => {
            ports.profileResponse.send(success(profile));
            saveProfileLocally(firebase, ports)(currentUser);
          })
          .catch(err => ports.profileResponse.send(error(err.message)));
      });
  });
};

module.exports.getProfile = getProfile;
module.exports.saveProfileLocally = saveProfileLocally;
