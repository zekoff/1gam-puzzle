# 1gam-puzzle

Steps to set up development environment:
* `npm install -g browserify watchify coffee-script`
* `./dev.sh`

The game is contained in `bundle.js`, which is produced by compiling the
Coffeescript files and then bundling them with Browserify. This process is
automated by the shell script.