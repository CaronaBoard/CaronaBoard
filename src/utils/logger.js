const chalk = require('chalk');
const logger = {
  logSuccess: function(title, message) {
    const text = `${chalk.cyan.bold(title)}: ${chalk.green(message)}`;
    console.log(text);
  },

  logError: function(title, message) {
    const text = `${chalk.yellow.bold(title)}: ${chalk.red(message)}`;
    console.log(text);
  }
};

module.exports = logger;
