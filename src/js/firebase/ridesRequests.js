var success = require("./helpers").success;
var error = require("./helpers").error;

module.exports = function(firebase, app) {
  var getProfile = require("./profile").getProfile(firebase, app);

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
        if (data.val()) {
          var rideRequest = Object.assign({}, data.val(), {
            groupId: ids.groupId,
            rideId: ids.rideId,
            toUserId: firebase.auth().currentUser.uid,
            fromUserId: ids.fromUserId,
            id: ids.id
          });
          app.ports.fetchRideRequestResponse.send(success(rideRequest));
        } else {
          app.ports.fetchRideRequestResponse.send(
            error("Pedido de carona não encontrado")
          );
        }
      })
      .catch(function(err) {
        app.ports.fetchRideRequestResponse.send(error(err.message));
      });
  });

  app.ports.createRideRequest.subscribe(function(rideRequest) {
    getProfile()
      .then(function(profile) {
        return firebase
          .database()
          .ref(
            "ridesRequests/" +
              rideRequest.groupId +
              "/" +
              rideRequest.rideId +
              "/" +
              rideRequest.toUserId +
              "/" +
              firebase.auth().currentUser.uid
          )
          .push({ profile: profile.val() });
      })
      .then(function() {
        app.ports.createRideRequestResponse.send({
          rideId: rideRequest.rideId,
          response: success(true)
        });
      })
      .catch(function(err) {
        app.ports.createRideRequestResponse.send({
          rideId: rideRequest.rideId,
          response: error(err.message)
        });
      });
  });
};
