Jewel = require('../entity/jewel')
c = require('../util/const')
conv = require('../util/convert')

state = {}
jewels = null

state.create = ->
    jewels = state.add.group()
    for i in [0..c.FIELD_WIDTH - 1]
        for j in [0..c.FIELD_HEIGHT - 1]
            jewels.add state.add.existing new Jewel conv.tileToWorld(i, j)...
    state.input.onUp.add ->
        underPointer = state.physics.arcade.getObjectsUnderPointer(
            state.input.activePointer, jewels)
        if underPointer.length is 1
            underPointer.forEach (jewel) ->
                console.log jewel.color
                toDestroy = []
                toDestroy.push jewel
                clearJewel jewel, toDestroy
                toDestroy.forEach (j) ->
                    j.kill()
        else if underPointer.length > 1
            console.log 'swap'
            #swap jewels
            underPointer.forEach (jewel) ->
                [jewel.x, jewel.y] = [jewel.prevX, jewel.prevY]
                jewel.body.reset(jewel.x, jewel.y)
    
state.update = ->

clearJewel = (jewel, toDestroy) ->
    [x, y] = conv.worldToTile(jewel.x, jewel.y)
    console.log x, y
    adjacent = []
    # left
    if x > 0
        adj = getAdjacentJewel jewel, -1, 0
        if adj and adj not in toDestroy and adj.color is jewel.color
            adjacent.push adj
            toDestroy.push adj
    # up
    if y > 0
        adj = getAdjacentJewel jewel, 0, -1
        if adj and adj not in toDestroy and adj.color is jewel.color
            adjacent.push adj
            toDestroy.push adj
    # right
    if x < c.FIELD_WIDTH - 1
        adj = getAdjacentJewel jewel, 1, 0
        if adj and adj not in toDestroy and adj.color is jewel.color
            adjacent.push adj
            toDestroy.push adj
    # down
    if y < c.FIELD_HEIGHT - 1
        adj = getAdjacentJewel jewel, 0, 1
        if adj and adj not in toDestroy and adj.color is jewel.color
            adjacent.push adj
            toDestroy.push adj
    for j in adjacent when j.color is jewel.color
        clearJewel j, toDestroy

getAdjacentJewel = (jewel, x, y) ->
    state.physics.arcade.getObjectsAtLocation(jewel.x + x * c.TILE_SIZE,
        jewel.y + y * c.TILE_SIZE, jewels)[0]
    
module.exports = state