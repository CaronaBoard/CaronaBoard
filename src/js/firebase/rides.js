var success = require("./helpers").success;
var error = require("./helpers").error;

module.exports = function(firebase, app) {
  var getProfile = require("./profile").getProfile(firebase, app);

  app.ports.giveRide.subscribe(function(newRide) {
    getProfile()
      .then(function(profile) {
        return firebase
          .database()
          .ref("rides/" + firebase.auth().currentUser.uid)
          .push(Object.assign({ profile: profile.val() }, newRide));
      })
      .then(function() {
        app.ports.giveRideResponse.send(success(true));
      })
      .catch(function(err) {
        app.ports.giveRideResponse.send(error(err.message));
      });
  });

  app.ports.rideRequest.subscribe(function(rideRequest) {
    getProfile()
      .then(function(profile) {
        return firebase
          .database()
          .ref(
            "ridesRequests/" +
              rideRequest.rideId +
              "/" +
              rideRequest.toUserId +
              "/" +
              firebase.auth().currentUser.uid
          )
          .push({ profile: profile.val() });
      })
      .then(function() {
        app.ports.rideRequestResponse.send({
          rideId: rideRequest.rideId,
          response: success(true)
        });
      })
      .catch(function(err) {
        app.ports.rideRequestResponse.send({
          rideId: rideRequest.rideId,
          response: error(err.message)
        });
      });
  });
};

module.exports.fetchRides = function(firebase, app) {
  firebase.database().ref("rides").on("value", function(rides) {
    app.ports.rides.send(rides.val());
  });
};
