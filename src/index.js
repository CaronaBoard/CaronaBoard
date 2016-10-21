require('bootstrap/dist/css/bootstrap.css');
require('bootstrap/dist/css/bootstrap-theme.css');
require('./css/main.scss');

var Elm = require('./app/Main.elm');

Elm.Main.embed(document.getElementById('page-wrap'));
