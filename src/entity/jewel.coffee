c = require('../const')

class Jewel extends Phaser.Sprite
    constructor: (x = 0, y = 0, @color) ->
        @color ?= game.rnd.pick(c.COLORS)
        super game, x, y, "#{@color}_square"
        this.inputEnabled = true
        this.input.enableDrag false, false, false, 255,
            new Phaser.Rectangle 0, 0, game.world.width, game.world.height
        this.input.enableSnap c.TILE_SIZE, c.TILE_SIZE, false, true

module.exports = Jewel