constants = require '../util/const'
Jewel = require '../entity/jewel'

###
A Field is where all the jewels are held, and where the action takes place. It
provides a nice interface to a tile-driven coordinate system instead of the
pixel-driven system of the Phaser game world. It can be offset inside the game
world to account for HUD elements around the edges.
###
class Field
    constructor: (xOffset = 0, yOffset = 0) ->
        @width = constants.FIELD_WIDTH
        @height = constants.FIELD_HEIGHT
        @jewels = game.add.group()
        for i in [0..@width - 1]
            for j in [0..@height - 1]
                @jewels.add new Jewel(i, j)
    
    getAdjacentJewels: (jewel) ->
        console.log 'returning adjacent jewels'
        
module.exports = Field