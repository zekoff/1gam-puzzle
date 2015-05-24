c = require('../util/const')
conv = require('../util/convert')

class Jewel extends Phaser.Sprite
    constructor: (@tileX, @tileY, @color) ->
        @color ?= game.rnd.pick(c.COLORS)
        [x, y] = conv.tileToWorld(@tileX, @tileY)
        super game, x, y, "#{@color}_square"
        @anchor.set(0.5)
        game.physics.arcade.enable(@)
        @inputEnabled = true
        @input.enableDrag false, false, false, 255,
            new Phaser.Rectangle 0, 0, game.world.width, game.world.height
        @input.enableSnap c.TILE_SIZE, c.TILE_SIZE, false, true
        @events.onInputDown.add =>
            [@prevX, @prevY] = [@tileX, @tileY]
        @events.onInputUp.add =>
            
module.exports = Jewel