## What is CaronaBoard?

[CaronaBoard.com](http://caronaboard.com) is an open source project, with the goal of creating a way to optimize the use of cars in cities, contributing to reduce local traffic, reduce use of fossil fuel, and help people to connect to its friends and colleagues.

Different than other products such as [BlablaCar](http://www.blablacar.com), CaronaBoard aim is to remain free! In our view give ride is a matter of friendship! We based the entire idea on principles of friendship and comradery, and that you would spend the same fuel and money if you go alone or if you give ride to your friends/colleagues.  If they want to give the rider a contribution it is up to them, and the tool won't be designed to make money out from it.

### Product vision:

Below some ideas about the concept of CaronaBoard:

1. Free tool: CaronaBoard will be free, meaning that it won't be used to make money or provide tools for people make money
2. Connect people: the idea is simple, CaronaBoard has to allow people to easy communicate and get ride to each other.
3. Communities: the product will evolve to the idea of communities, so people can create a community for its workplace, or a group of friends. This will ensure you do not risk to get/give ride to someone you do not know or someone that can offer risk, specially in the current world where there is a lot of violence, prejudice and sexism. The idea is that in the future group administrator could allow people to join group or ban other members.
4. Collaboration: CaronaBoard idea is to be a collaborative project. Your ideas and contributions are welcome.

### Tech stack

- React + ES6
- Webpack
- Node.js
- Express

### Prerequesites

- Node.js 6.2.2 (We recommend using [nvm](https://github.com/creationix/nvm) to manage your Node version)

### Installing

1. `nvm use` (optional if you use nvm)
2. `npm install`
3. `npm run dev-server`
4. http://localhost:8079/

### Running tests

We are using [enzyme](https://github.com/airbnb/enzyme) + [mocha](https://github.com/mochajs/mocha) + [chai](https://github.com/chaijs/chai) to unit test our ReactJS components.

To run tests, simply run `npm test`.

### Deployment

We have a CD pipeline consisting of TravisCI + Heroku automatic deploy once tests pass on master branch.

#### - TravisCI
 Travis is responsible for linting and running tests before deploying to
heroku.
 The following npm script is run on Travis: `npm run ci`. Which currently lints and
run unit tests located in our `src` folder

#### - Heroku
 Heroku basically runs the following npm scripts in order to build and deploy our
app:

 1. `npm install --production`
 2. `NODE_ENV=production npm run postinstall`
 3. `npm run start`

### Webpack
 We are using Webpack as our project's module bundler.

 - Compiling SASS
 - Providing us a development server with hot module reloading
 - Transpiling our code using babel
 - Optimizing our code in production builds

 Since we have both development and production bundling behaviour, it's
very important to make sure you are running npm scripts with the correct
`NODE_ENV` variable set.

### Kanban Wall

https://waffle.io/luismizutani/CaronaBoard
