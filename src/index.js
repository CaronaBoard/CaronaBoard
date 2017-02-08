var Elm = require('./app/Main.elm');

var currentUser = Object.keys(localStorage).filter(function (key) {
  return key.match(/firebase:authUser/);
}).map(function (key) {
  return JSON.parse(localStorage.getItem(key));
}).map(function (user) {
  return { id: user.uid, name: user.displayName || ""}
})[0] || null;

var app = Elm.Main.embed(document.getElementById('page-wrap'), { currentUser: currentUser });

System.import('./firebase').then(function (connectFirebase) {
  connectFirebase(app);
});

System.import('materialize-css/bin/materialize.js');
