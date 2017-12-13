import "./js/elm";

if (!process.env.DEBUG && "serviceWorker" in navigator) {
  navigator.serviceWorker.register("/service-worker.js");
}
