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
            [@prevX, @prevY] = [@tileX, @tileY]
            @field.currentJewel = @
        @events.onInputUp.add =>
            # swap, destroy, or return to initial location
            underPointer = game.physics.arcade.getObjectsUnderPointer(
                game.input.activePointer, @field)
            if underPointer.length is 1
                # destroy
                underPointer.forEach (jewel) =>
                    console.log jewel.color
                    toDestroy = []
                    toDestroy.push jewel
                    @field.clearJewel jewel, toDestroy
                    toDestroy.forEach (j) ->
                        j.kill()
            else if underPointer.length > 1 # should never be > 2
                # swap
                targetJewel = null
                underPointer.forEach (jewel) =>
                    if jewel != @field.currentJewel
                        targetJewel = jewel
                # drop currentJewel to this tile
                [oldX, oldY] = [@field.currentJewel.prevX, @field.currentJewel.prevY]
                @sendToTile(@field.currentJewel, targetJewel.tileX, targetJewel.tileY)
                # tween targetJewel to old tile of currentJewel
                @sendToTile(targetJewel, oldX, oldY)
            @field.currentJewel = null
            
    sendToTile: (jewel, tx, ty) ->
        jewel.tileX = tx
        jewel.tileY = ty
        jewel.prevX = tx
        jewel.prevY = ty
        tween = game.tweens.create(jewel)
        tween.to({
            x:tx * c.TILE_SIZE + c.TILE_SIZE / 2,
            y:ty * c.TILE_SIZE + c.TILE_SIZE / 2}
        , c.TWEEN_TIME_MS).start()
            
module.exports = Jewel