const tuple = (a, b) => {
  return [a, b];
};

const error = a => {
  return tuple(a, null);
};

const success = b => {
  return tuple(null, b);
};

module.exports = {
  tuple: tuple,
  error: error,
  success: success
};
