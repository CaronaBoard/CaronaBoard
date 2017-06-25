module.exports = function(firebase, database, app) {
  var messaging = firebase.messaging();

  var successEnabledNotifications = function(token) {
    if (token) {
      console.log("TODO: update messaging token on database", token);
      app.ports.notificationsResponse.send([null, true]);
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
        app.ports.notificationsResponse.send([err.message, null]);
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
