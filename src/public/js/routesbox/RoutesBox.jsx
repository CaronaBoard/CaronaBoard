import React, {Component} from 'react';
import Elm from 'react-elm-components';
import { RoutesTable }    from './RoutesTable.elm';
import { FeedbackBox }    from './FeedbackBox.elm';

class RoutesBox extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div className="routes-box">
        <Elm src={ RoutesTable }/>
        <Elm src={ FeedbackBox }/>
      </div>
    );
  }
}

export default RoutesBox;
