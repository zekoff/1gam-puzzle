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
        state.physics.arcade.getObjectsUnderPointer state.input.activePointer,
            jewels, (pointer, jewel)->
                console.log jewel
                [x, y] = conv.worldToTile jewel.x, jewel.y
                #jewel.kill() if jewel.color is 'blue'
                clearJewel(jewel, jewel.color)
        # get Jewel under pointer
        # recursive foreach adjacent jewel
        # destroy
    
state.update = ->

clearJewel = (jewel, color) ->
    [x, y] = conv.worldToTile(jewel.x, jewel.y)
    console.log x, y
    adjacent = []
    # left
    if x > 0 then adjacent.push getAdjacentJewel jewel, -1, 0
    # up
    if y > 0 then adjacent.push getAdjacentJewel jewel, 0, -1
    # right
    if x < 9 then adjacent.push getAdjacentJewel jewel, 1, 0
    # down
    if y < 9 then adjacent.push getAdjacentJewel jewel, 0, 1
    jewel.kill()
    for j in adjacent when j.color is color
        if j
            clearJewel j, color

getAdjacentJewel = (jewel, x, y) ->
    state.physics.arcade.getObjectsAtLocation(jewel.x + x * c.TILE_SIZE,
        jewel.y + y * c.TILE_SIZE, jewels)[0]
    
module.exports = state