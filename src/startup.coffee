c = require './util/const'

worldWidth = c.TILE_SIZE * c.FIELD_WIDTH
worldHeight = c.TILE_SIZE * c.FIELD_HEIGHT
global.game = new Phaser.Game worldWidth, worldHeight

game.state.add 'main', require './state/main'
game.state.add 'load', require './state/load'
game.state.add 'title', require './state/title'
game.state.start 'load'