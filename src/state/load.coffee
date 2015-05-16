state = {}

state.preload = ->
    state.load.baseURL = './assets/'

state.create = ->
    state.load.image 'blue_square', 'element_blue_square.png'
    state.load.start()
    
state.update = ->
    state.game.state.start 'title' if state.load.hasLoaded

module.exports = state