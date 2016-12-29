var Elm = require('./app/Main.elm');

var app = Elm.Main.embed(document.getElementById('page-wrap'));

System.import('./firebase').then(function (connectFirebase) {
  connectFirebase(app);
});
