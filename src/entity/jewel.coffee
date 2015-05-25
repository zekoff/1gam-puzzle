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
        @events.onInputDown.add =>
            @bringToTop()
            [@prevX, @prevY] = [@tileX, @tileY]
            @field.currentJewel = @
        @events.onInputUp.add =>
            underPointer = game.physics.arcade.getObjectsUnderPointer(
                game.input.activePointer, @field)
            if underPointer.length is 1
                @field.destroyJewel(@field.currentJewel)
            else if underPointer.length > 1 # should never be > 2
                targetJewel = null
                underPointer.forEach (jewel) =>
                    if jewel != @field.currentJewel
                        targetJewel = jewel
                @field.swapCurrentJewelWith targetJewel
            @field.currentJewel = null

    sendToTile: (tx, ty) ->
        @bringToTop()
        @tileX = tx
        @tileY = ty
        @prevX = tx
        @prevY = ty
        tween = game.tweens.create(@).to({
            x:tx * c.TILE_SIZE + c.TILE_SIZE / 2
            y:ty * c.TILE_SIZE + c.TILE_SIZE / 2
        }, c.TWEEN_TIME_MS).start()
            
module.exports = Jewel