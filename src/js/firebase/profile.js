var firebase = require("firebase");
var fetchRides = require("./rides").fetchRides;
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

module.exports = function(firebase, app) {
  app.ports.saveProfile.subscribe(function(profile) {
    var currentUser = firebase.auth().currentUser;

    var pathsToUpdate = {};
    pathsToUpdate["profiles/" + currentUser.uid] = profile;

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
          })
          .catch(function(error) {
            app.ports.profileResponse.send(error(error.message));
          });
      });
  });
};
module.exports.getProfile = getProfile;
