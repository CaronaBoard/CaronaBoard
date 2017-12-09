var firebase = require("firebase");

var config = {
  apiKey: process.env.FIREBASE_API_KEY,
  authDomain: process.env.FIREBASE_AUTH_DOMAIN,
  databaseURL: process.env.FIREBASE_DATABASE_URL,
  storageBucket: process.env.FIREBASE_STORAGE_BUCKET,
  messagingSenderId: process.env.FIREBASE_MESSAGING_SENDER_ID
};

firebase.initializeApp(config);

var database = firebase.database();

module.exports = function(app) {
  require("./firebase/login")(firebase, app);
  require("./firebase/rides")(firebase, app);
  require("./firebase/notifications")(firebase, app);
  require("./firebase/profile")(firebase, app);
  require("./firebase/groups")(firebase, app);
  require("./firebase/ridesRequests")(firebase, app);
};
