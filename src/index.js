var Elm = require('./app/Main.elm');
var connectFirebase = require('./firebase');

var app = Elm.Main.embed(document.getElementById('page-wrap'));

connectFirebase(app);
