var app;
var connectFirebase;

require(['./app/Main.elm', './app/Stylesheets.elm'], function (Elm, Stylesheet) {
  console.log(Stylesheet);
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

require(['./firebase'], function (connect) {
  connectFirebase = connect;
  if (app) connectFirebase(app);
});
