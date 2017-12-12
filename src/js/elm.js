var Stylesheet = require("../app/Stylesheets.elm");
var Elm = require("../app/Main.elm");
var connectFirebase = require("./firebase");

var getFlags = function() {
  var currentUser =
    Object.keys(localStorage)
      .filter(function(key) {
        return key.match(/firebase:authUser/);
      })
      .map(function(key) {
        return JSON.parse(localStorage.getItem(key));
      })
      .map(function(user) {
        return { id: user.uid };
      })[0] || null;

  var profile = null;
  profile = JSON.parse(localStorage.getItem("profile"));

  return {
    currentUser: currentUser,
    profile: profile
  };
};

var rootNode = document.getElementById("app");
rootNode.innerHTML = "";
var app = Elm.Main.embed(rootNode, getFlags());

connectFirebase(app);
