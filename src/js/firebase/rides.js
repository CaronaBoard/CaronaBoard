import { error, success } from "./helpers";
import { getProfile } from "./profile";

export default (firebase, ports) => {
  const { auth, database } = firebase;

  ports.createRide.subscribe(newRide =>
    getProfile(firebase, ports)
      .then(profile =>
        database()
          .ref("rides/" + newRide.groupId + "/" + auth().currentUser.uid)
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
          )
      )
      .then(() => ports.createRideResponse.send(success(true)))
      .catch(err => ports.createRideResponse.send(error(err.message)))
  );

  ports.ridesList.subscribe(() =>
    database()
      .ref("rides")
      .on("value", rides =>
        ports.ridesListResponse.send(success(rides.val() || {}))
      )
  );
};
