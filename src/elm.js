var app;
var connectFirebase;

System.import('./app/Main.elm').then(function (Elm) {
  var currentUser = Object.keys(localStorage).filter(function (key) {
    return key.match(/firebase:authUser/);
  }).map(function (key) {
    return JSON.parse(localStorage.getItem(key));
  }).map(function (user) {
    return { id: user.uid, name: user.displayName || ""}
  })[0] || null;

  app = Elm.Main.embed(document.getElementById('page-wrap'), { currentUser: currentUser });
  if (connectFirebase) connectFirebase(app);
});

System.import('./firebase').then(function (connect) {
  connectFirebase = connect;
  if (app) connectFirebase(app);
});
