const success = require("./helpers").success;
const error = require("./helpers").error;

module.exports = (firebase, app) => {
  const getProfile = require("./profile").getProfile(firebase, app);

  app.ports.fetchRideRequest.subscribe(ids => {
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
      .then(data => {
        if (data.val()) {
          const rideRequest = Object.assign({}, data.val(), {
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
      .catch(err => {
        app.ports.fetchRideRequestResponse.send(error(err.message));
      });
  });

  app.ports.createRideRequest.subscribe(rideRequest => {
    getProfile()
      .then(profile => {
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
      .then(() => {
        app.ports.createRideRequestResponse.send({
          rideId: rideRequest.rideId,
          response: success(true)
        });
      })
      .catch(err => {
        app.ports.createRideRequestResponse.send({
          rideId: rideRequest.rideId,
          response: error(err.message)
        });
      });
  });
};
