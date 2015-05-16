state = {}

state.create = ->
    console.log 'created title screen'
    
state.update = ->
    game.state.start 'main'

module.exports = state