module.exports = function(firebase, database, app) {
  var messaging = firebase.messaging();

  app.ports.enableNotifications.subscribe(function() {
    messaging
      .requestPermission()
      .then(function() {
        return messaging.getToken();
      })
      .then(function(token) {
        console.log("Messaging token", token);
        app.ports.notificationsResponse.send([null, true]);
      })
      .catch(function(err) {
        app.ports.notificationsResponse.send([err.message, null]);
      });
  });

  messaging.onMessage(function(payload) {
    console.log("Message received. ", payload);
    alert("awe");
  });
};
