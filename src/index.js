// After splash screen loaded
window.addEventListener("load", function() {
  // Load all CSS
  var loadCSS = require("fg-loadcss").loadCSS;
  loadCSS("https://fonts.googleapis.com/icon?family=Material+Icons");
  loadCSS("https://fonts.googleapis.com/css?family=Lato:400,700");

  // Load Elm and connect it with Firebase
  require("./js/elm.js");

  // Load serviceWorkers
  if (!process.env.DEBUG && "serviceWorker" in navigator) {
    navigator.serviceWorker.register("/service-worker.js");
  }
});
