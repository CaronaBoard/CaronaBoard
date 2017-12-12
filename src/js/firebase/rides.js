const success = require("./helpers").success;
const error = require("./helpers").error;

module.exports = (firebase, app) => {
  const getProfile = require("./profile").getProfile(firebase, app);

  app.ports.createRide.subscribe(newRide => {
    getProfile()
      .then(profile => {
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
      .then(() => {
        app.ports.createRideResponse.send(success(true));
      })
      .catch(err => {
        app.ports.createRideResponse.send(error(err.message));
      });
  });

  app.ports.ridesList.subscribe(() => {
    firebase
      .database()
      .ref("rides")
      .on("value", rides => {
        app.ports.ridesListResponse.send(success(rides.val() || {}));
      });
  });
};
