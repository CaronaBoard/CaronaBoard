var success = require("./helpers").success;
var error = require("./helpers").error;

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
          app.ports.notificationsResponse.send(success(true));
        })
        .catch(function(err) {
          app.ports.notificationsResponse.send(error(err.message));
        });
    } else if (currentUser) {
      window.location = "/#/enable-notifications";
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
        app.ports.notificationsResponse.send(error(err.message));
      });
  });

  messaging.onMessage(function(payload) {
    alert(payload.notification.body);
    window.location = payload.notification.click_action;
  });
};
module.exports.checkNotificationToken = checkNotificationToken;
