var React = require('react');

var HelloMessage = React.createClass({
  render: function() {
    return <div>Hello {this.props.name}</div>;
  }
});

var appMain = $("#app-main")[0];
React.render(<HelloMessage name="John" />, appMain);
