var tuple = function(a, b) {
  return [a, b];
};

var error = function(a) {
  return tuple(a, null);
};

var success = function(b) {
  return tuple(null, b);
};

module.exports = {
  tuple: tuple,
  error: error,
  success: success
};
