const tuple = (a, b) => [a, b];

const error = a => tuple(a, null);

const success = b => tuple(null, b);

module.exports = {
  tuple: tuple,
  error: error,
  success: success
};
