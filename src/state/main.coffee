state = {}
blue = null

state.create = ->
    blue = state.add.sprite 0, 0, 'blue_square'
    
state.update = ->
    blue.x += 1
    blue.y += 1
    
module.exports = state