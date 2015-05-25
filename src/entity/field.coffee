c = require '../util/const'
Jewel = require '../entity/jewel'
conv = require '../util/convert'

###
A Field is where all the jewels are held, and where the action takes place. It
provides a nice interface to a tile-driven coordinate system instead of the
pixel-driven system of the Phaser game world. It can be offset inside the game
world to account for HUD elements around the edges.

In a less Phaser-specific implementation, Field could contain a two-dimensional
array of Jewels, addressed by their row and column. This would make the process
of getting a particular jewel a little more straightforward.
###
class Field extends Phaser.Group
    constructor: (x = 0, y = 0) ->
        super(game)
        @x = x; @y = y
        for i in [0..c.FIELD_WIDTH - 1]
            for j in [0..c.FIELD_HEIGHT - 1]
                @add new Jewel(@, i, j)
                
    currentJewel: null
    
    getAdjacentJewels: (jewel) ->
        console.log 'returning adjacent jewels'
        
    destroyJewel: (jewel) ->
        toDestroy = []
        toDestroy.push jewel
        @clearJewel jewel, toDestroy
        # calculate score based on toDestroy.length
        toDestroy.forEach (j) =>
            newJ = new Jewel(@, j.tileX, j.tileY)
            newJ.scale.set(0)
            @.add(newJ)
            game.tweens.create(newJ.scale).to({
                x: 1
                y: 1
            }, 300).start()
            emitter = game.add.emitter(j.x + @x, j.y + @y)
            emitter.makeParticles("#{j.color}_square")
            emitter.setScale(0.2, 0.4, 0.2, 0.4)
            # despite what the docs say, must explicitly pass # of particles
            emitter.start(true, 200, null, 10)
            j.kill()
            
    swapCurrentJewelWith: (target) ->
        [oldX, oldY] = [@currentJewel.prevX, @currentJewel.prevY]
        @currentJewel.sendToTile(target.tileX, target.tileY)
        target.sendToTile(oldX, oldY)
        
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
                
    getAdjacentJewel: (jewel, x, y) ->
        game.physics.arcade.getObjectsAtLocation(@x + jewel.x + x * c.TILE_SIZE,
            @y + jewel.y + y * c.TILE_SIZE, @)[0]
        
module.exports = Field