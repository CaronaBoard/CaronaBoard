var firebase = require("firebase");

var config = {
  apiKey:
    process.env.FIREBASE_API_KEY || "AIzaSyDfwHLwWKTqduazsf4kjbstJEA2E1sCeoI",
  authDomain:
    process.env.FIREBASE_AUTH_DOMAIN || "caronaboard-61f75.firebaseapp.com",
  databaseURL:
    process.env.FIREBASE_DATABASE_URL ||
    "https://caronaboard-61f75.firebaseio.com",
  storageBucket:
    process.env.FIREBASE_STORAGE_BUCKET || "caronaboard-61f75.appspot.com",
  messagingSenderId: process.env.FIREBASE_MESSAGING_SENDER_ID || "617045704123"
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
