var tuple = require("./helpers").tuple;

var toArrayOfObjects = function(object) {
  return Object.keys(object).reduce(function(accumulated, itemId) {
    var item = Object.assign({ id: itemId }, object[itemId]);

    return [item].concat(accumulated);
  }, []);
};

module.exports = function(firebase, database, app) {
  app.ports.giveRide.subscribe(function(newRide) {
    firebase
      .database()
      .ref("rides")
      .push(newRide)
      .then(function(rideRef) {
        app.ports.giveRideResponse.send(tuple(null, true));
      })
      .catch(function(error) {
        app.ports.giveRideResponse.send(tuple(error.message, null));
      });
  });

  app.ports.rideRequest.subscribe(function(rideRequest) {
    firebase
      .database()
      .ref("ridesRequests")
      .push(rideRequest)
      .then(function() {
        app.ports.rideRequestResponse.send(tuple(null, true));
      })
      .catch(function(error) {
        app.ports.rideRequestResponse.send(tuple(error.message, null));
      });
  });
};

module.exports.fetchRides = function(firebase, database, app) {
  firebase.database().ref("rides").on("value", function(rides) {
    app.ports.rides.send(toArrayOfObjects(rides.val()));
  });
};
