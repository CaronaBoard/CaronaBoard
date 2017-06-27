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
        app.ports.giveRideResponse.send(tuple(null, true));
      })
      .catch(function(error) {
        app.ports.giveRideResponse.send(tuple(error.message, null));
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
              firebase.auth().currentUser.uid
          )
          .push({ profile: profile.val() });
      })
      .then(function() {
        app.ports.rideRequestResponse.send(tuple(null, true));
      })
      .catch(function(error) {
        app.ports.rideRequestResponse.send(tuple(error.message, null));
      });
  });
};

module.exports.fetchRides = function(firebase, app) {
  firebase.database().ref("rides").on("value", function(rides) {
    app.ports.rides.send(toArrayOfObjects(2, rides.val()));
  });
};
