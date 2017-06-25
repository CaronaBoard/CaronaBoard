module.exports = function(firebase, database, app) {
  var messaging = firebase.messaging();

  messaging
    .requestPermission()
    .then(function() {
      console.log("Notification permission granted.");
      return messaging.getToken();
    })
    .then(function(token) {
      console.log("Messaging token", token);
    })
    .catch(function(err) {
      console.log("Unable to get permission to notify.", err);
    });
};
