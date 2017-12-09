var firebase = require("firebase");
var checkNotificationToken = require("./notifications").checkNotificationToken;
var success = require("./helpers").success;
var error = require("./helpers").error;

var getProfile = function(firebase, app) {
  return function() {
    return firebase
      .database()
      .ref("profiles/" + firebase.auth().currentUser.uid)
      .once("value");
  };
};

var saveProfileLocally = function(firebase, app) {
  return function(user) {
    getProfile(firebase, app)().then(function(profile) {
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

module.exports = function(firebase, app) {
  app.ports.saveProfile.subscribe(function(profile) {
    var currentUser = firebase.auth().currentUser;

    var pathsToUpdate = {};
    pathsToUpdate["profiles/" + currentUser.uid] = profile;

    profile.uid = currentUser.uid;

    firebase
      .database()
      .ref("rides/" + currentUser.uid)
      .once("value", function(rides) {
        Object.keys(rides.val() || {}).forEach(function(key) {
          pathsToUpdate[
            "rides/" + currentUser.uid + "/" + key + "/profile"
          ] = profile;
        });

        firebase
          .database()
          .ref()
          .update(pathsToUpdate)
          .then(function(profileRef) {
            app.ports.profileResponse.send(success(profile));
            saveProfileLocally(firebase, app)(currentUser);
          })
          .catch(function(err) {
            app.ports.profileResponse.send(error(err.message));
          });
      });
  });
};
module.exports.getProfile = getProfile;
module.exports.saveProfileLocally = saveProfileLocally;
