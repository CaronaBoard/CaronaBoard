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

  app.ports.joinRequestsList.subscribe(function(request) {
    firebase
      .database()
      .ref("joinGroupRequests/" + request.groupId)
      .once("value")
      .then(function(joinGroupRequests) {
        app.ports.joinRequestsListResponse.send({
          groupId: request.groupId,
          response: success(joinGroupRequests.val())
        });
      })
      .catch(function(err) {
        app.ports.joinRequestsListResponse.send(error(err.message));
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

  var removeJoinRequest = function(joinRequestResponse) {
    firebase
      .database()
      .ref(
        "joinGroupRequests/" +
          joinRequestResponse.groupId +
          "/" +
          joinRequestResponse.userId
      )
      .remove()
      .then(function() {
        app.ports.respondJoinRequestResponse.send({
          groupId: joinRequestResponse.groupId,
          userId: joinRequestResponse.userId,

          response: success(true)
        });
      })
      .catch(function(err) {
        app.ports.respondJoinRequestResponse.send({
          groupId: joinRequestResponse.groupId,
          userId: joinRequestResponse.userId,

          response: error(err.message)
        });
      });
  };

  app.ports.respondJoinRequest.subscribe(function(joinRequestResponse) {
    if (joinRequestResponse.accepted) {
      firebase
        .database()
        .ref(
          "groups/" +
            joinRequestResponse.groupId +
            "/members/" +
            joinRequestResponse.userId
        )
        .set({ admin: false })
        .then(function() {
          removeJoinRequest(joinRequestResponse);
        })
        .catch(function(err) {
          app.ports.respondJoinRequestResponse.send({
            groupId: joinRequestResponse.groupId,
            userId: joinRequestResponse.userId,
            response: error(err.message)
          });
        });
    } else {
      removeJoinRequest(joinRequestResponse);
    }
  });
};
