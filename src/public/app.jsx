import React      from 'react';
import {render}   from 'react-dom';
// import 'bootstrap/dist/css/bootstrap.css';

import {ButtonToolbar, Button} from 'react-bootstrap';

const HelloMessage = React.createClass({
  render: function() {
    return (
    <ButtonToolbar>
      <Button bsStyle="primary" bsSize="large" active>Primary button</Button>
      <Button bsSize="large" active>Button</Button>
    </ButtonToolbar>);
  }
});

const appMain = document.getElementById('app-main');


render(<HelloMessage name="John" />, appMain);
// render(buttonsInstance, appMain)
