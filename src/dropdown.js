// This is necessary for Materialize dropdowns: http://materializecss.com/navbar.html#navbar-dropdown

setInterval(function () {
  var dropdown = $('.dropdown-button');

  if(dropdown.length > 0 && !dropdown[0].dataset.activates) {
    dropdown[0].dataset.activates = 'nav-dropdown';
    $('.dropdown-button').dropdown();
  }
}, 500);
