c = require '../util/const'
Jewel = require '../entity/jewel'

###
A Field is where all the jewels are held, and where the action takes place. It
provides a nice interface to a tile-driven coordinate system instead of the
pixel-driven system of the Phaser game world. It can be offset inside the game
world to account for HUD elements around the edges.
###
class Field extends Phaser.Group
    constructor: (x = 0, y = 0) ->
        super(game)
        @x = x; @y = y
        for i in [0..c.FIELD_WIDTH - 1]
            for j in [0..c.FIELD_HEIGHT - 1]
                @add new Jewel(i, j)
    
    getAdjacentJewels: (jewel) ->
        console.log 'returning adjacent jewels'
        
module.exports = Field