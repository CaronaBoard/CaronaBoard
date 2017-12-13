import { error, success } from "./helpers";

const successEnabledNotifications = ({ auth, database }, ports) => token => {
  const currentUser = auth().currentUser;
  if (token && currentUser) {
    database()
      .ref("users/" + currentUser.uid)
      .set({
        notificationToken: token
      })
      .then(() => ports.notificationsResponse.send(success(true)))
      .catch(err => ports.notificationsResponse.send(error(err.message)));
  } else if (currentUser) {
    window.location = "/#/enable-notifications";
  }
};

export const checkNotificationToken = (firebase, ports) =>
  firebase
    .messaging()
    .getToken()
    .then(successEnabledNotifications(firebase, ports))
    .catch(() => {
      // ignore
    });

export default (firebase, ports) => {
  const messaging = firebase.messaging();

  ports.enableNotifications.subscribe(() =>
    messaging
      .requestPermission()
      .then(() => messaging.getToken())
      .then(successEnabledNotifications(firebase, ports))
      .catch(err => ports.notificationsResponse.send(error(err.message)))
  );

  messaging.onMessage(payload => {
    alert(payload.notification.body);
    window.location = payload.notification.click_action;
  });
};
