import React    from 'react';
import {render} from 'react-dom';
import Elm      from 'react-elm-components';
import {App}      from './js/App.elm';

import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap/dist/css/bootstrap-theme.css';
import './css/main.scss';

render(
  <Elm src={App} />, document.getElementById('page-wrap')
);
