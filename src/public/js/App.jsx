import React, {Component} from 'react';
import Header             from './app/Header.jsx';
import Instructions       from './instructions/Instructions.jsx';
import Elm                from 'react-elm-components';
import { RoutesBox }      from './routesbox/RoutesBox.elm';

class App extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div id="app-main">
        <Header/>
        <Instructions/>
        <Elm src={ RoutesBox }/>
      </div>
    );
  }
}

export default App;
