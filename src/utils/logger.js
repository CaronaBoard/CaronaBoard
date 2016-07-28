import chalk from 'chalk';

const logger = {
  logSuccess: (title, message) => {
    const text = `${chalk.cyan.bold(title)}: ${chalk.green(message)}`;
    console.log(text);
  },

  logError: (title, message) => {
    const text = `${chalk.yellow.bold(title)}: ${chalk.red(message)}`;
    console.log(text);
  }
};

export default logger;
