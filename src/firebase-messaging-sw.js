importScripts("https://www.gstatic.com/firebasejs/3.9.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/3.9.0/firebase-messaging.js");

firebase.initializeApp({
  messagingSenderId: process.env.FIREBASE_MESSAGING_SENDER_ID || "617045704123"
});

firebase.messaging();
