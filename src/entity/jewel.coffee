c = require('../util/const')
conv = require('../util/convert')

class Jewel extends Phaser.Sprite
    constructor: (x, y, @color) ->
        @color ?= game.rnd.pick(c.COLORS)
        [x, y] = conv.tileToWorld(x, y)
        super game, x, y, "#{@color}_square"
        this.anchor.set(0.5)
        game.physics.arcade.enable(this)
        this.inputEnabled = true
        this.input.enableDrag false, false, false, 255,
            new Phaser.Rectangle 0, 0, game.world.width, game.world.height
        this.input.enableSnap c.TILE_SIZE, c.TILE_SIZE, false, true
        this.events.onInputDown.add =>
            [this.prevX, this.prevY] = [this.x, this.y]
        this.events.onInputUp.add =>
            console.log(this.input.dragStartPoint.x, this.input.dragStartPoint.y)
            
module.exports = Jewel