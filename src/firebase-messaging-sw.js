importScripts("https://www.gstatic.com/firebasejs/3.9.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/3.9.0/firebase-messaging.js");

firebase.initializeApp({
  messagingSenderId: "617045704123"
});

var messaging = firebase.messaging();

messaging.onMessage(function(payload) {
  console.log("Message received. ", payload);
  alert("awe");
});

messaging.setBackgroundMessageHandler(function(payload) {
  console.log(
    "[firebase-messaging-sw.js] Received background message ",
    payload
  );
  // Customize notification here
  const notificationTitle = "Background Message Title";
  const notificationOptions = {
    body: "Background Message body.",
    icon: "/firebase-logo.png"
  };

  return self.registration.showNotification(
    notificationTitle,
    notificationOptions
  );
});
