import React, {Component} from 'react';
import RoutesTable        from './routestable/RoutesTable.jsx';
import FeedbackBox        from './feedbackbox/FeedbackBox.jsx';

class RoutesBox extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div className="routes-box">
        <RoutesTable/>
        <FeedbackBox/>
      </div>
    );
  }
}

export default RoutesBox;
