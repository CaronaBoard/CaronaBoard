import React, {Component} from 'react';
import Header             from './app/Header.jsx';
import Instructions       from './instructions/Instructions.jsx';
import RoutesBox          from './routesbox/RoutesBox.jsx';

class App extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div id="app-main">
        <Header/>
        <Instructions/>
        <RoutesBox/>
      </div>
    );
  }
}

export default App;
