const success = require("./helpers").success;
const error = require("./helpers").error;

const successEnabledNotifications = (firebase, app) => {
  return token => {
    const currentUser = firebase.auth().currentUser;
    if (token && currentUser) {
      firebase
        .database()
        .ref("users/" + currentUser.uid)
        .set({
          notificationToken: token
        })
        .then(() => {
          app.ports.notificationsResponse.send(success(true));
        })
        .catch(err => {
          app.ports.notificationsResponse.send(error(err.message));
        });
    } else if (currentUser) {
      window.location = "/#/enable-notifications";
    }
  };
};

const checkNotificationToken = (firebase, app) => {
  const messaging = firebase.messaging();

  messaging
    .getToken()
    .then(successEnabledNotifications(firebase, app))
    .catch(() => {
      // ignore
    });
};

module.exports = (firebase, app) => {
  const messaging = firebase.messaging();

  app.ports.enableNotifications.subscribe(() => {
    messaging
      .requestPermission()
      .then(() => {
        return messaging.getToken();
      })
      .then(successEnabledNotifications(firebase, app))
      .catch(err => {
        app.ports.notificationsResponse.send(error(err.message));
      });
  });

  messaging.onMessage(payload => {
    alert(payload.notification.body);
    window.location = payload.notification.click_action;
  });
};
module.exports.checkNotificationToken = checkNotificationToken;
