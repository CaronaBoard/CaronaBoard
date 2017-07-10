var success = require("./helpers").success;
var error = require("./helpers").error;

module.exports = function(firebase, app) {
  var getProfile = require("./profile").getProfile(firebase, app);

  app.ports.giveRide.subscribe(function(newRide) {
    getProfile()
      .then(function(profile) {
        return firebase
          .database()
          .ref(
            "rides/" + newRide.groupId + "/" + firebase.auth().currentUser.uid
          )
          .push(
            Object.assign(
              { profile: profile.val() },
              {
                origin: newRide.origin,
                destination: newRide.destination,
                days: newRide.days,
                hours: newRide.hours
              }
            )
          );
      })
      .then(function() {
        app.ports.giveRideResponse.send(success(true));
      })
      .catch(function(err) {
        app.ports.giveRideResponse.send(error(err.message));
      });
  });

  app.ports.ridesList.subscribe(function() {
    firebase.database().ref("rides").on("value", function(rides) {
      app.ports.ridesListResponse.send(success(rides.val()));
    });
  });
};
