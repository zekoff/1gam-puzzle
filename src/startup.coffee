c = require './util/const'

global.game = new Phaser.Game(c.WORLD_WIDTH_PX, c.WORLD_HEIGHT_PX)

game.state.add 'main', require './state/main'
game.state.add 'load', require './state/load'
game.state.add 'title', require './state/title'
game.state.start 'load'