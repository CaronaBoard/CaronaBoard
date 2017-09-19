[![Build Status][ci-svg]][ci-url]

[ci-svg]: https://circleci.com/gh/CaronaBoard/caronaboard.svg?style=shield
[ci-url]: https://circleci.com/gh/CaronaBoard/caronaboard

## What is CaronaBoard???

[CaronaBoard.com](http://caronaboard.com) is an open source project, with the goal of creating a way to optimize the use of cars in cities, contributing to reduce local traffic, reduce use of fossil fuel, and help people to connect to their friends and colleagues.

Different than other products such as [BlablaCar](http://www.blablacar.com), CaronaBoard aim is to remain free! In our view giving a ride is a matter of friendship! We based the entire idea on principles of friendship and comradery, and that you would spend the same fuel and money if you go alone or if you give ride to your friends/colleagues. If they want to give the rider a contribution it is up to them, but the tool won't be designed to make money out from it.

Another huge difference from other car pooling systems is that the focus of CaronaBoard is to serve people on their daily routine inside the cities, like going to work and back. This conceptual difference makes CaronaBoard mission a lot more challenging because daily rides are less planned and least for a very short time span. The transportation subject in big urban centers is a super complex problem but at the same time we believe that this would make our mission and work fun and inspiring.

In order to solve this problem we would like to gather brilliant people with the ideas and willigness to radically change the world!

### Product vision:

Below some ideas about the concept of CaronaBoard:

1. Free tool: CaronaBoard will be free, meaning that it won't be used to make money or provide tools for people make money
2. Connect people: the idea is simple, CaronaBoard has to allow people to easy communicate and get ride to each other.
3. Communities: the product will evolve to the idea of communities, so people can create a community for its workplace, or a group of soccer friends for example. This will ensure you do not risk to get/give ride to someone you do not know or someone that can offer risk, specially in the current world where there is a lot of violence, prejudice and sexism. The idea is that in the future group administrator could allow people to join group or ban other members.
4. Collaboration: CaronaBoard idea is to be a collaborative project. Your ideas and contributions are welcome.

### Tech stack

- [Elm](http://elm-lang.org/) to create the app
- [Firebase](https://www.firebase.com/) for a no-backend database
- [Webpack](https://webpack.github.io/) for bundling elm + css + html and minification
- [Github Pages](https://pages.github.com/) for hosting, with [now](https://zeit.co/now) for preview
- [Material Design](https://material.io/) a base for the design specs
- [Service Worker Precache](https://github.com/GoogleChrome/sw-precache) for working offline

### Prerequesites

- Node.js 8+ (We recommend using [nvm](https://github.com/creationix/nvm) to manage your Node version)

### Installing

1. `nvm use` (optional if you use nvm)
2. `npm`
3. `npm start`
4. http://localhost:8080/

### Running tests

We are using [elm-test](https://github.com/elm-community/elm-test) for writing tests for elm. Since elm type system is already so safe and ease refactoring by a lot, we are attempting a new idea: to not write unit tests, instead, we just write fuzz tests, which checks for the edge cases, and integration tests, using [elm-testable](https://github.com/rogeriochaves/elm-testable), which ensure things are working well together and provide much more safety when refactoring.

To run tests, simply run `npm test`.

### Deployment - Circle CI

Cicle builds the app and run the Elm tests. Then, when in master branch, it deploys to github pages by creating a new commit on the repo [caronaboard.github.io](https://github.com/CaronaBoard/caronaboard.github.io).

You can see Cicle CI config on `.circleci/config.yml`, and the pipeline [here](https://circleci.com/gh/CaronaBoard/caronaboard).

But if you want to deploy your changes to a temporary url and see how they look like, simply run `npm run deploy:now`

### Kanban Wall

https://waffle.io/luismizutani/CaronaBoard
