var success = require("./helpers").success;
var error = require("./helpers").error;

module.exports = function(firebase, app) {
  app.ports.fetchRideRequest.subscribe(function(ids) {
    firebase
      .database()
      .ref(
        "ridesRequests/" +
          ids.groupId +
          "/" +
          ids.rideId +
          "/" +
          firebase.auth().currentUser.uid +
          "/" +
          ids.fromUserId +
          "/" +
          ids.id
      )
      .once("value")
      .then(function(data) {
        var rideRequest = Object.assign({}, data.val(), {
          groupId: ids.groupId,
          rideId: ids.rideId,
          toUserId: firebase.auth().currentUser.uid,
          fromUserId: ids.fromUserId,
          id: ids.id
        });
        app.ports.fetchRideRequestResponse.send(success(rideRequest));
      })
      .catch(function(err) {
        app.ports.fetchRideRequestResponse.send(error(err.message));
      });
  });
};
