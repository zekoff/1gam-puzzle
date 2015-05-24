c = require('../util/const')
conv = require('../util/convert')

###
Jewels are Phaser.Sprites with some extra data attached.
* @tileX: the X location in the Field where the jewel is
* @tileY: same, but Y location
* @prevX: X location in the Field where the Tile was before it was dragged
* @prevY: same, but Y location
The prevX/Y locations are updated during pointer onInputUp events if the jewel
has been moved to a different location.
###
class Jewel extends Phaser.Sprite
    constructor: (@field, @tileX, @tileY, @color) ->
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
            @field.currentJewel = @
        @events.onInputUp.add =>
            # swap, destroy, or return to initial location
            @field.currentJewel = null
            underPointer = game.physics.arcade.getObjectsUnderPointer(
                game.input.activePointer, @field)
            if underPointer.length is 1
                underPointer.forEach (jewel) =>
                    console.log jewel.color
                    toDestroy = []
                    toDestroy.push jewel
                    @field.clearJewel jewel, toDestroy
                    toDestroy.forEach (j) ->
                        j.kill()
            else if underPointer.length > 1
                console.log 'swap'
                #swap jewels
                underPointer.forEach (jewel) ->
                    [jewel.x, jewel.y] = [jewel.prevX, jewel.prevY]
                    jewel.body.reset(jewel.x, jewel.y)
            
module.exports = Jewel