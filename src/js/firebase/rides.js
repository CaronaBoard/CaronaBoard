var tuple = require("./helpers").tuple;

var toArrayOfObjects = function(deepness, object) {
  return Object.keys(object || {}).reduce(function(accumulated, itemId) {
    var item;
    if (deepness == 1) {
      item = [Object.assign({ id: itemId }, object[itemId])];
    } else {
      item = toArrayOfObjects(deepness - 1, object[itemId]);
    }

    return item.concat(accumulated);
  }, []);
};

module.exports = function(firebase, database, app) {
  app.ports.giveRide.subscribe(function(newRide) {
    var currentUser = firebase.auth().currentUser;

    firebase
      .database()
      .ref("profiles/" + currentUser.uid)
      .once("value")
      .then(function(profile) {
        return firebase
          .database()
          .ref("rides/" + currentUser.uid)
          .push(Object.assign({ profile: profile.val() }, newRide));
      })
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
    app.ports.rides.send(toArrayOfObjects(2, rides.val()));
  });
};
