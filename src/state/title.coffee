state = {}

state.create = ->
    console.log 'created title screen'
    
state.update = ->
    state.game.state.start 'main'

module.exports = state