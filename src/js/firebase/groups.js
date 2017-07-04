var success = require("./helpers").success;
var error = require("./helpers").error;

module.exports = function(firebase, app) {
  app.ports.groupsList.subscribe(function() {
    firebase
      .database()
      .ref("groups")
      .once("value")
      .then(function(groups) {
        console.log(groups.val());
        app.ports.groupsListResponse.send(success(groups.val()));
      })
      .catch(function(err) {
        app.ports.groupsListResponse.send(error(err.message));
      });
  });
};
