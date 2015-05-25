c = require './util/const'

global.game = new Phaser.Game 172, 306

game.state.add 'main', require './state/main'
game.state.add 'load', require './state/load'
game.state.add 'title', require './state/title'
game.state.start 'load'