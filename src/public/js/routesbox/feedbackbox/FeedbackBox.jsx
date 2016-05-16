import React, {Component} from 'react';

class FeedbackBox extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div id="feedback">
        <h3>Nos ajude a melhorar!</h3> <a class="cadastro" href="http://goo.gl/forms/GYVDfZuhWg" target="_blank">Deixe aqui sua opinião/sugestão</a>
      </div>
    );
  }

}

export default FeedbackBox;
