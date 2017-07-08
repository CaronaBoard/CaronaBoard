// After splash screen loaded
window.addEventListener("load", function() {
  // Load Elm and connect it with Firebase
  require("./js/elm.js");

  // Load serviceWorkers
  if (!process.env.DEBUG && "serviceWorker" in navigator) {
    navigator.serviceWorker.register("/service-worker.js");
  }
});
