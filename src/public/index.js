require('bootstrap/dist/css/bootstrap.css');
require('bootstrap/dist/css/bootstrap-theme.css');
require('./css/main.scss');

let Elm = require('./js/Main.elm');

Elm.Main.embed(document.getElementById('page-wrap'));
