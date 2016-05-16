import React, {Component} from 'react';
import logo from '../../images/caronaboard_logo.png';

const headerStyle = {
  float: 'left',
  padding: '10px 20px 0 0'
};

class Header extends Component {

  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div id="header">
        <div id="topbar">
          <div id="title">
            <img style={headerStyle} src={logo}/>
            <h1>Carona Board</h1>
            <h2>Seu carro não precisa levar apenas você</h2>
          </div>
          <div id="main_menu">
            <div id="button_offer"><a href="http://goo.gl/forms/ohEbgkMa9i">DOU CARONA!</a></div>
          </div>
        </div>
      </div>
    );
  }
}

export default Header;
