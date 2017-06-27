var tuple = require("./helpers").tuple;

var successEnabledNotifications = function(firebase, app) {
  return function(token) {
    var currentUser = firebase.auth().currentUser;
    if (token && currentUser) {
      firebase
        .database()
        .ref("users/" + currentUser.uid)
        .set({
          notificationToken: token
        })
        .then(function() {
          app.ports.notificationsResponse.send(tuple(null, true));
        })
        .catch(function(err) {
          app.ports.notificationsResponse.send(tuple(err.message, null));
        });
    }
  };
};

var checkNotificationToken = function(firebase, app) {
  var messaging = firebase.messaging();

  messaging
    .getToken()
    .then(successEnabledNotifications(firebase, app))
    .catch(function() {
      // ignore
    });
};

module.exports = function(firebase, app) {
  var messaging = firebase.messaging();

  app.ports.enableNotifications.subscribe(function() {
    messaging
      .requestPermission()
      .then(function() {
        return messaging.getToken();
      })
      .then(successEnabledNotifications(firebase, app))
      .catch(function(err) {
        app.ports.notificationsResponse.send(tuple(err.message, null));
      });
  });

  messaging.onMessage(function(payload) {
    alert(payload.notification.body);
    window.location = payload.notification.click_action;
  });
};
module.exports.checkNotificationToken = checkNotificationToken;
