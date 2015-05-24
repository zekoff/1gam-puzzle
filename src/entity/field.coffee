c = require '../util/const'
Jewel = require '../entity/jewel'
conv = require '../util/convert'

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
        
    clearJewel: (jewel, toDestroy) ->
        [x, y] = conv.worldToTile(jewel.x, jewel.y)
        adjacent = []
        # left
        if x > 0
            adj = @getAdjacentJewel jewel, -1, 0
            if adj and adj not in toDestroy and adj.color is jewel.color
                adjacent.push adj
                toDestroy.push adj
        # up
        if y > 0
            adj = @getAdjacentJewel jewel, 0, -1
            if adj and adj not in toDestroy and adj.color is jewel.color
                adjacent.push adj
                toDestroy.push adj
        # right
        if x < c.FIELD_WIDTH - 1
            adj = @getAdjacentJewel jewel, 1, 0
            if adj and adj not in toDestroy and adj.color is jewel.color
                adjacent.push adj
                toDestroy.push adj
        # down
        if y < c.FIELD_HEIGHT - 1
            adj = @getAdjacentJewel jewel, 0, 1
            if adj and adj not in toDestroy and adj.color is jewel.color
                adjacent.push adj
                toDestroy.push adj
        for j in adjacent when j.color is jewel.color
            @clearJewel j, toDestroy
            
    getAdjacentJewel: (jewel, x,y) ->
        game.physics.arcade.getObjectsAtLocation(jewel.x + x * c.TILE_SIZE,
            jewel.y + y * c.TILE_SIZE, this)[0]
        
module.exports = Field