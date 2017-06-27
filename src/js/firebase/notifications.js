var tuple = require("./helpers").tuple;

module.exports = function(firebase, app) {
  var messaging = firebase.messaging();

  var successEnabledNotifications = function(token) {
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

  app.ports.enableNotifications.subscribe(function() {
    messaging
      .requestPermission()
      .then(function() {
        return messaging.getToken();
      })
      .then(successEnabledNotifications)
      .catch(function(err) {
        app.ports.notificationsResponse.send(tuple(err.message, null));
      });
  });

  messaging.getToken().then(successEnabledNotifications).catch(function() {
    // ignore
  });

  messaging.onMessage(function(payload) {
    alert(payload.notification.body);
    window.location = payload.notification.click_action;
  });
};
