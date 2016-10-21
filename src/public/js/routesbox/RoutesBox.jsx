import React, {Component} from 'react';
import RoutesTable        from './routestable/RoutesTable.jsx';
import Elm from 'react-elm-components';
import { FeedbackBox }    from './feedbackbox/FeedbackBox.elm';

class RoutesBox extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div className="routes-box">
        <RoutesTable/>
        <Elm src={ FeedbackBox }/>
      </div>
    );
  }
}

export default RoutesBox;
