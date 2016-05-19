import React        from 'react';
import {render}     from 'react-dom';
import App          from './js/App.jsx';

import 'bootstrap/dist/css/bootstrap.css';
import './css/main.scss';

render(
  <App/>, document.getElementById('page-wrap')
);
