import firebase from "firebase";
import login from "./firebase/login";
import rides from "./firebase/rides";
import notifications from "./firebase/notifications";
import profile from "./firebase/profile";
import groups from "./firebase/groups";
import ridesRequests from "./firebase/ridesRequests";

const config = {
  apiKey: process.env.FIREBASE_API_KEY,
  authDomain: process.env.FIREBASE_AUTH_DOMAIN,
  databaseURL: process.env.FIREBASE_DATABASE_URL,
  storageBucket: process.env.FIREBASE_STORAGE_BUCKET,
  messagingSenderId: process.env.FIREBASE_MESSAGING_SENDER_ID
};

firebase.initializeApp(config);

export default ports => {
  login(firebase, ports);
  rides(firebase, ports);
  notifications(firebase, ports);
  profile(firebase, ports);
  groups(firebase, ports);
  ridesRequests(firebase, ports);
};
