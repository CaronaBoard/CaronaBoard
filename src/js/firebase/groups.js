var success = require("./helpers").success;
var error = require("./helpers").error;

module.exports = function(firebase, app) {
  var getProfile = require("./profile").getProfile(firebase, app);

  app.ports.groupsList.subscribe(function() {
    firebase
      .database()
      .ref("groups")
      .once("value")
      .then(function(groups) {
        app.ports.groupsListResponse.send(success(groups.val()));
      })
      .catch(function(err) {
        app.ports.groupsListResponse.send(error(err.message));
      });
  });

  app.ports.createJoinGroupRequest.subscribe(function(joinGroupRequest) {
    getProfile()
      .then(function(profile) {
        return firebase
          .database()
          .ref(
            "joinGroupRequests/" +
              joinGroupRequest.groupId +
              "/" +
              firebase.auth().currentUser.uid
          )
          .set({ profile: profile.val() });
      })
      .then(function() {
        app.ports.createJoinGroupRequestResponse.send({
          groupId: joinGroupRequest.groupId,
          response: success(true)
        });
      })
      .catch(function(err) {
        app.ports.createJoinGroupRequestResponse.send({
          groupId: joinGroupRequest.groupId,
          response: error(err.message)
        });
      });
  });
};
