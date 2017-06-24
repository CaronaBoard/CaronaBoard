var toArrayOfObjects = function (object) {
  return Object.keys(object).reduce(function (accumulated, itemId) {
    var item = Object.assign({id: itemId}, object[itemId]);

    return [item].concat(accumulated);
  }, []);
};

module.exports = function (firebase, database, app) {
  var ridesRef = firebase.database().ref('rides');

  var fetchRides = function () {
    firebase.database().ref('rides').on('value', function (rides) {
      app.ports.rides.send(toArrayOfObjects(rides.val()));
    });
  };

  app.ports.giveRide.subscribe(function (newRide) {
    newRide.formUrl = newRide.formUrl || '';
    firebase.database().ref('rides').push(newRide).then(function (rideRef) {
      rideRef.once('value').then(function (ride) {
        app.ports.giveRideResponse.send([null, Object.assign({id: ride.getKey()}, ride.val()) ]);
      });
    }).catch(function (error) {
      app.ports.giveRideResponse.send([error.message, null]);
    });
  });
}
